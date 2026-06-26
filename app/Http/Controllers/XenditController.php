<?php

namespace App\Http\Controllers;

use App\Helpers\CurrencyHelper;
use App\Helpers\NotificationHelper;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class XenditController extends Controller
{
    private function getInvoiceApi(): \Xendit\Invoice\InvoiceApi
{
    \Xendit\Configuration::setXenditKey(config('xendit.secret_key'));

    return new \Xendit\Invoice\InvoiceApi(
        new \GuzzleHttp\Client(),
        \Xendit\Configuration::getDefaultConfiguration()
    );
}

    public function pay($id)
    {
        $order = Order::with('items')->where('user_id', Auth::id())->findOrFail($id);

        if ($order->status !== 'pending') {
            return back()->with('error', 'Pesanan ini sudah diproses.');
        }

        $currency = $order->preferred_currency ?? 'IDR';

        $amount = $currency === 'IDR'
            ? (int) $order->total_amount
            : round(CurrencyHelper::convert($order->total_amount, $currency), 2);

        try {
            $invoiceApi = $this->getInvoiceApi();

            $params = [
                'external_id'          => $order->invoice_number . '-' . Str::random(6),
                'amount'               => $amount,
                'currency'             => $currency,
                'payer_email'          => $order->email,
                'description'          => 'Pesanan ' . $order->invoice_number . ' — Basari.id',
                'success_redirect_url' => route('xendit.success', $order->id),
                'failure_redirect_url' => route('orders.show', $order->id),
                'invoice_duration'     => 86400,
                'items'                => $order->items->map(fn($item) => [
                    'name'     => $item->product_name,
                    'quantity' => $item->quantity,
                    'price'    => $currency === 'IDR'
                        ? (int) $item->product_price
                        : round(CurrencyHelper::convert($item->product_price, $currency), 2),
                    'category' => 'Fashion',
                ])->toArray(),
                'customer'             => [
                    'given_names'   => $order->shipping_name,
                    'email'         => $order->email,
                    'mobile_number' => $order->phone,
                ],
                'customer_notification_preference' => [
                    'invoice_created'  => ['email'],
                    'invoice_reminder' => ['email'],
                    'invoice_paid'     => ['email'],
                ],
            ];

            $invoice = $invoiceApi->createInvoice($params);

            if (isset($invoice['invoice_url'])) {
                $order->update(['xendit_invoice_id' => $invoice['id']]);
                return redirect($invoice['invoice_url']);
            }

            Log::error('Xendit create invoice failed', (array) $invoice);
            return back()->with('error', 'Gagal membuat pembayaran. Silakan coba lagi.');

        } catch (\Exception $e) {
            Log::error('Xendit error: ' . $e->getMessage());
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
        }
    }

    public function success(Request $request, $id)
    {
        $order = Order::where('user_id', Auth::id())->findOrFail($id);

        try {
            $invoiceApi = $this->getInvoiceApi();
            $invoice    = $invoiceApi->getInvoiceById($order->xendit_invoice_id);

            if (isset($invoice['status']) && $invoice['status'] === 'PAID') {
                $order->update([
                    'status'  => 'paid',
                    'paid_at' => now(),
                ]);

                NotificationHelper::toUser(
                    $order->user_id,
                    'Pembayaran Dikonfirmasi',
                    "Pembayaran pesanan {$order->invoice_number} telah dikonfirmasi.",
                    route('orders.show', $order->id)
                );

                NotificationHelper::toAdmin(
                    'Pembayaran Diterima',
                    "Pembayaran {$order->invoice_number} dari {$order->shipping_name} berhasil.",
                    route('admin.orders.show', $order->id)
                );

                try {
                    Mail::to(config('mail.admin_email', env('ADMIN_EMAIL')))
                        ->send(new \App\Mail\NewOrderMail($order));
                } catch (\Exception $e) {
                    Log::error('Gagal kirim email: ' . $e->getMessage());
                }
            }

        } catch (\Exception $e) {
            Log::error('Xendit retrieve error: ' . $e->getMessage());
        }

        return redirect()->route('orders.show', $order->id)
            ->with('success', 'Pembayaran berhasil! Pesanan kamu sedang diproses.');
    }

    public function webhook(Request $request)
    {
        $webhookToken = $request->header('x-callback-token');
        if ($webhookToken !== config('xendit.webhook_token')) {
            return response('Unauthorized', 401);
        }

        $data       = $request->all();
        $status     = $data['status'] ?? null;
        $externalId = $data['external_id'] ?? null;

        Log::info('Xendit webhook', $data);

        if (!$externalId) {
            return response('invalid', 400);
        }

        // Ambil invoice_number dari external_id (format: BSR-XXXXXXXX-XXXXXX)
        $invoiceNumber = substr($externalId, 0, 12);

        $order = Order::where('invoice_number', $invoiceNumber)->first();

        if (!$order) {
            return response('order not found', 404);
        }

        if ($status === 'PAID' && $order->status !== 'paid') {
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
                "Pembayaran {$order->invoice_number} dari {$order->shipping_name} telah berhasil.",
                route('admin.orders.show', $order->id)
            );

            try {
                Mail::to(config('mail.admin_email', env('ADMIN_EMAIL')))
                    ->send(new \App\Mail\NewOrderMail($order));
            } catch (\Exception $e) {
                Log::error('Gagal kirim email: ' . $e->getMessage());
            }
        }

        return response('ok', 200);
    }
}