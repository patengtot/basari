@extends('frontend.layouts.app')

@section('title', __('app.cart') . ' — Basari')

@section('content')

{{-- Tombol Back --}}
<div class="flex items-center gap-3 mb-6">
    <a href="{{ url()->previous() }}" class="text-gray-400 hover:text-gray-600 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
    </a>
    <h1 class="text-2xl font-bold text-gray-800">{{ __('app.cart') ?? 'Keranjang Belanja' }}</h1>
</div>

@if($cart && $cart->items->count() > 0)
<div class="grid grid-cols-1 md:grid-cols-3 gap-6">

    {{-- Daftar Item --}}
    <div class="md:col-span-2 space-y-4">
        @foreach($cart->items as $item)
        <div class="bg-white rounded-xl border border-gray-100 p-4 flex gap-4 items-center">
            <div class="bg-gray-50 rounded-lg w-20 h-20 flex items-center justify-center flex-shrink-0 overflow-hidden">
                @php
                    $imgIndex = $item->product->thumbnail_index ?? 0;

                    if ($item->color) {
                        $colorObj = $item->product->colors->firstWhere('name', $item->color);
                        if ($colorObj) {
                            $imgIndex = $colorObj->image_index ?? $imgIndex;
                        }
                    }
                @endphp
                @if($item->product->images && count($item->product->images) > 0)
                <img src="{{ asset('storage/' . ($item->product->images[$imgIndex] ?? $item->product->images[0])) }}"
                     alt="{{ $item->product->name }}" class="w-20 h-20 object-cover rounded-lg">
                @else
                <span class="text-gray-300 text-xs">No Image</span>
                @endif
            </div>
            <div class="flex-1">
                <p class="font-medium text-gray-800">{{ $item->product->localized_name }}</p>
                <p class="text-blue-900 text-sm font-semibold mt-1"
                data-price-idr="{{ $item->price_at_time }}"
                data-price-usd="{{ $item->product->price_usd ?? '' }}"
                data-price-myr="{{ $item->product->price_myr ?? '' }}">
                    Rp {{ number_format($item->price_at_time, 0, ',', '.') }}
                </p>
                <div class="flex gap-2 flex-wrap mt-1">
                    @if($item->size)
                    <span class="inline-block text-xs bg-blue-50 text-blue-900 border border-blue-300 rounded px-2 py-0.5">
                        {{ __('app.size') }}: {{ $item->size }}
                    </span>
                    @endif
                    @if($item->color)
                    <span class="inline-block text-xs bg-gray-50 text-gray-700 border border-gray-200 rounded px-2 py-0.5">
                        {{ __('app.color') }}: {{ $item->color }}
                    </span>
                    @endif
                </div>
            </div>
            <div class="flex items-center gap-2">
                <form method="POST" action="{{ route('cart.update', $item->id) }}">
                    @csrf @method('PATCH')
                    <input type="number" name="quantity" value="{{ $item->quantity }}"
                           min="1" max="{{ $item->product->stock }}"
                           onchange="this.form.submit()"
                           class="w-16 border border-gray-300 rounded-lg px-2 py-1 text-sm text-center">
                </form>
                <form method="POST" action="{{ route('cart.remove', $item->id) }}">
                    @csrf @method('DELETE')
                    <button type="submit" class="text-red-400 hover:text-red-600 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                        </svg>
                    </button>
                </form>
            </div>
        </div>
        @endforeach
    </div>

    {{-- Ringkasan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6 h-fit">
        <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.order_summary') }}</h2>
        <div class="flex justify-between text-sm text-gray-600 mb-2">
            <span>{{ __('app.total_products') ?? 'Total Produk' }}</span>
            <span>{{ $cart->items->count() }} item</span>
        </div>
        <div class="flex justify-between font-bold text-gray-800 text-lg border-t border-gray-100 pt-3 mt-3">
            <span>{{ __('app.total') }}</span>
            <span class="text-blue-900"
                data-price-idr="{{ $total }}"
                data-price-usd="{{ $cart->items->sum(fn($i) => ($i->product->price_usd ?? 0) * $i->quantity) ?: '' }}"
                data-price-myr="{{ $cart->items->sum(fn($i) => ($i->product->price_myr ?? 0) * $i->quantity) ?: '' }}">
                Rp {{ number_format($total, 0, ',', '.') }}
            </span>
        </div>
        <a href="{{ route('checkout.index') }}" class="btn-primary w-full text-center block mt-6">
            {{ __('app.checkout') }}
        </a>
    </div>

</div>
@else
<div class="text-center py-20">
    <p class="text-gray-400 mb-4">{{ __('app.empty_cart') ?? 'Keranjang kamu masih kosong.' }}</p>
    <a href="{{ route('home') }}" class="btn-primary">{{ __('app.start_shopping') ?? 'Mulai Belanja' }}</a>
</div>
@endif

@endsection