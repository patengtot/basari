@extends('frontend.layouts.app')

@section('title', __('app.orders') . ' — Basari')

@section('content')

<h1 class="text-2xl font-bold text-gray-800 mb-6">{{ __('app.orders') }}</h1>

@if($orders->count() > 0)
<div class="space-y-4">
    @foreach($orders as $order)
    <a href="{{ route('orders.show', $order->id) }}"
       class="bg-white rounded-xl border border-gray-100 p-5 flex items-center justify-between hover:shadow-sm transition block">
        <div>
            <p class="font-medium text-gray-800">{{ $order->invoice_number }}</p>
            <p class="text-sm text-gray-400 mt-1">{{ $order->created_at->format('d M Y, H:i') }}</p>
        </div>
        <div class="text-right">
            @php
                $currency = $order->preferred_currency ?? 'IDR';
                $converted = \App\Helpers\CurrencyHelper::convert($order->total_amount, $currency);
                $formatted = \App\Helpers\CurrencyHelper::format($converted, $currency);
            @endphp
            <p class="font-bold text-blue-900">{{ $formatted }}</p>
            <span class="inline-block mt-1 text-xs px-2 py-1 rounded-full
                @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                @elseif($order->status === 'waiting_shipping_cost') bg-orange-100 text-orange-700
                @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                @elseif($order->status === 'done') bg-green-100 text-green-700
                @else bg-red-100 text-red-700 @endif">
                {{ $order->status === 'waiting_shipping_cost'
                    ? (__('app.waiting_shipping_cost') ?? 'Menunggu Ongkir')
                    : __('app.' . $order->status) ?? ucfirst($order->status) }}
            </span>
        </div>
    </a>
    @endforeach
</div>
@else
<div class="text-center py-20">
    <p class="text-gray-400 mb-4">{{ __('app.no_orders') ?? 'Belum ada pesanan.' }}</p>
    <a href="{{ route('home') }}" class="btn-primary">{{ __('app.start_shopping') ?? 'Mulai Belanja' }}</a>
</div>
@endif

@endsection