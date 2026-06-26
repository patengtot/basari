<?php

namespace App\Http\Controllers;

use App\Helpers\NotificationHelper;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class MidtransController extends Controller
{
    private function setupMidtrans()
    {
        \Midtrans\Config::$serverKey    = config('midtrans.server_key');
        \Midtrans\Config::$isProduction = config('midtrans.is_production');
        \Midtrans\Config::$isSanitized  = config('midtrans.is_sanitized');
        \Midtrans\Config::$is3ds        = config('midtrans.is_3ds');
    }

    public function pay($id)
    {
        $order = Order::with('items')->where('user_id', Auth::id())->findOrFail($id);

        if ($order->status !== 'pending') {
            return back()->with('error', 'Pesanan ini sudah diproses.');
        }

        if ($order->shipping_type === 'international') {
            return back()->with('error', 'Pesanan internasional menggunakan PayPal.');
        }

        $this->setupMidtrans();

        $items = $order->items->map(fn($item) => [
            'id'       => (string) $item->id,
            'price'    => (int) $item->product_price,
            'quantity' => $item->quantity,
            'name'     => substr($item->product_name, 0, 50),
        ])->toArray();

        // Tambah ongkir sebagai item
        if ($order->shipping_cost > 0) {
            $items[] = [
                'id'       => 'SHIPPING',
                'price'    => (int) $order->shipping_cost,
                'quantity' => 1,
                'name'     => 'Ongkos Kirim (' . strtoupper($order->courier ?? '') . ')',
            ];
        }

        $params = [
            'transaction_details' => [
                'order_id'      => $order->invoice_number . '-' . time(),
                'gross_amount'  => (int) $order->total_amount,
            ],
            'item_details'    => $items,
            'customer_details' => [
                'first_name' => $order->shipping_name,
                'email'      => $order->email,
                'phone'      => $order->phone,
                'billing_address' => [
                    'first_name' => $order->shipping_name,
                    'phone'      => $order->phone,
                    'address'    => $order->shipping_address,
                    'city'       => $order->shipping_city,
                    'postal_code' => $order->shipping_postal,
                    'country_code' => 'IDN',
                ],
                'shipping_address' => [
                    'first_name' => $order->shipping_name,
                    'phone'      => $order->phone,
                    'address'    => $order->shipping_address,
                    'city'       => $order->shipping_city,
                    'postal_code' => $order->shipping_postal,
                    'country_code' => 'IDN',
                ],
            ],
            'callbacks' => [
                'finish' => route('orders.show', $order->id),
            ],
        ];

        try {
            $snapToken = \Midtrans\Snap::getSnapToken($params);
            $order->update(['payment_ref' => $snapToken]);

            return view('frontend.payment.midtrans', compact('order', 'snapToken'));

        } catch (\Exception $e) {
            Log::error('Midtrans error: ' . $e->getMessage());
            return back()->with('error', 'Gagal membuat pembayaran. Silakan coba lagi.');
        }
    }

    public function notification(Request $request)
    {
        $this->setupMidtrans();

        try {
            $notification = new \Midtrans\Notification();

            $transactionStatus = $notification->transaction_status;
            $fraudStatus       = $notification->fraud_status;
            $orderId           = $notification->order_id;

            Log::info('Midtrans notification', [
                'order_id'           => $orderId,
                'transaction_status' => $transactionStatus,
                'fraud_status'       => $fraudStatus,
            ]);

            // Ambil invoice number — format: BSR-XXXXXXXX-timestamp
            $invoiceNumber = substr($orderId, 0, 12);
            $order = Order::where('invoice_number', $invoiceNumber)->first();

            if (!$order) {
                return response('order not found', 404);
            }

            if ($transactionStatus === 'capture') {
                if ($fraudStatus === 'accept') {
                    $this->markAsPaid($order);
                }
            } elseif ($transactionStatus === 'settlement') {
                $this->markAsPaid($order);
            } elseif (in_array($transactionStatus, ['cancel', 'deny', 'expire'])) {
                $order->update(['status' => 'cancelled']);
            } elseif ($transactionStatus === 'pending') {
                // Biarkan tetap pending
            }

            return response('ok', 200);

        } catch (\Exception $e) {
            Log::error('Midtrans notification error: ' . $e->getMessage());
            return response('error', 500);
        }
    }

    private function markAsPaid(Order $order)
    {
        if ($order->status === 'paid') return;

        $order->update([
            'status'  => 'paid',
            'paid_at' => now(),
        ]);

        NotificationHelper::toUser(
            $order->user_id,
            'Pembayaran Dikonfirmasi',
            "Pembayaran pesanan {$order->invoice_number} telah dikonfirmasi. Pesanan kamu sedang diproses.",
            route('orders.show', $order->id)
        );

        NotificationHelper::toAdmin(
            'Pembayaran Diterima',
            "Pembayaran pesanan {$order->invoice_number} dari {$order->shipping_name} telah berhasil.",
            route('admin.orders.show', $order->id)
        );

        try {
            Mail::to(config('mail.admin_email', env('ADMIN_EMAIL')))
                ->send(new \App\Mail\NewOrderMail($order));
        } catch (\Exception $e) {
            Log::error('Gagal kirim email: ' . $e->getMessage());
        }
    }
}