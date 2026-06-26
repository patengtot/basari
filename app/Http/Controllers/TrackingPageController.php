<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class TrackingPageController extends Controller
{
    public function index()
    {
        return view('frontend.tracking');
    }

    public function track(Request $request)
    {
        $request->validate([
            'invoice' => 'required|string',
        ]);

        $order = Order::where('invoice_number', strtoupper($request->invoice))->first();

        if (!$order) {
            return back()->with('error', 'Nomor invoice tidak ditemukan.')->withInput();
        }

        $tracking = null;

        if ($order->shipping_type === 'domestic' && $order->biteship_order_id) {
            try {
                $response = Http::withHeaders([
                    'authorization' => config('services.biteship.api_key'),
                ])->get('https://api.biteship.com/v1/orders/' . $order->biteship_order_id);

                $data = $response->json();

                if (isset($data['courier']['tracking'])) {
                    $tracking = $data['courier']['tracking'];
                }
            } catch (\Exception $e) {
                // gagal fetch tracking
            }
        }

        return view('frontend.tracking', compact('order', 'tracking'));
    }
}