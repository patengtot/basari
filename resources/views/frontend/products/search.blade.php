@extends('frontend.layouts.app')

@section('title', 'Hasil Pencarian — Basari')

@section('content')

<div class="mb-6">
    <h1 class="text-2xl font-bold text-gray-800">Hasil Pencarian</h1>
    <p class="text-sm text-gray-400 mt-1">
        {{ $products->count() }} produk ditemukan untuk "<span class="text-blue-900">{{ $query }}</span>"
    </p>
</div>

@if($products->count() > 0)
<div class="grid grid-cols-2 md:grid-cols-4 gap-4">
    @foreach($products as $product)
    <a href="{{ route('products.show', $product->slug) }}"
       class="bg-white rounded-2xl border border-gray-100 hover:shadow-lg transition overflow-hidden group">
        <div class="bg-gray-50 h-52 flex items-center justify-center overflow-hidden">
            @if($product->images && count($product->images) > 0)
            <img src="{{ asset('storage/' . $product->images[$product->thumbnail_index ?? 0]) }}"
                 alt="{{ $product->name }}"
                 class="h-52 w-full object-cover group-hover:scale-105 transition duration-300">
            @else
            <div class="flex flex-col items-center gap-2 text-gray-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
                <span class="text-xs">No Image</span>
            </div>
            @endif
        </div>
        <div class="p-4">
            <p class="text-xs text-blue-700 font-medium mb-1">{{ $product->category->localized_name }}</p>
            <p class="text-sm font-semibold text-gray-800 truncate">{{  $product->localized_name }}</p>
            <div class="flex items-center justify-between mt-2">
                <p class="text-blue-900 font-bold text-sm">
                    Rp {{ number_format($product->price, 0, ',', '.') }}
                </p>
                <p class="text-xs text-gray-400">Stok {{ $product->stock }}</p>
            </div>
        </div>
    </a>
    @endforeach
</div>
@else
<div class="text-center py-20">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto text-gray-200 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
    </svg>
    <p class="text-gray-400 mb-2">Produk tidak ditemukan.</p>
    <p class="text-sm text-gray-300">Coba kata kunci yang berbeda.</p>
    <a href="{{ route('home') }}" class="btn-primary inline-block mt-4">Kembali ke Home</a>
</div>
@endif

@endsection

