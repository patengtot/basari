<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ShippingController extends Controller
{
    private function headers()
    {
        return [
            'Authorization' => 'Bearer ' . config('biteship.api_key'),
            'Content-Type'  => 'application/json',
        ];
    }

    public function searchLocation(Request $request)
    {
        $keyword = $request->get('keyword', '');

        try {
            $response = Http::withHeaders($this->headers())
                            ->get(config('biteship.url') . '/v1/maps/areas', [
                                'countries' => 'ID',
                                'input'     => $keyword,
                                'type'      => 'single',
                            ]);

            if ($response->successful()) {
                return response()->json($response->json()['areas'] ?? []);
            }
        } catch (\Exception $e) {}

        return response()->json([]);
    }

    public function getRates(Request $request)
{
    $isInternational = $request->boolean('is_international');

    if ($isInternational) {
        $request->validate([
            'origin_postal_code'       => 'required',
            'destination_postal_code'  => 'required',
            'destination_country_code' => 'required|string|max:5',
            'weight'                   => 'required|integer|min:1',
        ]);
    } else {
        $request->validate([
            'origin_postal_code'      => 'required',
            'destination_postal_code' => 'required',
            'weight'                  => 'required|integer|min:1',
        ]);
    }

    try {
        if ($isInternational) {
            $payload = [
                'origin_postal_code'       => $request->origin_postal_code,
                'destination_postal_code'  => $request->destination_postal_code,
                'destination_country_code' => strtoupper($request->destination_country_code),
                'couriers'                 => 'tlx,pos,sicepat,jnt',
                'items' => [
                    [
                        'length'   => 20,
                        'width'    => 15,
                        'height'   => 10,
                        'weight'   => $request->weight,
                        'quantity' => 1,
                        'value'    => $request->item_value ?? 100000,
                        'name'     => 'Produk Basari',
                    ]
                ],
            ];
        } else {
            $payload = [
                'origin_postal_code'      => $request->origin_postal_code,
                'destination_postal_code' => $request->destination_postal_code,
                'couriers'                => 'jne,sicepat,jnt,pos',
                'items' => [
                    [
                        'name'     => 'Produk Basari',
                        'value'    => $request->item_value ?? 100000,
                        'weight'   => $request->weight,
                        'quantity' => 1,
                        'category' => 'fashion',
                    ]
                ],
            ];
        }

        $response = Http::withHeaders($this->headers())
                        ->post(config('biteship.url') . '/v1/rates/couriers', $payload);

        if ($response->successful()) {
            $pricing = $response->json()['pricing'] ?? [];
            return response()->json([
                'success' => true,
                'rates'   => $pricing,
            ]);
        }

        return response()->json([
            'success' => false,
            'status'  => $response->status(),
            'body'    => $response->json(),
            'message' => 'Gagal mendapatkan ongkos kirim.',
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => $e->getMessage(),
        ]);
    }
}

    public function tracking(Request $request)
    {
        $request->validate(['tracking_id' => 'required|string']);

        try {
            $response = Http::withHeaders($this->headers())
                            ->get(config('biteship.url') . '/v1/trackings/' . $request->tracking_id);

            if ($response->successful()) {
                return response()->json($response->json());
            }
        } catch (\Exception $e) {}

        return response()->json(['success' => false]);
    }

    public function createOrder(Request $request)
    {
        $request->validate(['order_id' => 'required']);

        $order           = \App\Models\Order::findOrFail($request->order_id);
        $isInternational = $order->shipping_type === 'international';

        try {
            $payload = [
                'shipper_contact_name'      => 'Basari Store',
                'shipper_contact_phone'     => '087738997811',
                'shipper_contact_email'     => 'basari@gmail.com',
                'shipper_organization'      => 'Basari',
                'origin_contact_name'       => 'Basari Store',
                'origin_contact_phone'      => '087738997811',
                'origin_address'            => 'Komplek Singgasana Pradana, Jl. Tarumanagara Timur No.33',
                'origin_postal_code'        => 40237,
                'destination_contact_name'  => $order->shipping_name,
                'destination_contact_phone' => $order->phone,
                'destination_address'       => $order->shipping_address,
                'destination_postal_code'   => (int) $order->destination_postal_code,
                'courier_company'           => $order->courier,
                'courier_type'              => $isInternational ? 'international' : $order->courier_service,
                'delivery_type'             => 'now',
                'order_note'                => $order->notes ?? 'Terima kasih sudah berbelanja di Basari',
                'items'                     => $order->items->map(fn($item) => [
                    'name'        => $isInternational
                     ? ($item->product_name_en ?? $item->product_name)
                     : $item->product_name,
                'description' => $isInternational
                                    ? 'Fashion clothing item'
                                    : $item->product_name,
                'value'       => (int) $item->product_price,
                'weight'      => $item->product->weight ?? 500,
                'length'      => $item->product->length ?? 30,
                'width'       => $item->product->width ?? 25,
                'height'      => $item->product->height ?? 5,
                'quantity'    => $item->quantity,
                'category'    => 'fashion',
                'hs_code'     => $isInternational ? '6105.10.00' : null,
                ])->toArray(),
                ...($isInternational ? [
                    'metadata' => [
                        'customs_currency'         => 'USD',
                        'customs_declaration_type' => 'sale',
                    ]
                ] : []),
            ];

            if ($isInternational) {
                $payload['destination_country_code'] = $order->destination_country_code;
            }

            $response = Http::withHeaders($this->headers())
                            ->post(config('biteship.url') . '/v1/orders', $payload);

            if ($response->successful()) {
                $data       = $response->json();
                $trackingId = $data['courier']['tracking_id'] ?? null;

                if (!$trackingId) {
                    sleep(2);
                    try {
                        $fetchOrder = Http::withHeaders($this->headers())
                                         ->get(config('biteship.url') . '/v1/orders/' . $data['id']);
                        if ($fetchOrder->successful()) {
                            $trackingId = $fetchOrder->json()['courier']['tracking_id'] ?? null;
                        }
                    } catch (\Exception $e) {}
                }

                $order->update([
                    'biteship_order_id'    => $data['id'],
                    'biteship_tracking_id' => $trackingId,
                    'tracking_number'      => $data['courier']['waybill_id'] ?? null,
                    'status'               => 'processing',
                ]);

                \App\Helpers\NotificationHelper::toUser(
                    $order->user_id,
                    'Pesanan Diproses',
                    "Pesanan {$order->invoice_number} sedang diproses dan akan segera dikirim.",
                    route('orders.show', $order->id)
                );

                return back()->with('success', 'Pesanan berhasil dibuat di Biteship. Kurir akan segera menjemput paket.');
            }

            return back()->with('error', 'Gagal membuat pesanan di Biteship: ' . ($response->json()['error'] ?? 'Unknown error'));

        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
        }
    }

    public function trackOrder($trackingId)
    {
        try {
            $response = Http::withHeaders($this->headers())
                            ->get(config('biteship.url') . '/v1/trackings/' . $trackingId);

            if ($response->successful()) {
                $data = $response->json();

                if (isset($data['courier']) && !isset($data['courier']['status'])) {
                    $history = $data['courier']['history'] ?? [];
                    if (!empty($history)) {
                        $lastHistory           = end($history);
                        $data['courier']['status'] = $lastHistory['status'];
                    }
                }

                return response()->json($data);
            }
        } catch (\Exception $e) {}

        return response()->json(['success' => false]);
    }

    public function webhook(Request $request)
    {
        \Log::info('Biteship webhook received', $request->all());

        $data            = $request->json()->all();
        $status          = $data['courier']['status'] ?? $data['status'] ?? null;
        $biteshipOrderId = $data['id'] ?? null;

        if (!$biteshipOrderId || !$status) {
            return response()->json(['success' => false], 400);
        }

        $order = \App\Models\Order::where('biteship_order_id', $biteshipOrderId)->first();

        if (!$order) {
            return response()->json(['success' => false], 404);
        }

        $statusMap = [
            'confirmed'  => 'processing',
            'allocated'  => 'processing',
            'picked_up'  => 'processing',
            'in_transit' => 'shipped',
            'delivered'  => 'done',
            'cancelled'  => 'cancelled',
            'rejected'   => 'cancelled',
            'on_hold'    => 'shipped',
            'return'     => 'cancelled',
        ];

        $newStatus = $statusMap[strtolower($status)] ?? null;

        if ($newStatus && $order->status !== $newStatus) {
            $order->update(['status' => $newStatus]);

            $messages = [
                'processing' => 'Pesanan kamu sedang diproses dan akan segera dijemput kurir.',
                'shipped'    => 'Pesanan kamu sedang dalam perjalanan ke alamat tujuan.',
                'done'       => 'Pesanan kamu telah sampai. Terima kasih sudah berbelanja di Basari!',
                'cancelled'  => 'Pesanan kamu dibatalkan. Hubungi kami untuk informasi lebih lanjut.',
            ];

            if (isset($messages[$newStatus])) {
                \App\Helpers\NotificationHelper::toUser(
                    $order->user_id,
                    'Update Status Pesanan',
                    $messages[$newStatus],
                    route('orders.show', $order->id)
                );
            }
        }

        return response()->json(['success' => true]);
    }

    public function syncTracking(Request $request)
    {
        $order = \App\Models\Order::findOrFail($request->order_id);

        if (!$order->biteship_order_id) {
            return back()->with('error', 'Pesanan belum terdaftar di Biteship.');
        }

        try {
            $response = Http::withHeaders($this->headers())
                            ->get(config('biteship.url') . '/v1/orders/' . $order->biteship_order_id);

            if ($response->successful()) {
                $data       = $response->json();
                $trackingId = $data['courier']['tracking_id'] ?? null;
                $waybillId  = $data['courier']['waybill_id'] ?? null;

                $order->update([
                    'biteship_tracking_id' => $trackingId,
                    'tracking_number'      => $waybillId ?? $order->tracking_number,
                ]);

                return back()->with('success', 'Tracking ID berhasil disinkronkan.');
            }
        } catch (\Exception $e) {}

        return back()->with('error', 'Gagal sinkronisasi tracking.');
    }

    public function printLabel($biteshipOrderId)
    {
        return redirect('https://dashboard.biteship.com/orders/details/' . $biteshipOrderId);
    }
}