@extends('frontend.layouts.app')
@section('title', 'How to Order — Basari.id')
@section('content')

<div class="max-w-3xl mx-auto py-12">
    <div class="text-center mb-12">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Informations</p>
        <h1 class="font-serif text-3xl font-light text-gray-900">How to Order</h1>
    </div>

    <div class="space-y-4">
        @foreach([
            ['step' => '01', 'title' => 'Create an Account', 'desc' => 'Sign up for a Basari.id account. You need an account to place an order.'],
            ['step' => '02', 'title' => 'Browse & Select', 'desc' => 'Browse our collections and select the items you want. Choose your size and color, then click "Add to Cart".'],
            ['step' => '03', 'title' => 'Review Your Cart', 'desc' => 'Go to your cart and review your selected items. Make sure everything is correct before proceeding.'],
            ['step' => '04', 'title' => 'Checkout', 'desc' => 'Fill in your shipping address and select your preferred courier. Shipping costs will be calculated automatically.'],
            ['step' => '05', 'title' => 'Payment', 'desc' => 'Complete your payment through our secure payment gateway. You will receive a confirmation email once payment is verified.'],
            ['step' => '06', 'title' => 'Order Processing', 'desc' => 'Once payment is confirmed, your order will be processed and shipped. You will receive a tracking number via email.'],
        ] as $item)
        <div class="bg-white rounded-xl border border-gray-100 p-6 flex gap-5">
            <p class="font-serif text-3xl font-light text-gray-200 flex-shrink-0">{{ $item['step'] }}</p>
            <div>
                <p class="font-medium text-gray-800 mb-1">{{ $item['title'] }}</p>
                <p class="text-sm text-gray-500 leading-relaxed">{{ $item['desc'] }}</p>
            </div>
        </div>
        @endforeach
    </div>

    <div class="mt-8 text-center">
        <a href="{{ route('products.all') }}" class="inline-flex items-center gap-3 text-xs uppercase tracking-[0.3em] text-gray-600 border-b border-gray-300 pb-1 hover:text-gray-900 hover:border-gray-900 transition">
            Start Shopping
            <span class="w-6 h-px bg-gray-400"></span>
        </a>
    </div>
</div>

@endsection