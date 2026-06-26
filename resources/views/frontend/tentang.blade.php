@extends('frontend.layouts.app')

@section('title', 'Tentang Kami — Basari.id')

@section('content')

{{-- Hero --}}
<div class="relative overflow-hidden bg-gray-50 border-b border-gray-100">
    <div class="max-w-4xl mx-auto px-8 py-24 text-center">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-6">Our Story</p>
        <h1 class="font-serif text-4xl md:text-6xl font-light text-gray-900 leading-tight mb-8">
            Fashion That<br>Defines You.
        </h1>
        <p class="text-sm text-gray-400 leading-relaxed max-w-lg mx-auto tracking-wide">
            Kami hadir untuk memenuhi kebutuhan fashion wanita modern Indonesia dengan koleksi pilihan berkualitas.
        </p>
    </div>
</div>

{{-- Siapa Kami --}}
<section class="max-w-4xl mx-auto px-8 py-20">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-16 items-center">
        <div>
            <p class="text-xs uppercase tracking-[0.3em] text-gray-400 mb-6">Tentang Basari</p>
            <h2 class="font-serif text-3xl font-light text-gray-900 leading-snug mb-6">
                Lebih dari sekadar fashion.
            </h2>
            <p class="text-sm text-gray-500 leading-relaxed mb-4">
                Basari adalah toko fashion wanita online yang menyediakan berbagai koleksi pakaian berkualitas mulai dari outer, atasan, hingga celana. Kami berkomitmen menghadirkan produk terbaik dengan harga yang terjangkau untuk wanita Indonesia.
            </p>
            <p class="text-sm text-gray-500 leading-relaxed">
                Setiap produk yang kami hadirkan dipilih dengan cermat untuk memastikan kualitas dan kenyamanan pelanggan kami. Kepuasan kamu adalah prioritas utama kami.
            </p>
        </div>
        <div class="aspect-[4/5] bg-gray-100 overflow-hidden">
            <img src="{{ asset('images/about.jpg') }}" alt="Basari.id"
                 class="w-full h-full object-cover"
                 onerror="this.parentElement.innerHTML='<div class=\'w-full h-full bg-gray-100 flex items-center justify-center\'><p class=\'text-xs uppercase tracking-widest text-gray-300\'>BASARI.ID</p></div>'">
        </div>
    </div>
</section>

{{-- Divider --}}
<div class="border-t border-gray-100"></div>

{{-- Keunggulan --}}
<section class="max-w-4xl mx-auto px-8 py-20">
    <p class="text-xs uppercase tracking-[0.3em] text-gray-400 text-center mb-14">Mengapa Basari</p>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
        <div class="text-center">
            <div class="w-12 h-px bg-gray-300 mx-auto mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">Produk Berkualitas</p>
            <p class="text-xs text-gray-400 leading-relaxed">
                Setiap produk dipilih dengan teliti untuk memastikan kualitas dan kenyamanan terbaik.
            </p>
        </div>
        <div class="text-center">
            <div class="w-12 h-px bg-gray-300 mx-auto mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">Harga Terjangkau</p>
            <p class="text-xs text-gray-400 leading-relaxed">
                Fashion berkualitas tidak harus mahal. Kami hadir dengan harga terbaik untuk semua kalangan.
            </p>
        </div>
        <div class="text-center">
            <div class="w-12 h-px bg-gray-300 mx-auto mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">Pelayanan Terbaik</p>
            <p class="text-xs text-gray-400 leading-relaxed">
                Tim kami siap membantu kamu menemukan produk yang tepat kapanpun kamu butuhkan.
            </p>
        </div>
    </div>
</section>

{{-- Divider --}}
<div class="border-t border-gray-100"></div>

{{-- CTA --}}
<section class="max-w-4xl mx-auto px-8 py-20 text-center">
    <p class="text-xs uppercase tracking-[0.3em] text-gray-400 mb-6">Mulai Belanja</p>
    <h2 class="font-serif text-3xl font-light text-gray-900 mb-8">
        Temukan koleksi favoritmu.
    </h2>
    <a href="{{ route('products.all') }}"
       class="inline-flex items-center gap-3 text-xs uppercase tracking-[0.3em] text-gray-600 border-b border-gray-300 pb-1 hover:text-gray-900 hover:border-gray-900 transition">
        Lihat Semua Produk
        <span class="w-6 h-px bg-gray-400"></span>
    </a>
</section>

@endsection