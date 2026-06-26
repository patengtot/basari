<?php

namespace App\Http\Controllers;

use App\Helpers\NotificationHelper;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use App\Mail\NewOrderMail;
use App\Mail\OrderStatusMail;

class PaymentController extends Controller
{
    private function signature($body)
    {
        $va      = config('ipaymu.va');
        $apiKey  = config('ipaymu.api_key');
        $jsonBody = json_encode($body, JSON_UNESCAPED_SLASHES);
        $hashedBody = strtolower(hash('sha256', $jsonBody));
        $stringToSign = 'POST:' . $va . ':' . $hashedBody . ':' . $apiKey;
        return hash_hmac('sha256', $stringToSign, $apiKey);
    }

    public function pay($id)
{
    $order = Order::with('items')->where('user_id', Auth::id())->findOrFail($id);

    if ($order->status !== 'pending') {
        return back()->with('error', 'Pesanan ini sudah diproses.');
    }

    $va     = config('ipaymu.va');
    $apiKey = config('ipaymu.api_key');
    $url    = config('ipaymu.url');

    // Susun item dari pesanan
    $products     = $order->items->pluck('product_name')->toArray();
    $quantities   = $order->items->pluck('quantity')->toArray();
    $prices       = $order->items->map(fn($i) => (int) $i->product_price)->toArray();
    $descriptions = $order->items->pluck('product_name')->toArray();

    // Tambahkan ongkir sebagai item terpisah
    if ($order->shipping_cost > 0) {
        $products[]     = 'Ongkos Kirim (' . strtoupper($order->courier) . ' ' . $order->courier_service . ')';
        $quantities[]   = 1;
        $prices[]       = (int) $order->shipping_cost;
        $descriptions[] = 'Biaya pengiriman';
    }

    $body = [
        'account'        => $va,
        'orderId'        => $order->invoice_number,
        'notifyUrl'      => route('payment.notify'),
        'returnUrl'      => route('orders.show', $order->id),
        'cancelUrl'      => route('orders.show', $order->id),
        'referenceId'    => $order->invoice_number,
        'product'        => $products,
        'qty'            => $quantities,
        'price'          => $prices,
        'description'    => $descriptions,
        'buyerName'      => $order->shipping_name,
        'buyerEmail'     => $order->email,
        'buyerPhone'     => $order->phone,
        'amount'         => (int) $order->total_amount,
    ];

    $signature = $this->signature($body);

    $response = Http::withHeaders([
        'Content-Type' => 'application/json',
        'va'           => $va,
        'signature'    => $signature,
        'timestamp'    => date('YmdHis'),
    ])->post($url . '/payment', $body);

    $result = $response->json();

    if (isset($result['Data']['Url'])) {
        session(['payment_url_' . $order->id => $result['Data']['Url']]);
        return redirect($result['Data']['Url']);
    }

    Log::error('iPaymu error', $result);
    return back()->with('error', 'Gagal membuat pembayaran. Silakan coba lagi.');
}

    public function notify(Request $request)
    {
        // Webhook dari iPaymu
        $data = $request->all();

        Log::info('iPaymu webhook', $data);

        $referenceId = $data['reference_id'] ?? $data['referenceId'] ?? null;
        $status      = $data['status'] ?? $data['Status'] ?? null;

        if (!$referenceId) {
            return response('invalid', 400);
        }

        $order = Order::where('invoice_number', $referenceId)->first();

        if (!$order) {
            return response('order not found', 404);
        }

        // Status 'berhasil' atau '1' = paid di iPaymu
        if (in_array(strtolower($status), ['berhasil', 'success', '1', 'paid'])) {
            $order->update([
                'status'  => 'paid',
                'paid_at' => now(),
            ]);

            // Notifikasi ke customer
            NotificationHelper::toUser(
                $order->user_id,
                'Pembayaran Dikonfirmasi',
                "Pembayaran pesanan {$order->invoice_number} telah dikonfirmasi. Pesanan kamu sedang diproses.",
                route('orders.show', $order->id)
            );

            // Notifikasi ke admin
            NotificationHelper::toAdmin(
                'Pembayaran Diterima',
                "Pembayaran pesanan {$order->invoice_number} dari {$order->shipping_name} telah berhasil.",
                route('admin.orders.show', $order->id)
            );
            try {
                // Email ke admin
                \Illuminate\Support\Facades\Mail::to(config('mail.admin_email', env('ADMIN_EMAIL')))
                    ->send(new \App\Mail\NewOrderMail($order));

                // Email ke pembeli
                \Illuminate\Support\Facades\Mail::to($order->email)
                    ->send(new \App\Mail\OrderStatusMail($order, 'Pembayaran Dikonfirmasi'));

            } catch (\Exception $e) {
                \Log::error('Gagal kirim email notifikasi pesanan: ' . $e->getMessage());
            }
        }

        return response('ok', 200);
    }
}