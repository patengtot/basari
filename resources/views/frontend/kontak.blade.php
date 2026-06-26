@extends('frontend.layouts.app')

@section('title', 'Contact — Basari.id')

@section('content')

{{-- Hero --}}
<div class="border-b border-gray-100">
    <div class="max-w-4xl mx-auto px-8 py-24 text-center">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-6">Get In Touch</p>
        <h1 class="font-serif text-4xl md:text-6xl font-light text-gray-900 leading-tight mb-8">
            Contact Us.
        </h1>
        <p class="text-sm text-gray-400 leading-relaxed max-w-lg mx-auto tracking-wide">
            {{ app()->getLocale() === 'id' 
                ? 'Ada pertanyaan atau butuh bantuan? Kami siap membantu kamu menemukan produk yang tepat.'
                : 'Have a question or need help? We are ready to help you find the right product.' }}
        </p>
    </div>
</div>

{{-- Kontak --}}
<section class="max-w-4xl mx-auto px-8 py-20">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-px bg-gray-100">

        {{-- WhatsApp --}}
        <a href="https://wa.me/6282120755736?text=Halo%20Basari,%20saya%20ingin%20bertanya%20tentang%20produk"
           target="_blank"
           class="bg-white p-10 group hover:bg-gray-50 transition duration-300">
            <div class="w-8 h-px bg-gray-300 mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">WhatsApp</p>
            <p class="text-sm text-gray-400 mb-6">+62 821-2075-5736</p>
            <span class="text-xs uppercase tracking-[0.2em] text-gray-400 border-b border-gray-200 pb-1 group-hover:text-gray-900 group-hover:border-gray-900 transition">
                {{ app()->getLocale() === 'id' ? 'Chat Sekarang →' : 'Chat Now →' }}
            </span>
        </a>

        {{-- Email --}}
        <a href="mailto:basari.indonesia@gmail.com?subject={{ app()->getLocale() === 'id' ? 'Pertanyaan tentang produk' : 'Product Inquiry' }}"
           class="bg-white p-10 group hover:bg-gray-50 transition duration-300">
            <div class="w-8 h-px bg-gray-300 mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">Email</p>
            <p class="text-sm text-gray-400 mb-6">basari.indonesia@gmail.com</p>
            <span class="text-xs uppercase tracking-[0.2em] text-gray-400 border-b border-gray-200 pb-1 group-hover:text-gray-900 group-hover:border-gray-900 transition">
                {{ app()->getLocale() === 'id' ? 'Kirim Email →' : 'Send Email →' }}
            </span>
        </a>

        {{-- Instagram --}}
        <a href="https://instagram.com/basari.id" target="_blank"
           class="bg-white p-10 group hover:bg-gray-50 transition duration-300">
            <div class="w-8 h-px bg-gray-300 mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">Instagram</p>
            <p class="text-sm text-gray-400 mb-6">@basari.id</p>
            <span class="text-xs uppercase tracking-[0.2em] text-gray-400 border-b border-gray-200 pb-1 group-hover:text-gray-900 group-hover:border-gray-900 transition">
                {{ app()->getLocale() === 'id' ? 'Follow Kami →' : 'Follow Us →' }}
            </span>
        </a>

        {{-- Jam Operasional --}}
        <div class="bg-white p-10">
            <div class="w-8 h-px bg-gray-300 mb-8"></div>
            <p class="text-xs uppercase tracking-[0.2em] text-gray-800 mb-3">
                {{ app()->getLocale() === 'id' ? 'Jam Operasional' : 'Business Hours' }}
            </p>
            <p class="text-sm text-gray-400 mb-1">
                {{ app()->getLocale() === 'id' ? 'Senin — Sabtu' : 'Monday — Saturday' }}
            </p>
            <p class="text-sm text-gray-600">08.00 — 19.00 WIB</p>
        </div>

    </div>
</section>

{{-- Divider --}}
<div class="border-t border-gray-100"></div>

{{-- Note --}}
<section class="max-w-4xl mx-auto px-8 py-16 text-center">
    <p class="text-xs text-gray-400 leading-relaxed max-w-md mx-auto">
        {{ app()->getLocale() === 'id' 
            ? 'Untuk pertanyaan seputar produk, kamu juga bisa langsung chat penjual melalui halaman detail produk.'
            : 'For product inquiries, you can also chat directly with us through the product detail page.' }}
    </p>
    <a href="{{ route('products.all') }}"
       class="inline-flex items-center gap-3 text-xs uppercase tracking-[0.3em] text-gray-400 border-b border-gray-200 pb-1 hover:text-gray-900 hover:border-gray-900 transition mt-6">
        {{ app()->getLocale() === 'id' ? 'Lihat Produk' : 'View Products' }}
        <span class="w-6 h-px bg-gray-400"></span>
    </a>
</section>

@endsection