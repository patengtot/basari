<?php

namespace App\Http\Controllers;

use App\Helpers\CurrencyHelper;
use App\Helpers\NotificationHelper;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Srmklive\PayPal\Services\PayPal as PayPalClient;

class PayPalController extends Controller
{
    private function getPayPalClient(): PayPalClient
    {
        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $provider->setAccessToken($provider->getAccessToken());
        return $provider;
    }

    public function pay($id)
    {
        $order = Order::with('items')->where('user_id', Auth::id())->findOrFail($id);

        if ($order->status !== 'pending') {
            return back()->with('error', 'Pesanan ini sudah diproses.');
        }

        if ($order->shipping_type !== 'international') {
            return redirect()->route('payment.pay', $id);
        }

        $currency = $order->preferred_currency ?? 'USD';

        // Kalau currency IDR, konversi ke USD untuk PayPal
        $currency = 'USD';

        $amount = round(CurrencyHelper::convert($order->total_amount, $currency), 2);

        try {
            $provider = $this->getPayPalClient();

            // Buat item list
            $items = $order->items->map(fn($item) => [
                'name'        => $item->product_name,
                'description' => $item->product_name . ($item->size ? ' (' . $item->size . ')' : ''),
                'quantity'    => (string) $item->quantity,
                'unit_amount' => [
                    'currency_code' => $currency,
                    'value'         => number_format(
                        round(CurrencyHelper::convert($item->product_price, $currency), 2),
                        2, '.', ''
                    ),
                ],
            ])->toArray();

            // Tambah ongkir sebagai item terpisah kalau ada
            $shippingAmount = round(CurrencyHelper::convert($order->shipping_cost, $currency), 2);
            if ($shippingAmount > 0) {
                $items[] = [
                    'name'        => 'Shipping Cost',
                    'description' => 'International Shipping via ' . ($order->intl_courier ?? 'Courier'),
                    'quantity'    => '1',
                    'unit_amount' => [
                        'currency_code' => $currency,
                        'value'         => number_format($shippingAmount, 2, '.', ''),
                    ],
                ];
            }

            $order_data = [
                'intent' => 'CAPTURE',
                'application_context' => [
                    'return_url'  => route('paypal.success', $order->id),
                    'cancel_url'  => route('orders.show', $order->id),
                    'brand_name'  => 'Basari.id',
                    'locale'      => 'en-US',
                    'user_action' => 'PAY_NOW',
                ],
                'purchase_units' => [
                    [
                        'reference_id' => $order->invoice_number,
                        'description'  => 'Order ' . $order->invoice_number . ' — Basari.id',
                        'amount'       => [
                            'currency_code' => $currency,
                            'value'         => number_format($amount, 2, '.', ''),
                            'breakdown'     => [
                                'item_total' => [
                                    'currency_code' => $currency,
                                    'value'         => number_format($amount, 2, '.', ''),
                                ],
                            ],
                        ],
                        'items' => $items,
                    ],
                ],
            ];

            $response = $provider->createOrder($order_data);

            if (isset($response['id']) && $response['status'] === 'CREATED') {
                // Simpan PayPal order ID
                $order->update(['payment_ref' => $response['id']]);

                // Redirect ke PayPal approval URL
                foreach ($response['links'] as $link) {
                    if ($link['rel'] === 'approve') {
                        return redirect($link['href']);
                    }
                }
            }

            Log::error('PayPal create order failed', $response);
            return back()->with('error', 'Gagal membuat pembayaran PayPal. Silakan coba lagi.');

        } catch (\Exception $e) {
            Log::error('PayPal error: ' . $e->getMessage());
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
        }
    }

    public function success(Request $request, $id)
    {
        $order = Order::where('user_id', Auth::id())->findOrFail($id);

        $token = $request->query('token');

        if (!$token) {
            return redirect()->route('orders.show', $id)
                ->with('error', 'Token PayPal tidak ditemukan.');
        }

        try {
            $provider = $this->getPayPalClient();
            $response = $provider->capturePaymentOrder($token);

            Log::info('PayPal capture response', $response);

            if (isset($response['status']) && $response['status'] === 'COMPLETED') {
                $order->update([
                    'status'  => 'paid',
                    'paid_at' => now(),
                ]);

                NotificationHelper::toUser(
                    $order->user_id,
                    'Pembayaran PayPal Dikonfirmasi',
                    "Pembayaran pesanan {$order->invoice_number} via PayPal telah berhasil dikonfirmasi.",
                    route('orders.show', $order->id)
                );

                NotificationHelper::toAdmin(
                    'Pembayaran PayPal Diterima',
                    "Pembayaran internasional {$order->invoice_number} dari {$order->shipping_name} berhasil via PayPal.",
                    route('admin.orders.show', $order->id)
                );

                try {
                    Mail::to(config('mail.admin_email', env('ADMIN_EMAIL')))
                        ->send(new \App\Mail\NewOrderMail($order));
                } catch (\Exception $e) {
                    Log::error('Gagal kirim email: ' . $e->getMessage());
                }

                return redirect()->route('orders.show', $order->id)
                    ->with('success', 'Pembayaran PayPal berhasil! Pesanan kamu sedang diproses.');
            }

            Log::error('PayPal capture failed', $response);
            return redirect()->route('orders.show', $order->id)
                ->with('error', 'Pembayaran PayPal gagal dikonfirmasi. Silakan hubungi admin.');

        } catch (\Exception $e) {
            Log::error('PayPal capture error: ' . $e->getMessage());
            return redirect()->route('orders.show', $order->id)
                ->with('error', 'Terjadi kesalahan saat konfirmasi pembayaran.');
        }
    }

    public function cancel($id)
    {
        return redirect()->route('orders.show', $id)
            ->with('error', 'Pembayaran PayPal dibatalkan.');
    }
}