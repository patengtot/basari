@extends('admin.layouts.app')

@section('title', 'Tambah Produk — Basari Admin')
@section('header', 'Tambah Produk')

@section('content')

<div class="max-w-2xl">
    <form method="POST" action="{{ route('admin.products.store') }}" enctype="multipart/form-data" class="space-y-5">
        @csrf

        <div class="bg-white rounded-xl border border-gray-100 p-6 space-y-4">

            {{-- Nama Produk --}}
        <div>
            <label class="block text-xs font-medium text-gray-600 mb-1">Nama Produk (ID)</label>
            <input type="text" name="name" value="{{ old('name', $product->name ?? '') }}"
                class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"
                placeholder="Nama produk bahasa Indonesia" required>
        </div>

        <div>
            <label class="block text-xs font-medium text-gray-600 mb-1">
                Product Name (EN) <span class="text-gray-300 font-normal">— opsional</span>
            </label>
            <input type="text" name="name_en" value="{{ old('name_en', $product->name_en ?? '') }}"
                class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"
                placeholder="Product name in English">
        </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Kategori</label>
                <select name="category_id" class="input-field" required>
                    <option value="">Pilih kategori</option>
                    @foreach($categories as $category)
                    <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>
                        {{ $category->name }}
                    </option>
                    @endforeach
                </select>
                @error('category_id') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
            </div>

            {{-- Deskripsi --}}
            <div>
                <label class="block text-xs font-medium text-gray-600 mb-1">Deskripsi (ID)</label>
                <textarea name="description" rows="4"
                    class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"
                    placeholder="Deskripsi produk bahasa Indonesia">{{ old('description', $product->description ?? '') }}</textarea>
            </div>

            <div>
                <label class="block text-xs font-medium text-gray-600 mb-1">
                    Description (EN) <span class="text-gray-300 font-normal">— opsional</span>
                </label>
                <textarea name="description_en" rows="4"
                    class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"
                    placeholder="Product description in English">{{ old('description_en', $product->description_en ?? '') }}</textarea>
            </div>

            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Harga (Rp)</label>
                    <input type="number" name="price" value="{{ old('price') }}" class="input-field" required min="0">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Stok</label>
                    <input type="number" name="stock" value="{{ old('stock', 0) }}" class="input-field" required min="0">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Berat (gram)</label>
                    <input type="number" name="weight" value="{{ old('weight', 0) }}" class="input-field" required min="0">
                </div>
            </div>

            <div class="grid grid-cols-3 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Panjang (cm)</label>
                    <input type="number" name="length" value="{{ old('length', 30) }}" class="input-field" min="0">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Lebar (cm)</label>
                    <input type="number" name="width" value="{{ old('width', 25) }}" class="input-field" min="0">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Tinggi (cm)</label>
                    <input type="number" name="height" value="{{ old('height', 5) }}" class="input-field" min="0">
                </div>
            </div>
            <p class="text-xs text-gray-400 -mt-2">Dimensi paket saat dikemas, digunakan untuk perhitungan ongkos kirim.</p>

            {{-- Ukuran --}}
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Ukuran & Stok per Ukuran</label>
                <div id="sizeContainer" class="space-y-2">
                    <div class="size-row flex gap-2 items-center">
                        <select name="sizes[0][size]" class="input-field w-28">
                            <option value="">Pilih</option>
                            @foreach(['XS','S','M','L','XL','XXL','XXXL','ALL SIZE'] as $opt)
                            <option value="{{ $opt }}">{{ $opt }}</option>
                            @endforeach
                        </select>
                        <input type="number" name="sizes[0][stock]" placeholder="Stok" min="0" class="input-field w-24">
                        <button type="button" onclick="removeSize(this)"
                                class="text-red-400 hover:text-red-600 transition text-sm px-2">✕</button>
                    </div>
                </div>
                <button type="button" onclick="addSize()" class="mt-2 text-sm text-blue-900 hover:underline">+ Tambah Ukuran</button>
                <p id="sizeStockWarning" class="hidden text-xs text-red-500 mt-2 font-medium"></p>
                <p class="text-xs text-gray-400 mt-1">Kosongkan jika produk tidak memiliki ukuran spesifik.</p>
            </div>

                        {{-- Foto Produk --}}
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Foto Produk</label>
                <input type="file" name="images[]" multiple accept="image/*"
                    class="input-field" onchange="previewNewImages(event)">
                <p class="text-xs text-gray-400 mt-1">Pilih semua foto sekaligus. Foto pertama = indeks 0, kedua = indeks 1, dst.</p>
                <div id="imagePreview" class="flex gap-2 flex-wrap mt-3"></div>
            </div>
            {{-- Video Produk --}}
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Video Produk (opsional)</label>
                <input type="file" name="video" accept="video/mp4,video/webm" class="input-field">
                <p class="text-xs text-gray-400 mt-1">Format MP4/WebM, maks 50MB. Video akan tampil di halaman detail produk.</p>
            </div>
            {{-- Pilih Thumbnail Katalog --}}
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Thumbnail Katalog</label>
                <input type="number" name="thumbnail_index"
                    value="{{ old('thumbnail_index', 0) }}"
                    min="0" class="input-field w-24">
                <p class="text-xs text-gray-400 mt-1">Nomor indeks foto yang tampil di halaman katalog. Default 0 (foto pertama).</p>
            </div>

            {{-- Varian Warna --}}
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Varian Warna</label>
                <div id="colorContainer" class="space-y-2"></div>
                <button type="button" onclick="addColor()" class="mt-2 text-sm text-blue-900 hover:underline">+ Tambah Warna</button>
                <p class="text-xs text-gray-400 mt-1">Stok warna tidak boleh melebihi total stok produk.</p>
            </div>

            <div class="flex items-center gap-2">
                <input type="checkbox" name="is_active" id="is_active" value="1" checked class="rounded border-gray-300 text-blue-900">
                <label for="is_active" class="text-sm text-gray-700">Produk aktif (tampil di toko)</label>
            </div>

        </div>

        <div class="flex gap-3">
            <button type="submit" class="btn-primary">Simpan Produk</button>
            <a href="{{ route('admin.products.index') }}" class="btn-outline">Batal</a>
        </div>

    </form>
</div>

<script>
let sizeIndex = 1;
let colorIndex = 0;

function previewNewImages(event) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    Array.from(event.target.files).forEach((file, index) => {
        const reader = new FileReader();
        reader.onload = e => {
            const wrapper = document.createElement('div');
            wrapper.className = 'relative text-center';
            wrapper.innerHTML = `
                <img src="${e.target.result}" class="w-24 h-24 object-cover rounded-xl border border-gray-200">
                <span class="block text-xs text-gray-400 mt-1">Indeks ${index}</span>
            `;
            preview.appendChild(wrapper);
        };
        reader.readAsDataURL(file);
    });
}

function removeNewImage(index) {
    const newDT = new DataTransfer();
    Array.from(allFiles.files).forEach((file, i) => {
        if (i !== index) newDT.items.add(file);
    });
    allFiles = newDT;
    renderImagePreviews();
    syncFileInput();
}

function renderImagePreviews() {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';

    Array.from(allFiles.files).forEach((file, index) => {
        const reader = new FileReader();
        reader.onload = e => {
            const wrapper = document.createElement('div');
            wrapper.className = 'relative text-center';
            wrapper.innerHTML = `
                <img src="${e.target.result}" class="w-24 h-24 object-cover rounded-xl border border-gray-200">
                <button type="button" onclick="removeNewImage(${index})"
                        class="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-6 h-6 text-xs flex items-center justify-center">✕</button>
                <span class="block text-xs text-gray-400 mt-1">Indeks ${index}</span>
            `;
            preview.appendChild(wrapper);
        };
        reader.readAsDataURL(file);
    });
}

function syncFileInput() {
    // Pasang semua file ke input tersembunyi agar ikut tersubmit
    const realInput = document.getElementById('imageInput');
    realInput.files = allFiles.files;
}

// ---- SIZE ----
function getTotalSizeStock() {
    let total = 0;
    document.querySelectorAll('input[name^="sizes"][name$="[stock]"]').forEach(input => {
        total += parseInt(input.value) || 0;
    });
    return total;
}

function checkSizeStock() {
    const totalStock = parseInt(document.querySelector('input[name="stock"]').value) || 0;
    const totalSizeStock = getTotalSizeStock();
    const warning = document.getElementById('sizeStockWarning');
    if (totalSizeStock > totalStock) {
        warning.textContent = `⚠️ Total stok ukuran (${totalSizeStock}) melebihi stok keseluruhan (${totalStock}).`;
        warning.classList.remove('hidden');
    } else {
        warning.classList.add('hidden');
    }
}

function addSize() {
    const container = document.getElementById('sizeContainer');
    const row = document.createElement('div');
    row.className = 'size-row flex gap-2 items-center';
    row.innerHTML = `
        <select name="sizes[${sizeIndex}][size]" class="input-field w-28">
            <option value="">Pilih</option>
            <option value="XS">XS</option>
            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
            <option value="XXL">XXL</option>
            <option value="XXXL">XXXL</option>
            <option value="ALL SIZE">ALL SIZE</option>
        </select>
        <input type="number" name="sizes[${sizeIndex}][stock]" placeholder="Stok" min="0"
               class="input-field w-24" oninput="checkSizeStock()">
        <button type="button" onclick="removeSize(this)"
                class="text-red-400 hover:text-red-600 transition text-sm px-2">✕</button>
    `;
    container.appendChild(row);
    sizeIndex++;
}

function removeSize(btn) {
    btn.closest('.size-row').remove();
    checkSizeStock();
}

// ---- COLOR ----
function checkColorStock() {
    const totalStock = parseInt(document.querySelector('input[name="stock"]').value) || 0;
    let totalColorStock = 0;
    document.querySelectorAll('input[name^="colors"][name$="[stock]"]').forEach(input => {
        totalColorStock += parseInt(input.value) || 0;
    });

    const warning = document.getElementById('colorStockWarning');
    if (!warning) return;
    if (totalColorStock > totalStock) {
        warning.textContent = `⚠️ Total stok warna (${totalColorStock}) melebihi stok keseluruhan (${totalStock}).`;
        warning.classList.remove('hidden');
    } else {
        warning.classList.add('hidden');
    }
}

function addColor() {
    const container = document.getElementById('colorContainer');

    // Tambah warning kalau belum ada
    if (!document.getElementById('colorStockWarning')) {
        const warn = document.createElement('p');
        warn.id = 'colorStockWarning';
        warn.className = 'hidden text-xs text-red-500 mt-1 font-medium';
        container.parentNode.insertBefore(warn, container.nextSibling);
    }

    const row = document.createElement('div');
    row.className = 'color-row flex gap-2 items-center flex-wrap';
    row.innerHTML = `
        <input type="text" name="colors[${colorIndex}][name]" placeholder="Nama warna"
               class="input-field w-32">
        <div class="flex items-center gap-1">
            <input type="color" name="colors[${colorIndex}][hex_code]" value="#000000"
                   class="w-9 h-9 rounded border border-gray-200 cursor-pointer p-0.5">
            <span class="text-xs text-gray-400">Warna</span>
        </div>
        <div class="flex items-center gap-1">
            <input type="number" name="colors[${colorIndex}][image_index]" value="0" min="0"
                   class="input-field w-20" placeholder="Indeks foto">
            <span class="text-xs text-gray-400">foto</span>
        </div>
        <div class="flex items-center gap-1">
            <input type="number" name="colors[${colorIndex}][stock]" value="0" min="0"
                   class="input-field w-20" placeholder="Stok" oninput="checkColorStock()">
            <span class="text-xs text-gray-400">stok</span>
        </div>
        <button type="button" onclick="removeColor(this)"
                class="text-red-400 hover:text-red-600 transition text-sm px-2">✕</button>
    `;
    container.appendChild(row);
    colorIndex++;
}

function removeColor(btn) {
    btn.closest('.color-row').remove();
    checkColorStock();
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('input[name="stock"]').addEventListener('input', () => {
        checkSizeStock();
        checkColorStock();
    });
    document.querySelectorAll('input[name^="sizes"][name$="[stock]"]').forEach(input => {
        input.addEventListener('input', checkSizeStock);
    });
});
</script>

@endsection