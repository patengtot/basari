<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\OrderStatusMail;

class OrderController extends Controller
{
    public function index(Request $request)
{
    $allOrders = Order::with(['user', 'items'])->latest()->get();

    $orders = $allOrders->when(
        $request->status,
        fn($q) => $q->where('status', $request->status)
    );

    return view('admin.orders.index', compact('orders', 'allOrders'));
}

    public function show(Order $order)
    {
        $order->load('items', 'user');
        return view('admin.orders.show', compact('order'));
    }


public function updateStatus(Request $request, Order $order)
{
    $request->validate([
        'status' => 'required|in:pending,paid,processing,shipped,done,cancelled,waiting_shipping_cost',
    ]);

    $order->update(['status' => $request->status]);

    $messages = [
        'paid'                  => 'Pembayaran pesanan kamu telah dikonfirmasi oleh penjual.',
        'processing'            => 'Pesanan kamu sedang diproses oleh penjual.',
        'shipped'               => 'Pesanan kamu sedang dalam pengiriman.',
        'done'                  => 'Pesanan kamu telah selesai. Terima kasih sudah berbelanja di Basari!',
        'cancelled'             => 'Pesanan kamu telah dibatalkan oleh penjual.',
        'waiting_shipping_cost' => 'Pesanan kamu sedang menunggu konfirmasi ongkos kirim.',
    ];

    $statusLabels = [
        'paid'                  => 'Pembayaran Dikonfirmasi',
        'processing'            => 'Sedang Diproses',
        'shipped'               => 'Pesanan Dikirim',
        'done'                  => 'Pesanan Selesai',
        'cancelled'             => 'Pesanan Dibatalkan',
        'waiting_shipping_cost' => 'Menunggu Konfirmasi Ongkir',
    ];

    if (isset($messages[$request->status])) {
        // Notifikasi in-app
        \App\Helpers\NotificationHelper::toUser(
            $order->user_id,
            'Status Pesanan Diperbarui',
            $messages[$request->status],
            route('orders.show', $order->id)
        );

        // Kirim email ke pembeli
        if ($order->email && isset($statusLabels[$request->status])) {
            Mail::to($order->email)
                ->send(new OrderStatusMail($order, $statusLabels[$request->status]));
        }
    }

    return back()->with('success', 'Status pesanan berhasil diperbarui.');
}

    public function updateResi(Request $request, Order $order)
    {
        $request->validate([
            'tracking_number' => 'required|string|max:100',
        ]);

        $order->update([
            'tracking_number' => $request->tracking_number,
            'status'          => 'shipped',
        ]);

        \App\Helpers\NotificationHelper::toUser(
            $order->user_id,
            'Pesanan Dikirim',
            "Pesanan {$order->invoice_number} telah dikirim via " . strtoupper($order->courier) . " dengan nomor resi {$request->tracking_number}.",
            route('orders.show', $order->id)
        );

        return back()->with('success', 'Nomor resi berhasil disimpan dan status diubah ke shipped.');
    }

    public function destroy(Order $order)
    {
        if (in_array($order->status, ['pending', 'paid', 'processing', 'shipped', 'waiting_shipping_cost'])) {
            return back()->with('error', 'Pesanan tidak bisa dihapus karena masih aktif.');
        }

        $order->items()->delete();
        $order->delete();

        return back()->with('success', 'Pesanan berhasil dihapus.');
    }

    public function confirmIntlShipping(Request $request, Order $order)
{
    $request->validate([
        'intl_shipping_cost' => 'required|integer|min:0',
        'intl_courier'       => 'required|string|max:100',
    ]);

    $subtotal = $order->total_amount - $order->shipping_cost;
    $newTotal = $subtotal + $request->intl_shipping_cost;

    $order->update([
        'intl_shipping_cost' => $request->intl_shipping_cost,
        'intl_courier'       => $request->intl_courier,
        'shipping_cost'      => $request->intl_shipping_cost,
        'total_amount'       => $newTotal,
        'status'             => 'pending',
    ]);

    // Format total sesuai currency customer
    $currency      = $order->preferred_currency ?? 'IDR';
    $totalConverted = \App\Helpers\CurrencyHelper::convert($newTotal, $currency);
    $totalFormatted = \App\Helpers\CurrencyHelper::format($totalConverted, $currency);

    $message = $currency === 'IDR'
        ? "Ongkos kirim pesanan {$order->invoice_number} sudah dikonfirmasi. Total tagihan: Rp " . number_format($newTotal, 0, ',', '.') . ". Silakan lakukan pembayaran."
        : "Ongkos kirim pesanan {$order->invoice_number} sudah dikonfirmasi. Total tagihan: {$totalFormatted} ({$currency}). Pembayaran dilakukan dalam IDR: Rp " . number_format($newTotal, 0, ',', '.') . ".";

    \App\Helpers\NotificationHelper::toUser(
        $order->user_id,
        'Ongkos Kirim Dikonfirmasi',
        $message,
        route('orders.show', $order->id)
    );

    return back()->with('success', 'Ongkos kirim berhasil dikonfirmasi dan pembeli sudah dinotifikasi.');
}

    public function inputIntlResi(Request $request, Order $order)
    {
        $request->validate([
            'intl_tracking_number' => 'required|string|max:100',
        ]);

        $order->update([
            'intl_tracking_number' => $request->intl_tracking_number,
            'status'               => 'shipped',
        ]);

        \App\Helpers\NotificationHelper::toUser(
            $order->user_id,
            'Pesanan Dikirim',
            "Pesanan {$order->invoice_number} sudah dikirim. Nomor resi: {$request->intl_tracking_number} via {$order->intl_courier}.",
            route('orders.show', $order->id)
        );

        return back()->with('success', 'Nomor resi berhasil disimpan dan pembeli sudah dinotifikasi.');
    }
}