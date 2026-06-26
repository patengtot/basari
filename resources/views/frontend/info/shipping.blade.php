@extends('frontend.layouts.app')
@section('title', 'Shipping Information — Basari.id')
@section('content')

<div class="max-w-3xl mx-auto py-12">
    <div class="text-center mb-12">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Informations</p>
        <h1 class="font-serif text-3xl font-light text-gray-900">Shipping Information</h1>
    </div>

    {{-- Domestic --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8 mb-6">
        <h2 class="font-serif text-xl text-gray-900 mb-6">🇮🇩 Domestic Deliveries</h2>
        <div class="space-y-4 text-sm text-gray-600 leading-relaxed">
            <p>We use JNE, J&T, and other couriers for shipping to all cities in Indonesia.</p>
            <p>All orders will be processed on the same day after payment is confirmed. Orders confirmed after 3 PM will be processed the next day. If your order is confirmed on Saturday after 3 PM, it will be processed the following Monday.</p>
            <p>Shipping fees are automatically calculated at checkout.</p>
            <p>Once your order has been shipped, you will receive an email with your tracking information, or you can track your order by logging into your account and viewing your order history.</p>
            <p>Instant Delivery is only available in Bandung. Please contact us first via chat or WhatsApp at <strong>082120755736</strong>.</p>

            <div class="border-t border-gray-100 pt-4 mt-4">
                <p class="font-medium text-gray-800 mb-2">Shipping Schedule</p>
                <p>Regular & Instant: <strong>Monday – Saturday, 10.00 – 15.00 WIB</strong></p>
                <p class="text-gray-400 text-xs mt-1">Except Sundays and Public Holidays</p>
            </div>
        </div>
    </div>

    {{-- International --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8 mb-6">
        <h2 class="font-serif text-xl text-gray-900 mb-6">🌍 International Deliveries</h2>
        <div class="space-y-4 text-sm text-gray-600 leading-relaxed">
            <p>For worldwide shipping, please contact us via the website, email at <a href="mailto:basari.indonesia@gmail.com" class="text-blue-900 hover:underline">basari.indonesia@gmail.com</a>, or WhatsApp at <strong>082120755736</strong>.</p>
            <p>We ship worldwide using <strong>EMS Pos Indonesia</strong> for all overseas shipments.</p>
            <p>Once your order has been shipped, you will receive an email with tracking information or you can track your order through your account.</p>
            <p>All taxes, duties, and customs fees are the responsibility of the recipient, varying according to the import regulations of the destination country. Basari.id has no control over these fees and cannot reimburse them.</p>
        </div>
    </div>

    {{-- Rules --}}
    <div class="bg-white rounded-xl border border-gray-100 p-8">
        <h2 class="font-serif text-xl text-gray-900 mb-6">📋 Shipping Rules & Restrictions</h2>
        <div class="space-y-3 text-sm text-gray-600 leading-relaxed">
            <p>Basari.id is not responsible for any items lost after delivery confirmation.</p>
            <p>We are not responsible for any additional taxes and duties charged. If you refuse the delivery, you are responsible for all fees charged by the shipping company — both for sending and returning the product.</p>
            <p>Customers are responsible if the courier cannot deliver due to an incomplete address or if the recipient rejects the goods.</p>
        </div>
    </div>
</div>

@endsection