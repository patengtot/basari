@extends('frontend.layouts.app')

@section('title', 'Verifikasi Email — Basari')

@section('content')

<div class="max-w-md mx-auto py-20 text-center">

    <div class="w-16 h-16 bg-blue-50 rounded-full flex items-center justify-center mx-auto mb-6">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-900" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
        </svg>
    </div>

    <h1 class="font-serif text-2xl font-light text-gray-900 mb-3">Verifikasi Email Kamu</h1>
    <p class="text-sm text-gray-400 leading-relaxed mb-8">
        Kami sudah mengirim link verifikasi ke <strong class="text-gray-700">{{ auth()->user()->email }}</strong>.
        Silakan cek inbox atau folder spam kamu.
    </p>

    @if(session('success'))
    <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg text-sm mb-6">
        {{ session('success') }}
    </div>
    @endif

    <form method="POST" action="{{ route('verification.send') }}">
        @csrf
        <button type="submit"
            class="w-full py-3 text-sm bg-blue-900 text-white rounded-lg hover:bg-blue-800 transition mb-4">
            Kirim Ulang Link Verifikasi
        </button>
    </form>

    <form method="POST" action="{{ route('logout') }}">
        @csrf
        <button type="submit" class="text-xs text-gray-400 hover:text-gray-600 transition">
            Logout
        </button>
    </form>

</div>

@endsection