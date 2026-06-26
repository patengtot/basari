@extends('frontend.layouts.app')
@section('title', 'Payment Method — Basari.id')
@section('content')

<div class="max-w-3xl mx-auto py-12">
    <div class="text-center mb-12">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Informations</p>
        <h1 class="font-serif text-3xl font-light text-gray-900">Payment Method</h1>
        <p class="text-sm text-gray-400 mt-3">We accept various payment methods through Midtrans.</p>
    </div>

    {{-- E-Wallet & QRIS --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8 mb-6">
        <p class="text-xs uppercase tracking-[0.3em] text-gray-400 mb-6">E-Wallet & QRIS</p>
        <div class="flex flex-wrap gap-4 items-center">
            <div class="border border-gray-100 rounded-lg p-4 flex flex-col items-center justify-center gap-2" style="min-width:100px; height:72px;">
                <img src="{{ asset('images/payment/qris.png') }}" alt="QRIS" class="h-8 object-contain">
            </div>
            <div class="border border-gray-100 rounded-lg p-4 flex flex-col items-center justify-center gap-2" style="min-width:100px; height:72px;">
                <img src="{{ asset('images/payment/gopay.png') }}" alt="GoPay" class="h-8 object-contain">
            </div>
        </div>
        <p class="text-xs text-gray-400 mt-4">QRIS can be used for all e-wallets that support QRIS such as OVO, ShopeePay, DANA, LinkAja, and others.</p>
    </div>

    {{-- Virtual Account --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8 mb-6">
        <p class="text-xs uppercase tracking-[0.3em] text-gray-400 mb-6">Virtual Account & Bank Transfer</p>
        <div class="flex flex-wrap gap-4 items-center">
            @foreach(['bni' => 'BNI', 'bri' => 'BRI', 'mandiri' => 'Mandiri', 'permata' => 'Permata', 'bsi' => 'BSI'] as $file => $name)
            <div class="border border-gray-100 rounded-lg p-4 flex flex-col items-center justify-center gap-2" style="min-width:100px; height:72px;">
                <img src="{{ asset('images/payment/' . $file . '.png') }}" alt="{{ $name }}" class="h-8 object-contain"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='block'">
                <span class="text-xs text-gray-500 hidden">{{ $name }}</span>
            </div>
            @endforeach
        </div>
        <p class="text-xs text-gray-400 mt-4">Pay via ATM, Internet Banking, or Mobile Banking of your bank.</p>
    </div>

    {{-- International --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8">
        <p class="text-xs uppercase tracking-[0.3em] text-gray-400 mb-6">International Payment</p>
        <div class="flex flex-wrap gap-4 items-center mb-4">
            <div class="border border-gray-100 rounded-lg p-4 flex flex-col items-center justify-center gap-2" style="min-width:100px; height:72px;">
                <img src="{{ asset('images/payment/paypal.png') }}" alt="PayPal" class="h-8 object-contain"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='block'">
                <span class="text-xs text-gray-500 hidden">PayPal</span>
            </div>
        </div>
        <p class="text-xs text-gray-400">For international orders via PayPal. Contact us at
            <a href="mailto:basari.indonesia@gmail.com" class="text-blue-900 hover:underline">basari.indonesia@gmail.com</a>
            or WhatsApp <strong>082120755736</strong>.
        </p>
    </div>

</div>

@endsection