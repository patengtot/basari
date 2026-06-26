@extends('admin.layouts.app')

@section('title', 'Kategori — Basari Admin')
@section('header', 'Kelola Kategori')

@section('content')


<div class="grid grid-cols-1 md:grid-cols-3 gap-6">

    {{-- Form Tambah --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6 h-fit">
        <h2 class="font-semibold text-gray-800 mb-4">Tambah Kategori</h2>
        <form method="POST" action="{{ route('admin.categories.store') }}" enctype="multipart/form-data" class="space-y-3">
            @csrf
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Nama Kategori (ID)</label>
                <input type="text" name="name" value="{{ old('name') }}" class="input-field" placeholder="contoh: Outer" required>
                @error('name') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">
                    Category Name (EN) <span class="text-gray-300 font-normal text-xs">— opsional</span>
                </label>
                <input type="text" name="name_en" value="{{ old('name_en') }}" class="input-field" placeholder="example: Outerwear">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Foto Kategori</label>
                <input type="file" name="image" accept="image/*" class="input-field">
                @error('image') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
            </div>
            <button type="submit" class="btn-primary w-full">Tambah</button>
        </form>
    </div>

    {{-- Daftar Kategori --}}
    <div class="md:col-span-2 space-y-3">
        @foreach($categories as $category)
        <div class="bg-white rounded-xl border border-gray-100 p-4">
            <div class="flex gap-4 items-center">

                {{-- Foto kategori --}}
                <div class="w-16 h-16 rounded-full overflow-hidden bg-gray-100 flex-shrink-0 flex items-center justify-center">
                    @if($category->image)
                    <img src="{{ asset('storage/' . $category->image) }}"
                         alt="{{ $category->name }}" class="w-full h-full object-cover">
                    @else
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                    @endif
                </div>

                <div class="flex-1">
                    <p class="font-medium text-gray-800">{{ $category->name }}</p>
                    <p class="text-xs text-gray-400">{{ $category->products_count }} produk</p>
                </div>

                <span class="text-xs px-2 py-1 rounded-full {{ $category->is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500' }}">
                    {{ $category->is_active ? 'Aktif' : 'Nonaktif' }}
                </span>
            </div>

            <form method="POST" action="{{ route('admin.categories.update', $category) }}"
                enctype="multipart/form-data"
                class="mt-3 pt-3 border-t border-gray-100 flex gap-2 items-center flex-wrap">
                @csrf @method('PATCH')
                <div class="flex gap-2 flex-1 min-w-0">
                    <input type="text" name="name" value="{{ $category->name }}"
                        class="input-field flex-1 min-w-24" placeholder="Nama (ID)" required>
                    <input type="text" name="name_en" value="{{ $category->name_en }}"
                        class="input-field flex-1 min-w-24" placeholder="Name (EN)">
                </div>
                <input type="file" name="image" accept="image/*" class="input-field flex-1 min-w-32">
                <label class="flex items-center gap-1 text-sm text-gray-600 cursor-pointer">
                    <input type="checkbox" name="is_active" value="1"
                        {{ $category->is_active ? 'checked' : '' }} class="rounded border-gray-300">
                    Aktif
                </label>
                <button type="submit" class="btn-primary text-sm px-4">Simpan</button>
            </form>

            {{-- Form Hapus (terpisah dari form edit) --}}
            <form method="POST" action="{{ route('admin.categories.destroy', $category) }}"
                  onsubmit="return confirm('Hapus kategori ini?')" class="mt-1">
                @csrf @method('DELETE')
                <button type="submit" class="text-red-500 hover:underline text-sm">Hapus</button>
            </form>

        </div>
        @endforeach
    </div>

</div>

@endsection