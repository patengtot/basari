<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReviewController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'order_item_id' => 'required|exists:order_items,id',
            'rating'        => 'required|integer|min:1|max:5',
            'comment'       => 'nullable|string|max:1000',
        ]);

        $orderItem = OrderItem::with('order')->findOrFail($request->order_item_id);

        // Pastikan order milik user ini dan statusnya done
        if ($orderItem->order->user_id !== Auth::id()) {
            abort(403);
        }

        if ($orderItem->order->status !== 'done') {
            return back()->with('error', 'Review hanya bisa diberikan setelah pesanan selesai.');
        }

        // Cek sudah pernah review item ini belum
        $existing = Review::where('user_id', Auth::id())
                          ->where('order_item_id', $request->order_item_id)
                          ->first();

        if ($existing) {
            return back()->with('error', 'Kamu sudah memberikan review untuk produk ini.');
        }

        Review::create([
            'user_id'       => Auth::id(),
            'product_id'    => $orderItem->product_id,
            'order_id'      => $orderItem->order_id,
            'order_item_id' => $request->order_item_id,
            'rating'        => $request->rating,
            'comment'       => $request->comment,
        ]);

        return back()->with('success', 'Review berhasil dikirim. Terima kasih!');
    }
}