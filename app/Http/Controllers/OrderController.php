<?php

namespace App\Http\Controllers;

use App\Helpers\NotificationHelper;
use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;
use App\Mail\NewOrderMail;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::where('user_id', Auth::id())->latest()->get();
        return view('frontend.orders.index', compact('orders'));
    }

    public function checkout()
    {
        $cart = Cart::with('items.product')->where('user_id', Auth::id())->first();

        if (!$cart || $cart->items->isEmpty()) {
            return redirect()->route('cart.index')->with('error', 'Keranjang kamu masih kosong.');
        }

        $total = $cart->items->sum(fn($item) => $item->price_at_time * $item->quantity);

        return view('frontend.checkout.index', compact('cart', 'total'));
    }

    public function store(Request $request)
{
    $isInternational = $request->shipping_type === 'international';

        $rules = [
        'shipping_name'    => 'required|string|max:255',
        'shipping_address' => 'required|string',
        'phone'            => 'required|string|max:20',
        'email'            => 'required|email',
        'courier'          => $isInternational ? 'nullable|string' : 'required|string',
        'courier_service'  => $isInternational ? 'nullable|string' : 'required|string',
        'shipping_cost'    => $isInternational ? 'nullable|numeric|min:0' : 'required|numeric|min:0',
        'shipping_type'    => 'required|in:domestic,international',
    ];

    if ($isInternational) {
        $rules['destination_country']      = 'required|string';
        $rules['destination_country_code'] = 'required|string|max:5';
        $rules['destination_postal_code']  = 'nullable|string';
    } else {
        $rules['shipping_city']           = 'required|string';
        $rules['shipping_postal']         = 'required|string|max:10';
        $rules['destination_postal_code'] = 'required|string';
    }

    $request->validate($rules);

    $cart = Cart::with('items.product')->where('user_id', Auth::id())->first();

    if (!$cart || $cart->items->isEmpty()) {
        return redirect()->route('cart.index')->with('error', 'Keranjang kamu masih kosong.');
    }

    foreach ($cart->items as $item) {
        if ($item->product->stock < $item->quantity) {
            return redirect()->route('cart.index')
                             ->with('error', "Stok {$item->product->name} tidak mencukupi. Sisa stok: {$item->product->stock}.");
        }
    }

    $order = null;

    DB::transaction(function () use ($request, $cart, &$order, $isInternational) {
        $subtotal     = $cart->items->sum(fn($item) => $item->price_at_time * $item->quantity);
        $shippingCost = (int) ($request->shipping_cost ?? 0);

        $order = Order::create([
            'user_id'                  => Auth::id(),
            'invoice_number'           => 'BSR-' . strtoupper(Str::random(8)),
            'status' => $isInternational ? 'waiting_shipping_cost' : 'pending',
            'total_amount'             => $subtotal + $shippingCost,
            'shipping_name'            => $request->shipping_name,
            'shipping_address'         => $request->shipping_address,
            'shipping_city'            => $isInternational
                                          ? $request->destination_country
                                          : $request->shipping_city,
            'shipping_postal'          => $isInternational
                                          ? ($request->destination_postal_code_intl ?? '')
                                          : $request->shipping_postal,
            'phone'                    => $request->phone,
            'email'                    => $request->email,
            'notes'                    => $request->notes,
            'courier'                  => $request->courier,
            'courier_service'          => $request->courier_service,
            'shipping_cost'            => $shippingCost,
            'destination_postal_code'  => $isInternational
                                          ? ($request->destination_postal_code_intl ?? '')
                                          : $request->destination_postal_code,
            'origin_postal_code'       => '40234',
            'preferred_currency' => session('basari_currency', 'IDR'),
            'shipping_type'            => $request->shipping_type,
            'destination_country'      => $isInternational ? $request->destination_country : null,
            'destination_country_code' => $isInternational ? $request->destination_country_code : null,
        ]);
        $order->update([
            'payment_deadline' => now()->addHour(),
        ]);

        foreach ($cart->items as $item) {
            OrderItem::create([
                'order_id'      => $order->id,
                'product_id'    => $item->product_id,
                'product_name'  => $item->product->name,
                'product_price' => $item->price_at_time,
                'size'          => $item->size ?? null,
                'color'         => $item->color ?? null,
                'quantity'      => $item->quantity,
                'subtotal'      => $item->price_at_time * $item->quantity,
            ]);

            $item->product->decrement('stock', $item->quantity);

            if ($item->size) {
                $item->product->sizes()
                              ->where('size', $item->size)
                              ->decrement('stock', $item->quantity);
            }
            if ($item->color) {
                $item->product->colors()
                              ->where('name', $item->color)
                              ->decrement('stock', $item->quantity);
            }
        }

        $cart->items()->delete();
    });

   NotificationHelper::toUser(
    Auth::id(),
    $isInternational ? 'Pesanan Diterima — Menunggu Konfirmasi Ongkir' : 'Pesanan Berhasil Dibuat',
    $isInternational
        ? "Pesanan {$order->invoice_number} diterima. Kami sedang menghitung ongkos kirim ke {$order->destination_country}. Tunggu notifikasi dari kami."
        : "Pesanan {$order->invoice_number} senilai Rp " . number_format($order->total_amount, 0, ',', '.') . " berhasil dibuat.",
    route('orders.show', $order->id)
);

NotificationHelper::toAdmin(
    $isInternational ? 'Pesanan Internasional Baru' : 'Pesanan Baru Masuk',
    $isInternational
        ? "Pesanan internasional {$order->invoice_number} dari {$order->shipping_name} ke {$order->destination_country}. Harap konfirmasi ongkos kirim."
        : "Pesanan baru {$order->invoice_number} dari {$order->shipping_name} senilai Rp " . number_format($order->total_amount, 0, ',', '.') . ".",
    route('admin.orders.show', $order->id)
);

return redirect()->route('orders.show', $order->id)
                 ->with('success', $isInternational
                     ? 'Pesanan berhasil dibuat! Kami akan segera mengkonfirmasi ongkos kirim ke ' . $order->destination_country . '.'
                     : 'Pesanan berhasil dibuat! Silakan lakukan pembayaran.');
}
    public function show($id)
    {
        $order = Order::with('items')->where('user_id', Auth::id())->findOrFail($id);
        return view('frontend.orders.show', compact('order'));
    }

    public function cancel($id)
    {
        $order = Order::with('items.product')->where('user_id', Auth::id())->findOrFail($id);

        if (!in_array($order->status, ['pending', 'waiting_shipping_cost'])) {
            return back()->with('error', 'Pesanan tidak bisa dibatalkan karena sudah diproses oleh penjual.');
        }

        DB::transaction(function () use ($order) {
            foreach ($order->items as $item) {
                if ($item->product) {
                    $item->product->increment('stock', $item->quantity);

                    if ($item->size) {
                        $item->product->sizes()
                                      ->where('size', $item->size)
                                      ->increment('stock', $item->quantity);
                    }
                }
            }

            $order->update(['status' => 'cancelled']);
        });

        // Notifikasi ke customer
        NotificationHelper::toUser(
            Auth::id(),
            'Pesanan Dibatalkan',
            "Pesanan {$order->invoice_number} berhasil dibatalkan. Stok telah dikembalikan.",
            route('orders.show', $order->id)
        );

        // Notifikasi ke admin
        NotificationHelper::toAdmin(
            'Pesanan Dibatalkan oleh Customer',
            "Pesanan {$order->invoice_number} dari {$order->shipping_name} telah dibatalkan oleh customer.",
            route('admin.orders.show', $order->id)
        );

        return back()->with('success', 'Pesanan berhasil dibatalkan dan stok telah dikembalikan.');
    }
}