@extends('admin.layouts.app')

@section('title', 'Detail Pembeli — Basari Admin')
@section('header', 'Detail Pembeli')

@section('content')

<div class="max-w-2xl space-y-6">

    {{-- Info Pembeli --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <div class="flex items-center gap-4 mb-6">
            <div class="w-14 h-14 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 text-xl font-bold">
                {{ strtoupper(substr($user->name, 0, 1)) }}
            </div>
            <div>
                <p class="font-semibold text-gray-800 text-lg">{{ $user->name }}</p>
                <p class="text-sm text-gray-400">Bergabung {{ $user->created_at->format('d M Y') }}</p>
            </div>
        </div>

        <div class="grid grid-cols-2 gap-4 text-sm">
            <div>
                <p class="text-gray-400 mb-1">Email</p>
                <p class="font-medium text-gray-700">{{ $user->email }}</p>
            </div>
            <div>
                <p class="text-gray-400 mb-1">No. HP</p>
                <p class="font-medium text-gray-700">{{ $user->phone ?? '-' }}</p>
            </div>
            <div class="col-span-2">
                <p class="text-gray-400 mb-1">Alamat</p>
                <p class="font-medium text-gray-700">{{ $user->address ?? '-' }}</p>
            </div>
            <div>
                <p class="text-gray-400 mb-1">Kota</p>
                <p class="font-medium text-gray-700">{{ $user->city ?? '-' }}</p>
            </div>
            <div>
                <p class="text-gray-400 mb-1">Kode Pos</p>
                <p class="font-medium text-gray-700">{{ $user->postal_code ?? '-' }}</p>
            </div>
        </div>
    </div>

    {{-- Riwayat Pesanan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-4">Riwayat Pesanan</h2>

        @if($user->orders->count() > 0)
        <div class="space-y-3">
            @foreach($user->orders as $order)
            <a href="{{ route('admin.orders.show', $order) }}"
               class="flex items-center justify-between p-3 rounded-lg border border-gray-100 hover:bg-gray-50 transition">
                <div>
                    <p class="text-sm font-medium text-gray-800">{{ $order->invoice_number }}</p>
                    <p class="text-xs text-gray-400 mt-0.5">{{ $order->created_at->format('d M Y, H:i') }}</p>
                </div>
                <div class="text-right">
                    <p class="text-sm font-bold text-blue-900">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</p>
                    <span class="text-xs px-2 py-0.5 rounded-full
                        @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                        @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                        @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                        @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                        @elseif($order->status === 'done') bg-green-100 text-green-700
                        @else bg-red-100 text-red-700 @endif">
                        {{ ucfirst($order->status) }}
                    </span>
                </div>
            </a>
            @endforeach
        </div>
        @else
        <p class="text-gray-400 text-sm">Belum ada pesanan.</p>
        @endif
    </div>

    <a href="{{ route('admin.users.index') }}" class="text-sm text-gray-400 hover:text-gray-600">← Kembali ke daftar pembeli</a>

</div>

@endsection
