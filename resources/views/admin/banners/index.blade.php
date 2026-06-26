@extends('admin.layouts.app')

@section('title', 'Banner — Basari Admin')
@section('header', 'Kelola Banner')

@section('content')

<div class="grid grid-cols-1 md:grid-cols-3 gap-6">

    {{-- Form Tambah --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6 h-fit">
        <h2 class="font-semibold text-gray-800 mb-4">Tambah Banner</h2>
        <form method="POST" action="{{ route('admin.banners.store') }}" enctype="multipart/form-data" class="space-y-3">
            @csrf
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Judul Banner</label>
                <input type="text" name="title" value="{{ old('title') }}" class="input-field" required>
                @error('title') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Gambar</label>
                <input type="file" name="image" accept="image/*" class="input-field" required>
                @error('image') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Link URL (opsional)</label>
                <input type="url" name="link_url" value="{{ old('link_url') }}" class="input-field" placeholder="https://...">
                <p class="text-xs text-gray-400 mt-1">Halaman tujuan saat pelanggan klik tombol "Explore More" di banner. Kosongkan untuk default ke halaman semua produk.</p>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Urutan</label>
                <input type="number" name="order_position" value="{{ old('order_position', 0) }}" class="input-field" min="0">
            </div>
            <button type="submit" class="btn-primary w-full">Upload Banner</button>
        </form>
    </div>

    {{-- Daftar Banner --}}
    <div class="md:col-span-2 space-y-4">
        @forelse($banners as $banner)
        <div class="bg-white rounded-xl border border-gray-100 p-4">

            {{-- Info Banner --}}
            <div class="flex gap-4 items-center">
                <img src="{{ asset('storage/' . $banner->image) }}"
                     alt="{{ $banner->title }}" class="w-24 h-16 object-cover rounded-lg flex-shrink-0">
                <div class="flex-1">
                    <p class="font-medium text-gray-800">{{ $banner->title }}</p>
                    <p class="text-xs text-gray-400 mt-1">Urutan: {{ $banner->order_position }}</p>
                    @if($banner->link_url)
                    <p class="text-xs text-blue-600 mt-0.5 truncate">{{ $banner->link_url }}</p>
                    @endif
                </div>
                <div class="flex gap-3 items-center flex-shrink-0">
                    <button type="button" onclick="toggleEditBanner({{ $banner->id }})"
                            class="text-blue-500 hover:underline text-sm">Edit</button>
                    <form method="POST" action="{{ route('admin.banners.destroy', $banner) }}"
                          onsubmit="return confirm('Hapus banner ini?')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-red-500 hover:underline text-sm">Hapus</button>
                    </form>
                </div>
            </div>

            {{-- Form Edit --}}
            <div id="editBanner{{ $banner->id }}" class="hidden mt-4 border-t border-gray-100 pt-4">
                <form method="POST" action="{{ route('admin.banners.update', $banner) }}"
                      enctype="multipart/form-data" class="space-y-3">
                    @csrf @method('PATCH')
                    <div class="grid grid-cols-2 gap-3">
                        <div>
                            <label class="block text-xs font-medium text-gray-700 mb-1">Judul Banner</label>
                            <input type="text" name="title" value="{{ $banner->title }}"
                                   class="input-field" required>
                        </div>
                        <div>
                            <label class="block text-xs font-medium text-gray-700 mb-1">Urutan</label>
                            <input type="number" name="order_position" value="{{ $banner->order_position }}"
                                   class="input-field" min="0">
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-gray-700 mb-1">Link URL (opsional)</label>
                        <input type="url" name="link_url" value="{{ $banner->link_url }}"
                            class="input-field" placeholder="https://...">
                        <p class="text-xs text-gray-400 mt-1">Halaman tujuan saat pelanggan klik "Explore More". Kosongkan untuk default ke semua produk.</p>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-gray-700 mb-1">Ganti Gambar (opsional)</label>
                        <input type="file" name="image" accept="image/*" class="input-field">
                    </div>
                    <div class="flex gap-2">
                        <button type="submit" class="btn-primary text-sm">Simpan</button>
                        <button type="button" onclick="toggleEditBanner({{ $banner->id }})"
                                class="btn-outline text-sm">Batal</button>
                    </div>
                </form>
            </div>

        </div>
        @empty
        <div class="bg-white rounded-xl border border-gray-100 p-8 text-center text-gray-400">
            Belum ada banner.
        </div>
        @endforelse
    </div>

</div>

{{-- Hero Video --}}
<div class="mt-8 bg-white rounded-xl border border-gray-100 p-6">
    <h2 class="font-semibold text-gray-800 mb-1">Hero Video</h2>
    <p class="text-xs text-gray-400 mb-4">Video yang tampil di bagian paling atas halaman utama. Format MP4/WebM, maks 50MB.</p>

    @if(session('success'))
    <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg text-sm mb-4">
        {{ session('success') }}
    </div>
    @endif

    @if($heroVideo)
    <div class="mb-4">
        <p class="text-sm font-medium text-gray-700 mb-2">Video Saat Ini</p>
        <video src="{{ asset('storage/' . $heroVideo) }}"
               class="w-full max-w-lg rounded-xl border border-gray-200"
               controls style="max-height: 240px;">
        </video>
        <form method="POST" action="{{ route('admin.banners.hero-video') }}" class="mt-2">
            @csrf
            <input type="hidden" name="remove_video" value="1">
            <button type="submit" onclick="return confirm('Hapus hero video?')"
                    class="text-red-500 text-sm hover:underline">Hapus Video</button>
        </form>
    </div>
    @endif

    <form method="POST" action="{{ route('admin.banners.hero-video') }}" enctype="multipart/form-data" class="space-y-3">
        @csrf
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">
                {{ $heroVideo ? 'Ganti Video' : 'Upload Video' }}
            </label>
            <input type="file" name="hero_video" accept="video/mp4,video/webm" class="input-field">
            @error('hero_video') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
        </div>
        <button type="submit" class="btn-primary">Simpan Video</button>
    </form>
</div>

<script>
function toggleEditBanner(id) {
    const form = document.getElementById('editBanner' + id);
    if (form.classList.contains('hidden')) {
        form.classList.remove('hidden');
    } else {
        form.classList.add('hidden');
    }
}
</script>

@endsection