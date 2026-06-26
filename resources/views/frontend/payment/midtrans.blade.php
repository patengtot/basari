@extends('frontend.layouts.app')

@section('title', 'Pembayaran — Basari')

@section('content')
<div class="max-w-lg mx-auto text-center py-10">

    <div class="bg-white rounded-xl border border-gray-100 p-8">
        <h1 class="text-xl font-bold text-gray-800 mb-2">Selesaikan Pembayaran</h1>
        <p class="text-sm text-gray-400 mb-2">Pesanan: <span class="font-medium text-gray-700">{{ $order->invoice_number }}</span></p>
        <p class="text-2xl font-bold text-blue-900 mb-6">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</p>

        <button id="pay-button" class="btn-primary w-full text-center py-3 text-base">
            Pilih Metode Pembayaran
        </button>

        <p class="text-xs text-gray-400 mt-4">
            Didukung: Transfer Bank, QRIS, GoPay, OVO, DANA, ShopeePay, Virtual Account, Kartu Kredit
        </p>

        <a href="{{ route('orders.show', $order->id) }}" class="block text-xs text-gray-400 hover:text-gray-600 mt-3">
            ← Kembali ke detail pesanan
        </a>
    </div>

</div>
@endsection

@push('scripts')
<script src="https://app.sandbox.midtrans.com/snap/snap.js"
        data-client-key="{{ config('midtrans.client_key') }}"></script>
<script>
document.getElementById('pay-button').onclick = function() {
    snap.pay('{{ $snapToken }}', {
        onSuccess: function(result) {
            window.location.href = '{{ route('orders.show', $order->id) }}';
        },
        onPending: function(result) {
            window.location.href = '{{ route('orders.show', $order->id) }}';
        },
        onError: function(result) {
            alert('Pembayaran gagal. Silakan coba lagi.');
        },
        onClose: function() {
            // Customer tutup popup tanpa bayar
        }
    });
};
</script>
@endpush