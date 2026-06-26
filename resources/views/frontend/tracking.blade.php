@extends('frontend.layouts.app')

@section('title', 'Lacak Pesanan — Basari.id')

@section('content')

<div class="max-w-2xl mx-auto py-12">

    {{-- Hero --}}
    <div class="text-center mb-10">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Track Order</p>
        <h1 class="font-serif text-3xl font-light text-gray-900 mb-3">Lacak Pesanan</h1>
        <p class="text-sm text-gray-400">Masukkan nomor invoice untuk melacak status pengiriman kamu.</p>
    </div>

    {{-- Form --}}
    <form method="POST" action="{{ route('tracking.search') }}" class="mb-8">
        @csrf
        <div class="flex gap-3">
            <input type="text" name="invoice"
                value="{{ old('invoice', isset($order) ? $order->invoice_number : '') }}"
                placeholder="Contoh: BSR-XXXXXXXX"
                class="flex-1 border border-gray-200 rounded-lg px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300">
            <button type="submit" class="btn-primary px-6">Lacak</button>
        </div>
        @if(session('error'))
        <p class="text-red-500 text-xs mt-2">{{ session('error') }}</p>
        @endif
    </form>

    {{-- Hasil --}}
    @isset($order)
    <div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
        <div class="flex items-center justify-between mb-4">
            <div>
                <p class="font-semibold text-gray-800">{{ $order->invoice_number }}</p>
                <p class="text-xs text-gray-400">{{ $order->created_at->format('d M Y, H:i') }}</p>
            </div>
            <span class="text-xs px-3 py-1 rounded-full
                @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                @elseif($order->status === 'done') bg-green-100 text-green-700
                @else bg-red-100 text-red-700 @endif">
                {{ __('app.' . $order->status) }}
            </span>
        </div>

        <div class="text-sm text-gray-600 space-y-1 border-t border-gray-50 pt-4">
            <p><span class="text-gray-400">Penerima:</span> {{ $order->shipping_name }}</p>
            <p><span class="text-gray-400">Alamat:</span> {{ $order->shipping_address }}, {{ $order->shipping_city }}</p>
            @if($order->courier)
            <p><span class="text-gray-400">Kurir:</span> {{ strtoupper($order->courier) }} {{ $order->courier_service }}</p>
            @endif
            @if($order->tracking_number)
            <p><span class="text-gray-400">Nomor Resi:</span> <span class="font-bold text-blue-900">{{ $order->tracking_number }}</span></p>
            @endif
        </div>
    </div>

    {{-- Tracking Domestik --}}
    @if($order->shipping_type === 'domestic')
        @if(isset($tracking) && count($tracking) > 0)
        <div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
            <h2 class="font-semibold text-gray-800 mb-4">Update Pengiriman</h2>
            <div class="space-y-4">
                @foreach(array_reverse($tracking) as $index => $track)
                <div class="flex gap-4">
                    <div class="flex flex-col items-center">
                        <div class="w-3 h-3 rounded-full flex-shrink-0 mt-1
                            {{ $index === 0 ? 'bg-blue-900' : 'bg-gray-300' }}"></div>
                        @if(!$loop->last)
                        <div class="w-px flex-1 bg-gray-200 mt-1" style="min-height: 24px;"></div>
                        @endif
                    </div>
                    <div class="pb-4 flex-1">
                        <p class="text-xs text-gray-400">
                            {{ isset($track['updated_at']) ? \Carbon\Carbon::parse($track['updated_at'])->format('d M Y, H:i') : '' }}
                        </p>
                        <p class="text-sm text-gray-700 font-medium mt-0.5">
                            {{ $track['note'] ?? ($track['status'] ?? '') }}
                        </p>
                    </div>
                </div>
                @endforeach
            </div>
        </div>
        @else
        <div class="bg-white rounded-xl border border-gray-100 p-6 mb-6 text-center">
            <p class="text-sm text-gray-400">Belum ada update pengiriman.</p>
        </div>
        @endif

    {{-- Tracking Internasional --}}
    @elseif($order->shipping_type === 'international')
    <div class="bg-blue-50 border border-blue-100 rounded-xl p-6 mb-6">
        <div class="flex items-start gap-3">
            <span class="text-2xl">🌍</span>
            <div>
                <p class="font-semibold text-gray-800 mb-1">Pengiriman Internasional</p>
                <p class="text-sm text-gray-500 mb-4">
                    Untuk tracking pengiriman internasional, silakan hubungi admin kami secara langsung.
                </p>
                <div class="flex flex-col sm:flex-row gap-3">
                    <a href="https://wa.me/6282120755736?text=Halo%20Basari%2C%20saya%20ingin%20melacak%20pesanan%20{{ $order->invoice_number }}"
                       target="_blank"
                       class="flex items-center gap-2 px-4 py-2.5 rounded-lg text-white text-sm font-medium"
                       style="background-color: #25D366;">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                        </svg>
                        Chat WhatsApp
                    </a>
                    @auth
                    <a href="{{ route('chat.index') }}"
                       class="flex items-center gap-2 px-4 py-2.5 rounded-lg text-white text-sm font-medium bg-blue-900 hover:bg-blue-800 transition">
                        💬 Chat dengan Admin
                    </a>
                    @endauth
                </div>
            </div>
        </div>
    </div>
    @endif

    @endisset

</div>

@endsection