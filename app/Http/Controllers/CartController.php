<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    public function index()
    {
        $cart  = Cart::with('items.product')->where('user_id', Auth::id())->first();
        $total = $cart ? $cart->items->sum(fn($item) => $item->price_at_time * $item->quantity) : 0;

        return view('frontend.cart.index', compact('cart', 'total'));
    }

    public function add(Request $request)
{
    $request->validate([
        'product_id' => 'required|exists:products,id',
        'quantity'   => 'required|integer|min:1',
        'size'       => 'nullable|string|max:10',
        'color'      => 'nullable|string|max:50',
    ]);

    $product = Product::with('sizes')->findOrFail($request->product_id);

    if ($product->stock < $request->quantity) {
        return back()->with('error', 'Stok produk tidak mencukupi.');
    }

    $cart = Cart::firstOrCreate(['user_id' => Auth::id()]);

    $cartItem = CartItem::where('cart_id', $cart->id)
                        ->where('product_id', $product->id)
                        ->where('size', $request->size)
                        ->where('color', $request->color)
                        ->first();

    if ($cartItem) {
        $cartItem->increment('quantity', $request->quantity);
    } else {
        CartItem::create([
            'cart_id'       => $cart->id,
            'product_id'    => $product->id,
            'quantity'      => $request->quantity,
            'price_at_time' => $product->price,
            'size'          => $request->size,
            'color'         => $request->color,
        ]);
    }

    return back()->with('success', 'Produk berhasil ditambahkan ke keranjang.');
}

    public function remove($id)
    {
        $item = CartItem::findOrFail($id);
        $item->delete();

        return back()->with('success', 'Produk dihapus dari keranjang.');
    }

    public function update(Request $request, $id)
    {
        $request->validate(['quantity' => 'required|integer|min:1']);

        $item = CartItem::findOrFail($id);
        $item->update(['quantity' => $request->quantity]);

        return back()->with('success', 'Keranjang diperbarui.');
    }
    
}