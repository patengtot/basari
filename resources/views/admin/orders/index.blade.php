@extends('admin.layouts.app')

@section('title', 'Pesanan — Basari Admin')
@section('header', 'Kelola Pesanan')

@section('content')

{{-- Tab Status --}}
@php
$statuses = [
    ''                       => 'Semua',
    'pending'                => 'Pending',
    'waiting_shipping_cost'  => 'Menunggu Ongkir',
    'paid'                   => 'Paid',
    'processing'             => 'Processing',
    'shipped'                => 'Shipped',
    'done'                   => 'Done',
    'cancelled'              => 'Cancelled',
];
@endphp

<div class="flex gap-2 flex-wrap mb-4 overflow-x-auto pb-1">
    @foreach($statuses as $value => $label)
    <a href="{{ route('admin.orders.index', $value ? ['status' => $value] : []) }}"
       class="px-4 py-2 rounded-xl text-sm font-medium transition border-2 flex-shrink-0
              {{ request('status', '') === $value
                  ? 'border-blue-700 bg-blue-50 text-blue-900'
                  : 'border-gray-200 text-gray-600 hover:border-blue-400' }}">
        {{ $label }}
        <span class="ml-1 text-xs opacity-60">({{ $value ? $allOrders->where('status', $value)->count() : $allOrders->count() }})</span>
    </a>
    @endforeach
</div>

<div class="bg-white rounded-xl border border-gray-100 overflow-hidden">
    <table class="w-full text-sm">
        <thead>
            <tr class="text-left text-gray-400 border-b border-gray-100 bg-gray-50">
                <th class="px-4 py-3 font-medium">Invoice</th>
                <th class="px-4 py-3 font-medium">Pembeli</th>
                <th class="px-4 py-3 font-medium">Produk</th>
                <th class="px-4 py-3 font-medium">Total</th>
                <th class="px-4 py-3 font-medium">Status</th>
                <th class="px-4 py-3 font-medium">Tanggal</th>
                <th class="px-4 py-3 font-medium">Aksi</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
            @forelse($orders as $order)
            <tr>
                <td class="px-4 py-3 font-medium text-gray-800">
                    {{ $order->invoice_number }}
                    @if($order->shipping_type === 'international')
                    <span class="ml-1 text-xs px-1.5 py-0.5 rounded bg-blue-100 text-blue-700">🌍 Intl</span>
                    @endif
                </td>
                <td class="px-4 py-3 text-gray-600">{{ $order->user->name }}</td>
                <td class="px-4 py-3">
                    <div class="space-y-0.5">
                        @foreach($order->items->take(2) as $item)
                        <p class="text-xs text-gray-600 line-clamp-1">{{ $item->product_name }}</p>
                        @endforeach
                        @if($order->items->count() > 2)
                        <p class="text-xs text-gray-400">+{{ $order->items->count() - 2 }} produk lainnya</p>
                        @endif
                    </div>
                </td>
                <td class="px-4 py-3 text-blue-900 font-semibold">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</td>
                <td class="px-4 py-3">
                    <span class="text-xs px-2 py-1 rounded-full
                        @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                        @elseif($order->status === 'waiting_shipping_cost') bg-orange-100 text-orange-700
                        @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                        @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                        @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                        @elseif($order->status === 'done') bg-green-100 text-green-700
                        @else bg-red-100 text-red-700 @endif">
                        {{ $order->status === 'waiting_shipping_cost' ? 'Menunggu Ongkir' : ucfirst($order->status) }}
                    </span>
                </td>
                <td class="px-4 py-3 text-gray-400">{{ $order->created_at->format('d M Y') }}</td>
                <td class="px-4 py-3 flex items-center gap-3">
                    <a href="{{ route('admin.orders.show', $order) }}"
                       class="text-blue-500 hover:underline text-xs">Detail</a>

                    @if(in_array($order->status, ['done', 'cancelled']))
                    <form method="POST" action="{{ route('admin.orders.destroy', $order) }}"
                          onsubmit="return confirm('Hapus pesanan {{ $order->invoice_number }}?')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-red-500 hover:underline text-xs">Hapus</button>
                    </form>
                    @else
                    <span class="text-xs text-gray-300 italic">Tidak bisa dihapus</span>
                    @endif
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="6" class="px-4 py-8 text-center text-gray-400">Belum ada pesanan.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

@endsection