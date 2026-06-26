@extends('frontend.layouts.app')

@section('title', 'Chat — Basari')

@section('content')

<div class="max-w-2xl mx-auto">

    {{-- Header --}}
    <div class="flex items-center gap-3 mb-4">
        <a href="{{ route('chat.index') }}" class="text-gray-400 hover:text-gray-600">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
            </svg>
        </a>
        <div>
            <p class="font-semibold text-gray-800">Basari Store</p>
            <p class="text-xs text-gray-400">Penjual</p>
        </div>
    </div>

    {{-- Card Produk --}}
    @if($conversation->product)
    <div class="bg-gray-50 rounded-xl p-3 mb-4 flex gap-3 items-center border border-gray-100">
        <div class="w-12 h-12 rounded-lg overflow-hidden bg-white flex-shrink-0">
            @if($conversation->product->images && count($conversation->product->images) > 0)
            <img src="{{ asset('storage/' . $conversation->product->images[$conversation->product->thumbnail_index ?? 0]) }}"
                 class="w-12 h-12 object-cover">
            @endif
        </div>
        <div class="flex-1 min-w-0">
            <p class="text-sm font-medium text-gray-800 truncate">{{ $conversation->product->localized_name }}</p>
            <p class="text-blue-900 text-sm font-bold">Rp {{ number_format($conversation->product->price, 0, ',', '.') }}</p>
        </div>
        <a href="{{ route('products.show', $conversation->product->slug) }}"
           class="text-xs text-blue-500 hover:underline flex-shrink-0">Lihat</a>
    </div>
    @endif

    {{-- Pesan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-4 mb-4 space-y-3 min-h-64 max-h-96 overflow-y-auto" id="chatBox">
        @forelse($conversation->messages as $message)
        <div class="flex {{ $message->sender === 'user' ? 'justify-end' : 'justify-start' }}">
            <div class="max-w-xs {{ $message->sender === 'user' ? 'bg-blue-800 text-white' : 'bg-gray-100 text-gray-800' }} rounded-2xl px-4 py-2 text-sm">
                <p>{{ $message->body }}</p>
                <p class="text-xs mt-1 {{ $message->sender === 'user' ? 'text-blue-200' : 'text-gray-400' }}">
                    {{ $message->created_at->format('H:i') }}
                </p>
            </div>
        </div>
        @empty
        <p class="text-center text-gray-400 text-sm py-8">Mulai percakapan dengan mengirim pesan.</p>
        @endforelse
    </div>

    {{-- Form Kirim --}}
    <form method="POST" action="{{ route('chat.send', $conversation->id) }}"
          class="flex gap-2">
        @csrf
        <input type="text" name="body" placeholder="Tulis pesan..."
               class="input-field flex-1" required autocomplete="off">
        <button type="submit"
                class="bg-blue-900 hover:bg-blue-800 text-white px-4 py-2 rounded-lg transition flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
            </svg>
        </button>
    </form>

</div>

<script>
    const chatBox = document.getElementById('chatBox');
    chatBox.scrollTop = chatBox.scrollHeight;
</script>

@endsection
