@extends('frontend.layouts.app')
@section('title', 'Return & Exchange — Basari.id')
@section('content')

<div class="max-w-3xl mx-auto py-12">
    <div class="text-center mb-12">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Informations</p>
        <h1 class="font-serif text-3xl font-light text-gray-900">Return & Exchange</h1>
    </div>

    <div class="bg-white rounded-xl border border-gray-100 p-8 mb-6">
        <div class="space-y-4 text-sm text-gray-600 leading-relaxed">
            <p>You have <strong>4 days</strong> from the day you receive our package to contact us.</p>

            <div class="border-t border-gray-100 pt-4 space-y-3">
                <p>✓ Items should be returned new, unused, unwashed, and free from stains, odors, or any damage.</p>
                <p>✓ Before opening your package, please record a clear, uninterrupted unboxing video and take photos to support any future claim.</p>
                <p>✓ Returns and exchanges can only occur once.</p>
                <p>✗ All sale items are not eligible for Returns & Exchange.</p>
                <p>✗ Products that are damaged, soiled, perfumed, or altered will not be accepted and will be sent back to the customer (shipping cost covered by customer).</p>
            </div>
        </div>
    </div>

    <div class="bg-white rounded-xl border border-gray-100 p-8">
        <h2 class="font-serif text-xl text-gray-900 mb-4">🌍 International Orders</h2>
        <p class="text-sm text-gray-600 leading-relaxed">For international orders, if a return or exchange is requested at the customer's discretion (e.g., change of mind, incorrect size), all shipping costs, customs duties, and import/export taxes are the responsibility of the customer. Please note that any original shipping fees paid at the time of purchase are non-refundable.</p>
    </div>
</div>

@endsection