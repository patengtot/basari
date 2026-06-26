@extends('frontend.layouts.app')

@section('title', $category->localized_name . ' — Basari')

@section('content')

<div class="flex items-center gap-3 mb-6">
    <a href="{{ route('home') }}" class="text-gray-400 hover:text-gray-600 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
    </a>
    <nav class="text-sm text-gray-400">
        <a href="{{ route('home') }}" class="hover:text-gray-600">Beranda</a>
        <span class="mx-2">/</span>
        <span class="text-gray-600">{{ $category->localized_name }}</span>
    </nav>
</div>

<div class="mb-6 flex items-center justify-between">
    <div>
        <h1 class="text-2xl font-bold text-gray-800">{{ $category->localized_name }}</h1>
        <p class="text-sm text-gray-400 mt-1">{{ $products->count() }} produk ditemukan</p>
    </div>
</div>


{{-- Pilihan Kategori --}}
<div class="flex gap-2 flex-wrap mb-6 overflow-x-auto pb-1">
    <a href="{{ route('products.all') }}"
       class="flex items-center gap-2 px-4 py-2 rounded-full border-2 text-sm font-medium transition flex-shrink-0
              border-gray-200 text-gray-600 hover:border-blue-400 hover:text-blue-900">
        Semua
    </a>
    @foreach($categories as $cat)
    <a href="{{ route('products.category', $cat->slug) }}"
       class="flex items-center gap-2 px-4 py-2 rounded-full border-2 text-sm font-medium transition flex-shrink-0
              {{ $cat->id === $category->id
                  ? 'border-blue-700 bg-blue-50 text-blue-900'
                  : 'border-gray-200 text-gray-600 hover:border-blue-400 hover:text-blue-900' }}">
        @if($cat->image)
        <img src="{{ asset('storage/' . $cat->image) }}"
             alt="{{ $cat->localized_name }}"
             class="w-5 h-5 rounded-full object-cover">
        @endif
        {{ $cat->localized_name }}
    </a>
    @endforeach
</div>

{{-- Filter & Sort --}}
<form method="GET" action="{{ route('products.category', $category->slug) }}"
      class="bg-white rounded-xl border border-gray-100 p-4 mb-6 flex flex-wrap gap-4 items-end">

    <div>
        <label class="block text-xs font-medium text-gray-500 mb-1">Harga Min</label>
        <input type="number" name="min_price" value="{{ request('min_price') }}"
               placeholder="Rp 0" class="input-field w-36">
    </div>

    <div>
        <label class="block text-xs font-medium text-gray-500 mb-1">Harga Max</label>
        <input type="number" name="max_price" value="{{ request('max_price') }}"
               placeholder="Rp 999999" class="input-field w-36">
    </div>

    <div>
        <label class="block text-xs font-medium text-gray-500 mb-1">Urutkan</label>
        <select name="sort" class="input-field w-44">
            <option value="latest"     {{ request('sort') === 'latest'     ? 'selected' : '' }}>Terbaru</option>
            <option value="oldest"     {{ request('sort') === 'oldest'     ? 'selected' : '' }}>Terlama</option>
            <option value="price_asc"  {{ request('sort') === 'price_asc'  ? 'selected' : '' }}>Harga Terendah</option>
            <option value="price_desc" {{ request('sort') === 'price_desc' ? 'selected' : '' }}>Harga Tertinggi</option>
        </select>
    </div>

    <div class="flex gap-2">
        <button type="submit" class="btn-primary">Filter</button>
        <a href="{{ route('products.category', $category->slug) }}" class="btn-outline">Reset</a>
    </div>

</form>

@if($products->count() > 0)
<div class="grid grid-cols-2 md:grid-cols-4 gap-x-4 gap-y-10">
    @foreach($products as $product)
    <a href="{{ route('products.show', $product->slug) }}" class="group">
        <div class="w-full aspect-[3/4] overflow-hidden bg-gray-50 mb-4 relative">
            @if($newestProductIds->contains($product->id))
            <span class="absolute top-3 left-0 z-10 bg-[#5c6b4a] text-white text-xs uppercase tracking-[0.2em] px-3 py-1.5">
                New
            </span>
            @endif
            @if($product->images && count($product->images) > 0)
            <img src="{{ asset('storage/' . $product->images[$product->thumbnail_index ?? 0]) }}"
                 alt="{{ $product->localized_name }}"
                 class="w-full h-full object-cover group-hover:scale-105 transition duration-500">
            @else
            <div class="w-full h-full flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
            </div>
            @endif
        </div>
        <p class="text-xs uppercase tracking-widest text-gray-300 mb-1">{{ $product->category->localized_name }}</p>
        <p class="text-sm text-gray-800 font-light leading-snug mb-2 line-clamp-1">{{ $product->localized_name }}</p>
        <p class="text-sm text-gray-900 font-medium"
            data-price-idr="{{ $product->price }}"
            data-price-usd="{{ $product->price_usd ?? '' }}"
            data-price-myr="{{ $product->price_myr ?? '' }}">
            Rp {{ number_format($product->price, 0, ',', '.') }}
        </p>
    </a>
    @endforeach
</div>
@else
<div class="text-center py-20">
    <p class="text-xs uppercase tracking-widest text-gray-300">Tidak ada produk yang sesuai filter.</p>
    <a href="{{ route('products.category', $category->slug) }}" class="btn-primary inline-block mt-4">Reset Filter</a>
</div>
@endif

@endsection


