@extends('frontend.layouts.app')

@section('title', 'Chat — Basari')

@section('content')

<div class="max-w-2xl mx-auto">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Chat</h1>

    @if($conversations->count() > 0)
    <div class="space-y-3">
        @foreach($conversations as $conv)
        <a href="{{ route('chat.show', $conv->id) }}"
           class="bg-white rounded-xl border border-gray-100 p-4 flex gap-4 items-center hover:shadow-sm transition block">

            {{-- Icon Chat --}}
            <div class="w-14 h-14 rounded-xl bg-blue-50 overflow-hidden flex-shrink-0 flex items-center justify-center">
                @if($conv->product && $conv->product->images && count($conv->product->images) > 0)
                <img src="{{ asset('storage/' . $conv->product->images[$conv->product->thumbnail_index ?? 0]) }}"
                    class="w-14 h-14 object-cover">
                @else
                <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                </svg>
                @endif
            </div>

            <div class="flex-1 min-w-0">
                <p class="font-medium text-gray-800 text-sm">
                    @if($conv->order)
                    🧾 Pesanan {{ $conv->order->invoice_number }}
                    @elseif($conv->product)
                    {{ $conv->product->localized_name }}
                    @else
                    💬 Pesan Umum
                    @endif
                </p>
                <p class="text-xs text-gray-400 truncate mt-0.5">
                    {{ $conv->latestMessage ? $conv->latestMessage->body : 'Belum ada pesan' }}
                </p>
            </div>

            <div class="text-right flex-shrink-0">
                <p class="text-xs text-gray-400">{{ $conv->last_message_at?->diffForHumans() }}</p>
                @php
                    $unread = $conv->messages()->where('sender', 'admin')->where('is_read', false)->count();
                @endphp
                @if($unread > 0)
                <span class="inline-block mt-1 bg-blue-800 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
                    {{ $unread }}
                </span>
                @endif
            </div>
        </a>
        @endforeach
    </div>
    @else
    <div class="text-center py-20 text-gray-400">
        <p>Belum ada pesan.</p>
        <a href="{{ route('home') }}" class="btn-primary inline-block mt-4">Mulai Belanja</a>
    </div>
    @endif
</div>

@endsection
