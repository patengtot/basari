@extends('frontend.layouts.app')

@section('title', 'Basari — Fashion Wanita')

@section('fullwidth', true)

@section('content')

{{-- Hero Slider --}}
<div class="relative overflow-hidden" style="height: 100vh; max-height: 900px;">
    @if($banners->count() > 0)

    <div id="slider" class="flex h-full"
         style="width: {{ $banners->count() * 100 }}%; transition: transform 0.9s cubic-bezier(0.77, 0, 0.175, 1);">
        @foreach($banners as $i => $banner)
        <div class="relative h-full overflow-hidden" style="width: {{ 100 / $banners->count() }}%">
            <img src="{{ asset('storage/' . $banner->image) }}"
                 alt="{{ $banner->title }}"
                 class="w-full h-full object-cover object-center scale-105 transition-transform duration-[8000ms] ease-out"
                 id="bannerImg{{ $i }}">
            <div class="absolute inset-0 bg-gradient-to-b from-black/10 via-transparent to-black/50"></div>
            <div class="absolute inset-0 flex flex-col justify-end px-6 md:px-20 pb-16 md:pb-24">
                <p class="text-white/30 text-xs tracking-[0.4em] uppercase mb-4 md:mb-6">
                    0{{ $i + 1 }} / 0{{ $banners->count() }}
                </p>
                <h1 class="font-lora text-3xl md:text-7xl font-light text-white leading-[1.1] mb-5 md:mb-6 max-w-2xl">
                    {{ $banner->title }}
                </h1>
                <div class="flex items-center gap-4">
                    <a href="{{ $banner->link_url ?? route('products.all') }}"
                    class="group flex items-center gap-3 text-xs uppercase tracking-[0.3em] text-white/80 hover:text-white transition duration-300">
                        <span>{{ __('app.explore_more') }}</span>
                        <span class="w-8 h-px bg-white/50 group-hover:w-12 group-hover:bg-white transition-all duration-300"></span>
                    </a>
                </div>
            </div>
        </div>
        @endforeach
    </div>
    {{-- Progress bar --}}
    <div class="absolute bottom-0 left-0 right-0 h-px bg-white/10">
        <div id="sliderProgress" class="h-full bg-white/50 transition-none" style="width: 0%"></div>
    </div>

    {{-- Dots --}}
    <div class="absolute bottom-10 right-12 md:right-20 flex gap-2 items-center">
        @foreach($banners as $i => $banner)
        <button onclick="goToSlide({{ $i }})"
                class="dot transition-all duration-300 rounded-full
                       {{ $i === 0 ? 'w-6 h-1.5 bg-white' : 'w-1.5 h-1.5 bg-white/30 hover:bg-white/60' }}">
        </button>
        @endforeach
    </div>

    <button onclick="prevSlide()"
            class="absolute left-6 top-1/2 -translate-y-1/2 w-10 h-10 flex items-center justify-center text-white/50 hover:text-white transition group">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 group-hover:-translate-x-0.5 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 19l-7-7 7-7"/>
        </svg>
    </button>
    <button onclick="nextSlide()"
            class="absolute right-6 top-1/2 -translate-y-1/2 w-10 h-10 flex items-center justify-center text-white/50 hover:text-white transition group">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 group-hover:translate-x-0.5 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5l7 7-7 7"/>
        </svg>
    </button>

    @else
    <div class="w-full h-full bg-gray-100 flex flex-col justify-end px-12 md:px-20 pb-24">
        <p class="text-xs text-gray-400 uppercase tracking-[0.4em] mb-6">01 / 01</p>
        <h1 class="font-lora italic text-5xl md:text-7xl text-gray-900 font-light leading-[1.1] mb-6 max-w-2xl">
            Fashion That<br>Defines You.
        </h1>
        <a href="{{ route('products.all') }}"
           class="group flex items-center gap-3 text-xs uppercase tracking-[0.3em] text-gray-500 hover:text-gray-900 transition w-fit">
            <span>{{ __('app.explore_more') }}</span>
            <span class="w-8 h-px bg-gray-400 group-hover:w-12 group-hover:bg-gray-900 transition-all duration-300"></span>
        </a>
    </div>
    @endif
</div>

{{-- Kategori — FULL WIDTH --}}
<section class="py-16 relative overflow-hidden">
    <p class="text-xs uppercase tracking-[0.3em] text-gray-400 text-center mb-10">
        {{ __('app.shop_category') }}
    </p>
    <button id="catPrev"
        class="absolute left-2 top-1/2 -translate-y-1/2 z-10 w-8 h-8 md:w-10 md:h-10 bg-white/80 backdrop-blur-sm flex items-center justify-center hover:bg-white transition shadow-sm text-sm">
        ←
    </button>
    <button id="catNext"
        class="absolute right-2 top-1/2 -translate-y-1/2 z-10 w-8 h-8 md:w-10 md:h-10 bg-white/80 backdrop-blur-sm flex items-center justify-center hover:bg-white transition shadow-sm text-sm">
        →
    </button>
    <div id="catSlider" class="flex gap-px overflow-x-auto scroll-smooth"
         style="scrollbar-width: none; -ms-overflow-style: none;">
        @foreach($categories as $index => $category)
        <a href="{{ route('products.category', $category->slug) }}"
            class="relative flex-shrink-0 group overflow-hidden"
            style="width: clamp(200px, 65vw, 22vw); height: clamp(280px, 55vh, 65vh);">
            <div class="w-full h-full overflow-hidden bg-gray-100">
                @if($category->image)
                <img src="{{ asset('storage/' . $category->image) }}"
                     alt="{{ $category->localized_name }}"
                     class="w-full h-full object-cover object-top group-hover:scale-105 transition duration-700 ease-out">
                @else
                <div class="w-full h-full bg-gray-200"></div>
                @endif
            </div>
            <div class="absolute inset-0 bg-black/20 group-hover:bg-black/30 transition duration-500"></div>
            <div class="absolute bottom-0 left-0 right-0 h-48 bg-gradient-to-t from-black/70 to-transparent"></div>
            <div class="absolute top-6 left-6">
                <p class="text-white/40 text-xs tracking-[0.3em]">0{{ $index + 1 }}</p>
            </div>
            <div class="absolute bottom-0 left-0 right-0 p-4 md:p-6 translate-y-2 group-hover:translate-y-0 transition duration-300">
                <p class="text-white font-serif text-base md:text-lg mb-1">{{ $category->localized_name }}</p>
                <div class="flex items-center gap-2 overflow-hidden h-5">
                    <span class="text-white/0 group-hover:text-white/60 text-xs uppercase tracking-[0.2em] transition-all duration-300 -translate-x-2 group-hover:translate-x-0">
                        Shop Now
                    </span>
                    <span class="text-white/0 group-hover:text-white/60 text-xs transition-all duration-500 delay-75">→</span>
                </div>
            </div>
        </a>
        @endforeach
    </div>
</section>

{{-- Hero Video --}}
@php $heroVideo = \App\Models\Setting::get('hero_video'); @endphp
@if($heroVideo)
<div class="relative overflow-hidden" style="height: clamp(700px, 60vh, 900px);">
    <video autoplay muted loop playsinline
           class="absolute w-full h-full object-cover"
           style="top: 50%; left: 50%; transform: translate(-50%, -50%);">
        <source src="{{ asset('storage/' . $heroVideo) }}" type="video/mp4">
    </video>
    <div class="absolute bottom-8 left-1/2 -translate-x-1/2">
        <p class="font-serif text-white/20 text-xs uppercase tracking-[0.5em]">BASARI.ID</p>
    </div>
</div>
@endif

{{-- Produk Terbaru --}}
<section class="py-10 md:py-16 px-4 max-w-6xl mx-auto border-t border-gray-100">
    <div class="flex items-end justify-between mb-6 md:mb-10">
        <p class="text-xs uppercase tracking-[0.3em] text-gray-400">{{ __('app.latest_products') }}</p>
        <a href="{{ route('products.all') }}"
           class="text-xs uppercase tracking-[0.2em] text-gray-400 border-b border-gray-200 pb-0.5 hover:text-gray-900 hover:border-gray-900 transition">
            {{ __('app.view_all') }}
        </a>
    </div>

    @if($products->count() > 0)
    <div class="grid grid-cols-2 md:grid-cols-4 gap-x-3 md:gap-x-4 gap-y-8 md:gap-y-10">
        @foreach($products as $product)
        <a href="{{ route('products.show', $product->slug) }}" class="group">
            <div class="w-full aspect-[3/4] overflow-hidden bg-gray-50 mb-4 relative">
                @if(isset($newestProductIds) && $newestProductIds->contains($product->id))
                <span class="absolute top-3 left-0 z-10 bg-[#5c6b4a] text-white text-xs uppercase tracking-[0.2em] px-3 py-1.5">
                    New
                </span>
                @endif
                @if($product->images && count($product->images) > 0)
                <img src="{{ asset('storage/' . $product->images[$product->thumbnail_index ?? 0]) }}"
                     alt="{{ $product->name }}"
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
            <p class="text-sm text-gray-800 font-light leading-snug mb-2 line-clamp-1">{{ $product->name }}</p>
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
        <p class="text-xs uppercase tracking-widest text-gray-300">{{ __('app.no_products') }}</p>
    </div>
    @endif
</section>
@endsection

@push('scripts')
<style>
@media (max-width: 768px) {
    .hero-video-wrap { height: 280px !important; }
}
</style>
<script>
// ─── Banner Slider ───
const slider   = document.getElementById('slider');
const dots     = document.querySelectorAll('.dot');
const progress = document.getElementById('sliderProgress');
const total    = {{ $banners->count() > 0 ? $banners->count() : 1 }};
let current    = 0;
let autoplayTimer;
const duration = 5000;

function updateSlider() {
    slider.style.transform = `translateX(-${current * (100 / total)}%)`;

    dots.forEach((dot, i) => {
        if (i === current) {
            dot.classList.add('w-6', 'h-1.5', 'bg-white');
            dot.classList.remove('w-1.5', 'bg-white/30', 'hover:bg-white/60');
        } else {
            dot.classList.remove('w-6', 'h-1.5', 'bg-white');
            dot.classList.add('w-1.5', 'bg-white/30', 'hover:bg-white/60');
        }
    });

    // Ken Burns — zoom out foto aktif
    document.querySelectorAll('[id^="bannerImg"]').forEach((img, i) => {
        img.style.transform = i === current ? 'scale(1)' : 'scale(1.05)';
    });
}

function startProgress() {
    if (!progress) return;
    progress.style.transition = 'none';
    progress.style.width = '0%';
    setTimeout(() => {
        progress.style.transition = `width ${duration}ms linear`;
        progress.style.width = '100%';
    }, 50);
}

function nextSlide() { current = (current + 1) % total; updateSlider(); resetAutoplay(); }
function prevSlide() { current = (current - 1 + total) % total; updateSlider(); resetAutoplay(); }
function goToSlide(i) { current = i; updateSlider(); resetAutoplay(); }

function resetAutoplay() {
    clearInterval(autoplayTimer);
    startProgress();
    autoplayTimer = setInterval(nextSlide, duration);
}

updateSlider();
resetAutoplay();

// ─── Kategori Slider ───
const catSlider = document.getElementById('catSlider');
document.getElementById('catNext').addEventListener('click', () => catSlider.scrollBy({ left: 280, behavior: 'smooth' }));
document.getElementById('catPrev').addEventListener('click', () => catSlider.scrollBy({ left: -280, behavior: 'smooth' }));
</script>
@endpush


