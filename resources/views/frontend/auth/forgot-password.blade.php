@extends('frontend.layouts.app')

@section('title', __('app.forgot_password') . ' — Basari')

@section('content')
<div class="max-w-md mx-auto py-12">
    <div class="bg-white rounded-2xl border border-gray-100 p-8">

        @if(session('success'))
        {{-- Tampilan setelah email terkirim --}}
        <div class="text-center">
            <div class="w-16 h-16 bg-blue-50 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-900" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                </svg>
            </div>

            <h1 class="text-xl font-bold text-gray-800 mb-2">{{ __('app.check_email') }}</h1>
            <p class="text-sm text-gray-500 mb-2">{{ __('app.check_email_desc') }}</p>
            <p class="font-medium text-blue-900 mb-4">{{ session('email') }}</p>
            <p class="text-sm text-gray-400 mb-8">{{ __('app.check_email_hint') }}</p>

            {{-- Kirim ulang --}}
            <form method="POST" action="{{ route('password.email') }}">
                @csrf
                <input type="hidden" name="email" value="{{ session('email') }}">
                <button type="submit" class="w-full py-2.5 text-sm border border-blue-700 text-blue-700 rounded-lg hover:bg-blue-50 transition mb-4">
                    {{ __('app.resend_reset_link') }}
                </button>
            </form>

            <a href="{{ route('login') }}" class="text-sm text-gray-400 hover:text-gray-600 transition">
                {{ __('app.back_to_login') }}
            </a>
        </div>

        @else
        {{-- Form input email --}}
        <div class="text-center mb-8">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">{{ __('app.forgot_password') }}</h1>
            <p class="text-sm text-gray-400">{{ __('app.forgot_password_subtitle') }}</p>
        </div>

        @if($errors->any())
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm mb-6">
            {{ $errors->first() }}
        </div>
        @endif

        <form method="POST" action="{{ route('password.email') }}" class="space-y-4">
            @csrf
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.email') }}</label>
                <input type="email" name="email" value="{{ old('email') }}"
                       class="input-field" placeholder="email@gmail.com" required autofocus>
            </div>
            <button type="submit" class="btn-primary w-full">
                {{ __('app.send_reset_link') }}
            </button>
        </form>

        <div class="text-center mt-6">
            <a href="{{ route('login') }}" class="text-sm text-gray-400 hover:text-gray-600 transition">
                {{ __('app.back_to_login') }}
            </a>
        </div>
        @endif

    </div>
</div>
@endsection