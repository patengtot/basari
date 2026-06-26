@extends('frontend.layouts.app')
@section('title', 'FAQ — Basari.id')
@section('content')

<div class="max-w-3xl mx-auto py-12">
    <div class="text-center mb-12">
        <p class="text-xs uppercase tracking-[0.4em] text-gray-400 mb-4">Informations</p>
        <h1 class="font-serif text-3xl font-light text-gray-900">Frequently Asked Questions</h1>
    </div>

    <div class="space-y-3">
        @foreach([
            ['q' => 'Do I need to sign up an account to order?', 'a' => 'Yes, you are required to sign up before checkout.'],
            ['q' => 'Can I cancel my order?', 'a' => 'No, you cannot cancel your order after payment has been made.'],
            ['q' => 'Can I change my shipping address after my order has been sent?', 'a' => 'Unfortunately no. We only ship to the address provided at checkout.'],
            ['q' => 'Can I pay by credit card?', 'a' => 'Credit card payment is available through our payment gateway.'],
            ['q' => 'How can I track my order?', 'a' => 'You can log in and view your order history, check your email, or use our Track My Order page.'],
            ['q' => 'What if I receive the package but there is a problem with the product?', 'a' => 'Please contact our customer service on WhatsApp 082120755736 and read our Return & Exchange policy.'],
            ['q' => 'Can I add items after I check out?', 'a' => 'Unfortunately you cannot. After checking out, your order is recorded. You will need to place a new order for additional items.'],
            ['q' => 'Do you ship worldwide?', 'a' => 'Yes, we ship worldwide using EMS Pos Indonesia. However, overseas orders cannot be placed directly on the website — please contact us via chat or WhatsApp at 082120755736.'],
        ] as $faq)
        <div class="bg-white rounded-xl border border-gray-100 overflow-hidden">
            <button onclick="this.nextElementSibling.classList.toggle('hidden'); this.querySelector('span').classList.toggle('rotate-45');"
                class="w-full flex items-center justify-between px-6 py-4 text-left">
                <p class="text-sm font-medium text-gray-800">{{ $faq['q'] }}</p>
                <span class="text-gray-400 text-xl transition-transform duration-200 flex-shrink-0 ml-4">+</span>
            </button>
            <div class="hidden px-6 pb-4">
                <p class="text-sm text-gray-500 leading-relaxed">{{ $faq['a'] }}</p>
            </div>
        </div>
        @endforeach
    </div>

    <div class="mt-8 text-center bg-gray-50 rounded-xl p-6">
        <p class="text-sm text-gray-400 mb-3">Can't find your answer? Contact us directly.</p>
        <div class="flex items-center justify-center gap-4">
            <a href="mailto:basari.indonesia@gmail.com" class="text-xs text-blue-900 hover:underline">basari.indonesia@gmail.com</a>
            <span class="text-gray-300">|</span>
            <a href="https://wa.me/6282120755736" target="_blank" class="text-xs text-green-600 hover:underline">WhatsApp 082120755736</a>
        </div>
    </div>
</div>

@endsection