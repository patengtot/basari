@extends('admin.layouts.app')

@section('title', 'Pesan — Basari Admin')
@section('header', 'Pesan Masuk')

@section('content')

{{-- Tombol Mulai Chat Baru --}}
<div class="flex justify-end mb-4">
    <button onclick="document.getElementById('modalNewChat').classList.remove('hidden')"
        class="btn-primary text-sm flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
        </svg>
        Chat ke Customer
    </button>
</div>

{{-- Modal Pilih Customer --}}
<div id="modalNewChat" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/40">
    <div class="bg-white rounded-xl shadow-xl w-full max-w-md p-6">
        <div class="flex items-center justify-between mb-4">
            <h2 class="font-semibold text-gray-800">Pilih Customer</h2>
            <button onclick="document.getElementById('modalNewChat').classList.add('hidden')"
                class="text-gray-400 hover:text-gray-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        {{-- Search --}}
        <input type="text" id="userSearch" placeholder="Cari nama atau email..."
            class="input-field mb-3" oninput="filterUsers(this.value)">

        {{-- List User --}}
        <div class="space-y-2 max-h-64 overflow-y-auto" id="userList">
            @foreach($users as $user)
            <form method="POST" action="{{ route('admin.chat.start-user') }}">
                @csrf
                <input type="hidden" name="user_id" value="{{ $user->id }}">
                <button type="submit"
                    class="user-item w-full flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-gray-50 transition text-left border border-gray-100">
                    <div class="w-9 h-9 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 font-bold text-sm flex-shrink-0">
                        {{ strtoupper(substr($user->name, 0, 1)) }}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-sm font-medium text-gray-800 user-name">{{ $user->name }}</p>
                        <p class="text-xs text-gray-400 user-email">{{ $user->email }}</p>
                    </div>
                </button>
            </form>
            @endforeach
        </div>
    </div>
</div>

<div class="bg-white rounded-xl border border-gray-100 overflow-hidden">
    @forelse($conversations as $conv)
    <div class="flex gap-4 items-center p-4 border-b border-gray-50 hover:bg-gray-50 transition">

        {{-- Avatar --}}
        <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 font-bold flex-shrink-0">
            {{ strtoupper(substr($conv->user->name, 0, 1)) }}
        </div>

        <a href="{{ route('admin.chat.show', $conv->id) }}" class="flex-1 min-w-0">
            <div class="flex items-center justify-between">
                <p class="font-medium text-gray-800 text-sm">{{ $conv->user->name }}</p>
                <p class="text-xs text-gray-400">{{ $conv->last_message_at?->diffForHumans() }}</p>
            </div>
            <p class="text-xs text-gray-500 truncate mt-0.5">
                @if($conv->order)
                🧾 Pesanan {{ $conv->order->invoice_number }}
                @elseif($conv->product)
                📦 {{ $conv->product->name }}
                @else
                💬 Pesan umum
                @endif
            </p>
            <p class="text-xs text-gray-400 truncate">
                {{ $conv->latestMessage ? $conv->latestMessage->body : 'Belum ada pesan' }}
            </p>
        </a>

        @php $unread = $conv->unreadByAdmin(); @endphp
        @if($unread > 0)
        <span class="bg-blue-900 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center flex-shrink-0">
            {{ $unread }}
        </span>
        @endif

        {{-- Tombol Hapus --}}
        <form method="POST" action="{{ route('admin.chat.destroy', $conv->id) }}"
              onsubmit="return confirm('Hapus percakapan dengan {{ $conv->user->name }}?')">
            @csrf @method('DELETE')
            <button type="submit" class="text-red-400 hover:text-red-600 transition p-1">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                </svg>
            </button>
        </form>

    </div>
    @empty
    <div class="p-8 text-center text-gray-400">Belum ada pesan masuk.</div>
    @endforelse
</div>
@endsection

@push('scripts')
<script>
function filterUsers(query) {
    document.querySelectorAll('.user-item').forEach(item => {
        const name  = item.querySelector('.user-name').textContent.toLowerCase();
        const email = item.querySelector('.user-email').textContent.toLowerCase();
        item.closest('form').style.display = 
            name.includes(query.toLowerCase()) || email.includes(query.toLowerCase()) ? '' : 'none';
    });
}
</script>
@endpush