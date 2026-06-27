@extends('frontend.layouts.app')

@section('title', 'Cek Email Kamu — Basari')

@section('content')
<div class="max-w-md mx-auto text-center py-16">
    <div class="bg-white rounded-2xl border border-gray-100 p-10">

        <div class="w-16 h-16 bg-blue-50 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-900" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
            </svg>
        </div>

        <h1 class="text-xl font-bold text-gray-800 mb-3">Cek Email Kamu</h1>
        <p class="text-sm text-gray-500 mb-2">Kami mengirim link verifikasi ke:</p>
        <p class="font-medium text-blue-900 mb-6">{{ $email }}</p>
        <p class="text-sm text-gray-400 mb-8">Klik link di email tersebut untuk mengaktifkan akun kamu. Link berlaku selama 60 menit.</p>

        <p class="text-xs text-gray-400">Tidak menerima email? Cek folder <strong>Spam</strong> atau
            <a href="{{ route('register') }}" class="text-blue-700 hover:underline">daftar ulang</a>.
        </p>
    </div>
</div>
@endsection