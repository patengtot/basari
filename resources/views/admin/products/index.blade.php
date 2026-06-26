@extends('admin.layouts.app')

@section('title', 'Produk — Basari Admin')
@section('header', 'Kelola Produk')

@section('content')

<div class="flex justify-between items-center mb-6">
    <p class="text-sm text-gray-400">{{ $products->count() }} produk terdaftar</p>
    <a href="{{ route('admin.products.create') }}" class="btn-primary">+ Tambah Produk</a>
</div>

{{-- Tab Kategori --}}
<div class="flex gap-2 flex-wrap mb-4">
    <a href="{{ route('admin.products.index') }}"
    class="px-4 py-2 rounded-xl text-sm font-medium transition border-2
            {{ !request('category') ? 'border-blue-700 bg-blue-50 text-blue-900' : 'border-gray-200 text-gray-600 hover:border-blue-400' }}">
        Semua ({{ $allProducts->count() }})
    </a>
        @foreach($categories as $cat)
    <a href="{{ route('admin.products.index', ['category' => $cat->id]) }}"
    class="px-4 py-2 rounded-xl text-sm font-medium transition border-2
            {{ request('category') == $cat->id ? 'border-blue-700 bg-blue-50 text-blue-900' : 'border-gray-200 text-gray-600 hover:border-blue-400' }}">
        {{ $cat->name }} ({{ $allProducts->where('category_id', $cat->id)->count() }})
    </a>
        @endforeach
</div>

<div class="bg-white rounded-xl border border-gray-100 overflow-hidden">
    <table class="w-full text-sm">
        <thead>
            <tr class="text-left text-gray-400 border-b border-gray-100 bg-gray-50">
                <th class="px-4 py-3 font-medium">Produk</th>
                <th class="px-4 py-3 font-medium">Kategori</th>
                <th class="px-4 py-3 font-medium">Harga</th>
                <th class="px-4 py-3 font-medium">Stok</th>
                <th class="px-4 py-3 font-medium">Status</th>
                <th class="px-4 py-3 font-medium">Aksi</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
            @forelse($products as $product)
            <tr>
                <td class="px-4 py-3">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-lg overflow-hidden bg-gray-50 flex-shrink-0">
                            @if($product->images && count($product->images) > 0)
                            <img src="{{ asset('storage/' . $product->images[$product->thumbnail_index ?? 0]) }}"
                                alt="{{ $product->name }}"
                                class="w-full h-full object-cover">
                            @else
                            <div class="w-full h-full flex items-center justify-center">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                </svg>
                            </div>
                            @endif
                        </div>
                        <div>
                            <p class="font-medium text-gray-800 line-clamp-1">{{ $product->name }}</p>
                            @if($product->order_items_count > 0)
                            <p class="text-xs text-gray-400">{{ $product->order_items_count }} pesanan</p>
                            @endif
                        </div>
                    </div>
                </td>
                <td class="px-4 py-3 text-gray-500">{{ $product->category->name }}</td>
                <td class="px-4 py-3 text-blue-900 font-semibold">Rp {{ number_format($product->price, 0, ',', '.') }}</td>
                <td class="px-4 py-3">
                    <span class="{{ $product->stock === 0 ? 'text-red-500 font-semibold' : 'text-gray-600' }}">
                        {{ $product->stock }}
                        @if($product->stock === 0)
                        <span class="text-xs bg-red-100 text-red-600 px-1.5 py-0.5 rounded ml-1">Habis</span>
                        @elseif($product->stock <= 5)
                        <span class="text-xs bg-yellow-100 text-yellow-600 px-1.5 py-0.5 rounded ml-1">Hampir Habis</span>
                        @endif
                    </span>
                </td>
                <td class="px-4 py-3">
                    <span class="text-xs px-2 py-1 rounded-full {{ $product->is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500' }}">
                        {{ $product->is_active ? 'Aktif' : 'Nonaktif' }}
                    </span>
                </td>
                <td class="px-4 py-3 flex items-center gap-2">
                    <a href="{{ route('admin.products.edit', $product) }}"
                       class="text-blue-500 hover:underline text-xs">Edit</a>

                    @if($product->order_items_count === 0)
                    <form method="POST" action="{{ route('admin.products.destroy', $product) }}"
                          onsubmit="return confirm('Hapus produk ini permanen?')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-red-500 hover:underline text-xs">Hapus</button>
                    </form>
                    @else
                    <button type="button"
                            onclick="alert('Produk ini tidak bisa dihapus karena sedang ada pesanan yang menggunakan produk ini.')"
                            class="text-red-500 hover:underline text-xs">Hapus</button>
                    @endif
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="6" class="px-4 py-8 text-center text-gray-400">Tidak ada produk di kategori ini.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

@endsection