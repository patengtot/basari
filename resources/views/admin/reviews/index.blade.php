@extends('admin.layouts.app')

@section('title', 'Review Produk — Basari Admin')
@section('header', 'Review Produk')

@section('content')

{{-- Tab Filter Bintang --}}
<div class="flex gap-2 flex-wrap mb-5">
    <a href="{{ route('admin.reviews.index') }}"
       class="flex items-center gap-1.5 px-4 py-2 text-xs font-medium rounded-lg border transition
              {{ !$rating ? 'bg-blue-900 text-white border-blue-900' : 'bg-white text-gray-600 border-gray-200 hover:border-blue-700 hover:text-blue-700' }}">
        Semua
        <span class="px-1.5 py-0.5 rounded-full text-xs
                     {{ !$rating ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-500' }}">
            {{ $counts->sum() }}
        </span>
    </a>
    @foreach([5, 4, 3, 2, 1] as $star)
    <a href="{{ route('admin.reviews.index', ['rating' => $star]) }}"
       class="flex items-center gap-1.5 px-4 py-2 text-xs font-medium rounded-lg border transition
              {{ $rating == $star ? 'bg-blue-900 text-white border-blue-900' : 'bg-white text-gray-600 border-gray-200 hover:border-blue-700 hover:text-blue-700' }}">
        <svg class="w-3.5 h-3.5 {{ $rating == $star ? 'text-yellow-300' : 'text-yellow-400' }}" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
        </svg>
        {{ $star }} Bintang
        <span class="px-1.5 py-0.5 rounded-full text-xs
                     {{ $rating == $star ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-500' }}">
            {{ $counts->get($star, 0) }}
        </span>
    </a>
    @endforeach
</div>
<div class="space-y-4">
    @forelse($reviews as $review)
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <div class="flex items-start justify-between gap-4">
            <div class="flex-1">
                {{-- Header --}}
                <div class="flex items-center gap-3 mb-2">
                    <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-900 font-bold text-xs flex-shrink-0">
                        {{ strtoupper(substr($review->user->name, 0, 1)) }}
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-800">{{ $review->user->name }}</p>
                        <p class="text-xs text-gray-400">{{ $review->created_at->format('d M Y, H:i') }}</p>
                    </div>
                    <div class="flex gap-0.5 ml-2">
                        @for($i = 1; $i <= 5; $i++)
                        <svg class="w-4 h-4 {{ $i <= $review->rating ? 'text-yellow-400' : 'text-gray-200' }}" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                        </svg>
                        @endfor
                        <span class="text-xs text-gray-400 ml-1">({{ $review->rating }}/5)</span>
                    </div>
                </div>

                {{-- Produk --}}
                <p class="text-xs text-gray-400 mb-2">
                    Produk: <span class="font-medium text-gray-600">{{ $review->product->name }}</span>
                    · Pesanan: <span class="font-medium text-gray-600">{{ $review->order->invoice_number }}</span>
                </p>

                {{-- Komentar --}}
                <p class="text-sm text-gray-700 mb-3">{{ $review->comment ?? 'Tidak ada komentar.' }}</p>

                {{-- Balasan admin --}}
                @if($review->admin_reply)
                <div class="bg-blue-50 border border-blue-100 rounded-lg p-3 mb-3">
                    <p class="text-xs font-semibold text-blue-900 mb-1">Balasan Penjual:</p>
                    <p class="text-sm text-blue-800">{{ $review->admin_reply }}</p>
                    <p class="text-xs text-blue-400 mt-1">{{ $review->admin_replied_at->diffForHumans() }}</p>
                </div>
                @endif

                {{-- Form balas --}}
                <form method="POST" action="{{ route('admin.reviews.reply', $review) }}" class="flex gap-2">
                    @csrf
                    <input type="text" name="admin_reply"
                           value="{{ $review->admin_reply }}"
                           placeholder="{{ $review->admin_reply ? 'Update balasan...' : 'Tulis balasan...' }}"
                           class="input-field text-sm flex-1">
                    <button type="submit" class="btn-primary text-sm px-4 py-2 whitespace-nowrap">
                        {{ $review->admin_reply ? 'Update' : 'Balas' }}
                    </button>
                </form>
            </div>

            {{-- Hapus --}}
            <form method="POST" action="{{ route('admin.reviews.destroy', $review) }}"
                  onsubmit="return confirm('Hapus review ini?')">
                @csrf @method('DELETE')
                <button type="submit" class="text-red-400 hover:text-red-600 transition p-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                    </svg>
                </button>
            </form>
        </div>
    </div>
    @empty
    <div class="bg-white rounded-xl border border-gray-100 p-8 text-center text-gray-400">
        Belum ada review dari pelanggan.
    </div>
    @endforelse

    <div class="mt-4">
        {{ $reviews->links() }}
    </div>
</div>

@endsection