@extends('admin.layouts.app')

@section('title', 'Chat — Basari Admin')
@section('header', 'Detail Chat')

@section('content')

<div class="max-w-2xl space-y-4">

    {{-- Info Pembeli --}}
    <div class="bg-white rounded-xl border border-gray-100 p-4 flex items-center gap-3">
        <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 font-bold">
            {{ strtoupper(substr($conversation->user->name, 0, 1)) }}
        </div>
        <div>
            <p class="font-semibold text-gray-800">{{ $conversation->user->name }}</p>
            <p class="text-xs text-gray-400">{{ $conversation->user->email }}</p>
        </div>
    </div>

    {{-- Card Produk --}}
    @if($conversation->product)
    <div class="bg-gray-50 rounded-xl p-3 flex gap-3 items-center border border-gray-100">
        <div class="w-12 h-12 rounded-lg overflow-hidden bg-white flex-shrink-0">
            @if($conversation->product->images && count($conversation->product->images) > 0)
            <img src="{{ asset('storage/' . $conversation->product->images[0]) }}"
                 class="w-12 h-12 object-cover">
            @endif
        </div>
        <div>
            <p class="text-sm font-medium text-gray-800">{{ $conversation->product->name }}</p>
            <p class="text-blue-900 text-sm font-bold">Rp {{ number_format($conversation->product->price, 0, ',', '.') }}</p>
        </div>
    </div>
    @endif

    {{-- Pesan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-4 space-y-3 min-h-64 max-h-96 overflow-y-auto" id="chatBox">
        @forelse($conversation->messages as $message)
        <div class="flex {{ $message->sender === 'admin' ? 'justify-end' : 'justify-start' }}">
            <div class="max-w-xs {{ $message->sender === 'admin' ? 'bg-blue-800 text-white' : 'bg-gray-100 text-gray-800' }} rounded-2xl px-4 py-2 text-sm">
                <p>{{ $message->body }}</p>
                <p class="text-xs mt-1 {{ $message->sender === 'admin' ? 'text-blue-200' : 'text-gray-400' }}">
                    {{ $message->created_at->format('H:i') }}
                </p>
            </div>
        </div>
        @empty
        <p class="text-center text-gray-400 text-sm py-8">Belum ada pesan.</p>
        @endforelse
    </div>

    {{-- Form Balas --}}
    <form method="POST" action="{{ route('admin.chat.send', $conversation->id) }}"
          class="flex gap-2">
        @csrf
        <input type="text" name="body" placeholder="Tulis balasan..."
               class="input-field flex-1" required autocomplete="off">
        <button type="submit"
                class="bg-blue-900 hover:bg-blue-800 text-white px-4 py-2 rounded-lg transition flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
            </svg>
        </button>
    </form>

    <a href="{{ route('admin.chat.index') }}" class="text-sm text-gray-400 hover:text-gray-600">← Kembali</a>

</div>

<script>
    const chatBox = document.getElementById('chatBox');
    chatBox.scrollTop = chatBox.scrollHeight;
</script>

@endsection
