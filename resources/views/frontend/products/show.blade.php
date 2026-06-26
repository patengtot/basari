@extends('frontend.layouts.app')

@section('title', $product->name . ' — Basari')

@section('content')

<div class="flex items-center gap-3 mb-6">
    <a href="{{ url()->previous() }}" class="text-gray-400 hover:text-gray-600 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
    </a>
    <nav class="text-sm text-gray-400">
        <a href="{{ route('home') }}" class="hover:text-gray-600">{{ __('app.home') }}</a>
        <span class="mx-2">/</span>
        <a href="{{ route('products.category', $product->category->slug) }}" class="hover:text-gray-600">{{ $product->category->localized_name }}</a>
        <span class="mx-2">/</span>
        <span class="text-gray-600">{{ Str::limit( $product->localized_name, 30) }}</span>
    </nav>
</div>

@php
    $images = $product->images ?? [];
    $colors = $product->colors ?? collect();
@endphp

<div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-6">

    {{-- Kolom Kiri: Gallery --}}
    <div class="flex flex-col gap-3">

        {{-- Foto/Video Utama --}}
        <div class="bg-gray-50 rounded-2xl overflow-hidden aspect-square">
            @if(count($images) > 0)
            <img id="mainImage"
                 src="{{ asset('storage/' . $images[0]) }}"
                 alt="{{ $product->name }}"
                 class="w-full h-full object-cover transition-opacity duration-200">
            @else
            <div class="flex flex-col items-center justify-center h-full gap-2 text-gray-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
                <span class="text-sm">No Image</span>
            </div>
            @endif

            @if($product->video)
            <video id="mainVideo"
                   src="{{ asset('storage/' . $product->video) }}"
                   class="hidden w-full h-full object-cover"
                   controls>
            </video>
            @endif
        </div>

        {{-- Strip Thumbnail --}}
        @if(count($images) > 1 || $product->video)
        <div class="flex gap-2 overflow-x-auto pb-1">
            @foreach($images as $index => $image)
            <button type="button"
                    onclick="switchImage({{ $index }})"
                    data-index="{{ $index }}"
                    class="thumbnail-btn flex-shrink-0 w-16 h-16 rounded-xl overflow-hidden border-2 transition
                           {{ $index === 0 ? 'border-blue-700' : 'border-gray-200 hover:border-blue-400' }}">
                <img src="{{ asset('storage/' . $image) }}"
                     alt="{{ $product->name }} foto {{ $index + 1 }}"
                     class="w-full h-full object-cover">
            </button>
            @endforeach

            @if($product->video)
            <button type="button"
                    onclick="switchToVideo()"
                    id="videoThumbBtn"
                    class="thumbnail-btn flex-shrink-0 w-16 h-16 rounded-xl overflow-hidden border-2 border-gray-200 hover:border-blue-400 transition relative bg-gray-900">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-white absolute inset-0 m-auto" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M8 5v14l11-7z"/>
                </svg>
            </button>
            @endif
        </div>
        @endif

    </div>

    {{-- Kolom Kanan: Info --}}
    <div class="flex flex-col justify-between">
        <div>
            <p class="text-sm text-blue-800 font-medium mb-1">{{ $product->category->localized_name }}</p>
            <h1 class="text-2xl font-bold text-gray-800 mb-3">{{ $product->localized_name }}</h1>
            <p class="text-3xl font-bold text-blue-900 mb-4"
                data-price-idr="{{ $product->price }}"
                data-price-usd="{{ $product->price_usd ?? '' }}"
                data-price-myr="{{ $product->price_myr ?? '' }}">
                Rp {{ number_format($product->price, 0, ',', '.') }}
            </p>

            <p class="text-sm text-gray-400 mb-4">{{ __('app.stock') }}:
                <span id="stockInfo" class="font-medium text-gray-600">
                    @if($product->sizes->count() > 0)
                        {{ $product->sizes->first()->stock }}
                    @else
                        {{ $product->stock }}
                    @endif
                </span>
            </p>

            {{-- Varian Warna --}}
            @if($colors->count() > 0)
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">
                    {{ __('app.color') ?? 'Warna' }}: <span id="selectedColorName" class="text-blue-900">{{ $colors->first()->name }}</span>
                </label>
                <div class="flex gap-2 flex-wrap">
                    @foreach($colors as $i => $color)
                    @php $habis = $color->stock <= 0; @endphp
                    <button type="button"
                            @if(!$habis) onclick="selectColor({{ $color->image_index }}, '{{ $color->name }}', {{ $color->stock }}, this)" @endif
                            class="color-btn flex items-center gap-2 px-3 py-2 rounded-xl border-2 transition
                                {{ $i === 0 && !$habis ? 'border-blue-700 bg-blue-50' : 'border-gray-200' }}
                                {{ $habis ? 'opacity-40 cursor-not-allowed' : 'hover:border-blue-400 cursor-pointer' }}"
                            {{ $habis ? 'disabled' : '' }}>
                        @if($color->hex_code)
                        <span class="inline-block w-5 h-5 rounded-full border border-gray-300 flex-shrink-0"
                            style="background-color: {{ $color->hex_code }}"></span>
                        @endif
                        <span class="text-sm font-medium text-gray-700">{{ $color->name }}</span>
                        @if($habis)
                        <span class="text-xs text-gray-400">({{ __('app.out_of_stock') ?? 'Habis' }})</span>
                        @endif
                    </button>
                    @endforeach
                </div>
            </div>
            @endif
        </div>

        <hr class="border-gray-100 my-4">

        @auth
        @if($product->stock > 0)
        <div class="mt-6 space-y-3">
            <form method="POST" action="{{ route('cart.add') }}">
                @csrf
                <input type="hidden" name="product_id" value="{{ $product->id }}">
                <input type="hidden" name="color" id="selectedColorInput" value="{{ $colors->count() > 0 ? $colors->first()->name : '' }}">

                @if($product->sizes->count() > 0)
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-2">{{ __('app.size') }}</label>
                    <div class="flex gap-2 flex-wrap">
                        @foreach($product->sizes as $size)
                        <label class="cursor-pointer">
                            <input type="radio" name="size" value="{{ $size->size }}"
                                   data-stock="{{ $size->stock }}"
                                   class="hidden peer size-radio" {{ $loop->first ? 'checked' : '' }}
                                   {{ $size->stock === 0 ? 'disabled' : '' }}>
                            <span class="inline-block px-4 py-2 rounded-lg border-2 border-gray-200 text-sm font-medium
                                         peer-checked:border-blue-700 peer-checked:text-blue-900 peer-checked:bg-blue-50
                                         peer-disabled:opacity-40 peer-disabled:cursor-not-allowed
                                         hover:border-blue-400 transition">
                                {{ $size->size }}
                                @if($size->stock === 0)
                                <span class="text-xs text-gray-400">({{ __('app.out_of_stock') ?? 'Habis' }})</span>
                                @endif
                            </span>
                        </label>
                        @endforeach
                    </div>
                </div>
                @endif

                <div class="flex items-center gap-3 mb-4">
                    <label class="text-sm text-gray-600 font-medium">{{ __('app.quantity') ?? 'Jumlah' }}</label>
                    <input type="number" name="quantity" id="qtyInput" value="1" min="1"
                           max="{{ $product->sizes->count() > 0 ? $product->sizes->first()->stock : $product->stock }}"
                           class="input-field w-20 text-center">
                </div>

                <button type="submit" class="btn-primary w-full text-center">
                    {{ __('app.add_to_cart') }}
                </button>
            </form>

            <form method="POST" action="{{ route('chat.start') }}">
                @csrf
                <input type="hidden" name="product_id" value="{{ $product->id }}">
                <button type="submit" class="btn-outline w-full text-center">💬 {{ __('app.chat_seller') ?? 'Chat Penjual' }}</button>
            </form>
        </div>

        @else
        <div class="mt-6 space-y-3">
            <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg text-sm">
                {{ __('app.out_of_stock') ?? 'Stok habis' }}
            </div>
            <form method="POST" action="{{ route('chat.start') }}">
                @csrf
                <input type="hidden" name="product_id" value="{{ $product->id }}">
                <button type="submit" class="btn-outline w-full text-center">💬 {{ __('app.chat_seller') ?? 'Chat Penjual' }}</button>
            </form>
        </div>
        @endif

        @else
        <div class="mt-6 space-y-3">
            <a href="{{ route('login') }}" class="btn-primary w-full text-center block">{{ __('app.login_to_buy') ?? 'Masuk untuk Membeli' }}</a>
            <a href="{{ route('login') }}" class="btn-outline w-full text-center block">💬 {{ __('app.chat_seller') ?? 'Chat Penjual' }}</a>
        </div>
        @endauth
    </div>
</div>

{{-- Deskripsi --}}
<div class="bg-white rounded-xl border border-gray-100 p-6 mb-8">
    <h2 class="text-sm font-semibold text-gray-800 mb-3">{{ __('app.description') }}</h2>
    <div id="descText" class="text-gray-600 text-sm leading-relaxed whitespace-pre-line line-clamp-4 overflow-hidden">{{ $product->localized_description }}</div>
    <button type="button" id="descToggle" onclick="toggleDesc()"
            class="text-blue-700 text-sm font-medium mt-2 hover:underline">
        {{ __('app.see_more') ?? 'Lihat Selengkapnya' }}
    </button>
</div>

{{-- Produk Terkait --}}
@if($related->count() > 0)
<section>
    <h2 class="text-lg font-semibold text-gray-800 mb-4">{{ __('app.related') }}</h2>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
        @foreach($related as $item)
        <a href="{{ route('products.show', $item->slug) }}"
           class="bg-white rounded-2xl border border-gray-100 hover:shadow-lg transition overflow-hidden group">
            <div class="bg-gray-50 h-40 flex items-center justify-center overflow-hidden">
                @if($item->images && count($item->images) > 0)
                <img src="{{ asset('storage/' . $item->images[$item->thumbnail_index ?? 0]) }}"
                     alt="{{ $item->name }}" class="h-40 w-full object-cover group-hover:scale-105 transition duration-300">
                @else
                <span class="text-gray-300 text-xs">No Image</span>
                @endif
            </div>
            <div class="p-3">
                <p class="text-sm font-medium text-gray-800 truncate">{{ $item->name }}</p>
                <p class="text-blue-900 font-semibold text-sm mt-1">Rp {{ number_format($item->price, 0, ',', '.') }}</p>
            </div>
        </a>
        @endforeach
    </div>
</section>
@endif

{{-- Rating & Review --}}
@php
    $reviews      = $product->reviews()->with('user')->latest()->get();
    $avgRating    = $reviews->avg('rating');
    $totalReviews = $reviews->count();
@endphp

@if($totalReviews > 0)
<div class="bg-white rounded-xl border border-gray-100 p-6 mt-6">
    <div class="flex items-center gap-4 mb-6">
        <div class="text-center">
            <p class="text-4xl font-bold text-gray-800">{{ number_format($avgRating, 1) }}</p>
            <div class="flex gap-0.5 justify-center mt-1">
                @for($i = 1; $i <= 5; $i++)
                <svg class="w-4 h-4 {{ $i <= round($avgRating) ? 'text-yellow-400' : 'text-gray-200' }}" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                </svg>
                @endfor
            </div>
            <p class="text-xs text-gray-400 mt-1">{{ $totalReviews }} {{ __('app.review') }}</p>
        </div>
        <div class="flex-1 space-y-1">
            @for($star = 5; $star >= 1; $star--)
            @php $count = $reviews->where('rating', $star)->count(); @endphp
            <div class="flex items-center gap-2">
                <span class="text-xs text-gray-500 w-4">{{ $star }}</span>
                <svg class="w-3 h-3 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                </svg>
                <div class="flex-1 bg-gray-100 rounded-full h-2">
                    <div class="bg-yellow-400 h-2 rounded-full"
                         style="width: {{ $totalReviews > 0 ? ($count / $totalReviews * 100) : 0 }}%"></div>
                </div>
                <span class="text-xs text-gray-400 w-4">{{ $count }}</span>
            </div>
            @endfor
        </div>
    </div>

    <div class="space-y-4">
        @foreach($reviews as $review)
        <div class="border-t border-gray-100 pt-4">
            <div class="flex items-center gap-2 mb-2">
                <div class="w-7 h-7 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 font-bold text-xs">
                    {{ strtoupper(substr($review->user->name, 0, 1)) }}
                </div>
                <p class="text-sm font-medium text-gray-800">{{ $review->user->name }}</p>
                <div class="flex gap-0.5">
                    @for($i = 1; $i <= 5; $i++)
                    <svg class="w-3.5 h-3.5 {{ $i <= $review->rating ? 'text-yellow-400' : 'text-gray-200' }}" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                    </svg>
                    @endfor
                </div>
                <span class="text-xs text-gray-400">{{ $review->created_at->diffForHumans() }}</span>
            </div>
            <p class="text-sm text-gray-600 ml-9">{{ $review->comment ?? __('app.no_comment') ?? 'Tidak ada komentar.' }}</p>
            @if($review->admin_reply)
            <div class="ml-9 mt-2 bg-blue-50 border border-blue-100 rounded-lg p-3">
                <p class="text-xs font-semibold text-blue-900 mb-0.5">{{ __('app.seller_reply') ?? 'Balasan Penjual' }}:</p>
                <p class="text-sm text-blue-800">{{ $review->admin_reply }}</p>
            </div>
            @endif
        </div>
        @endforeach
    </div>
</div>
@endif

<script>
const productImages = @json(array_map(fn($img) => asset('storage/' . $img), $images));

function switchImage(index) {
    if (!productImages[index]) return;
    const mainImg = document.getElementById('mainImage');
    const mainVideo = document.getElementById('mainVideo');
    const videoThumbBtn = document.getElementById('videoThumbBtn');
    if (mainVideo) { mainVideo.pause(); mainVideo.classList.add('hidden'); }
    if (mainImg) mainImg.classList.remove('hidden');
    mainImg.style.opacity = '0';
    setTimeout(() => { mainImg.src = productImages[index]; mainImg.style.opacity = '1'; }, 150);
    document.querySelectorAll('.thumbnail-btn').forEach(btn => {
        const isActive = parseInt(btn.dataset.index) === index;
        btn.classList.toggle('border-blue-700', isActive);
        btn.classList.toggle('border-gray-200', !isActive);
    });
    if (videoThumbBtn) { videoThumbBtn.classList.remove('border-blue-700'); videoThumbBtn.classList.add('border-gray-200'); }
}

function switchToVideo() {
    const mainImg = document.getElementById('mainImage');
    const mainVideo = document.getElementById('mainVideo');
    const videoThumbBtn = document.getElementById('videoThumbBtn');
    if (!mainVideo) return;
    if (mainImg) mainImg.classList.add('hidden');
    mainVideo.classList.remove('hidden');
    mainVideo.play();
    document.querySelectorAll('.thumbnail-btn').forEach(btn => { btn.classList.remove('border-blue-700'); btn.classList.add('border-gray-200'); });
    if (videoThumbBtn) { videoThumbBtn.classList.add('border-blue-700'); videoThumbBtn.classList.remove('border-gray-200'); }
}

function selectColor(imageIndex, colorName, colorStock, btn) {
    switchImage(imageIndex);
    const label = document.getElementById('selectedColorName');
    if (label) label.textContent = colorName;
    const stockInfo = document.getElementById('stockInfo');
    if (stockInfo) stockInfo.textContent = colorStock;

    // Update hidden input warna
    const colorInput = document.getElementById('selectedColorInput');
    if (colorInput) colorInput.value = colorName;

    document.querySelectorAll('.color-btn').forEach(b => { b.classList.remove('border-blue-700', 'bg-blue-50'); b.classList.add('border-gray-200'); });
    btn.classList.remove('border-gray-200');
    btn.classList.add('border-blue-700', 'bg-blue-50');
}

function toggleDesc() {
    const desc = document.getElementById('descText');
    const btn  = document.getElementById('descToggle');
    if (desc.classList.contains('line-clamp-4')) {
        desc.classList.remove('line-clamp-4');
        btn.textContent = '{{ __("app.see_less") ?? "Sembunyikan" }}';
    } else {
        desc.classList.add('line-clamp-4');
        btn.textContent = '{{ __("app.see_more") ?? "Lihat Selengkapnya" }}';
    }
}

const firstColorBtn = document.querySelector('.color-btn:not([disabled])');
if (firstColorBtn) firstColorBtn.click();

document.querySelectorAll('.size-radio').forEach(radio => {
    radio.addEventListener('change', function() {
        const stock = this.dataset.stock;
        const stockInfo = document.getElementById('stockInfo');
        const qtyInput  = document.getElementById('qtyInput');
        stockInfo.textContent = stock;
        qtyInput.max = stock;
        if (parseInt(qtyInput.value) > parseInt(stock)) qtyInput.value = stock;
    });
});
</script>

@endsection
