@extends('frontend.layouts.app')

@section('title', __('app.login') . ' — Basari')

@section('content')

<div class="min-h-[70vh] flex items-center justify-center">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-8 w-full max-w-md">

        <div class="text-center mb-8">
            <h1 class="text-2xl font-bold text-blue-900">Basari</h1>
            <p class="text-gray-500 text-sm mt-1">{{ __('app.login_subtitle') ?? 'Masuk ke akun kamu' }}</p>
        </div>

        @if($errors->any())
        <div class="bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg mb-6">
            {{ $errors->first() }}
        </div>
        @endif

        <form method="POST" action="{{ route('login') }}" class="space-y-4">
            @csrf

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.email') }}</label>
                <input type="email" name="email" value="{{ old('email') }}"
                       class="input-field" placeholder="email@gmail.com" required autofocus>
            </div>

            <div>
                <div class="flex items-center justify-between mb-1">
                    <label class="block text-sm font-medium text-gray-700">Password</label>
                    <a href="{{ route('password.request') }}" class="text-xs text-blue-700 hover:underline">
                        Lupa password?
                    </a>
                </div>
                <div class="relative">
                    <input type="password" name="password" id="passwordInput"
                        class="input-field w-full pr-10" placeholder="••••••••" required>
                    <button type="button" onclick="togglePassword()"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                        <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                        </svg>
                        <svg id="eyeOffIcon" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.477 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 4.411m0 0L21 21"/>
                        </svg>
                    </button>
                </div>
            </div>

            <div class="flex items-center justify-between text-sm">
                <label class="flex items-center gap-2 text-gray-600 cursor-pointer">
                    <input type="checkbox" name="remember" class="rounded border-gray-300 text-blue-900">
                    {{ __('app.remember_me') ?? 'Ingat saya' }}
                </label>
            </div>

            <button type="submit" class="btn-primary w-full text-center mt-2">
                {{ __('app.login') }}
            </button>
        </form>

        <p class="text-center text-sm text-gray-500 mt-6">
            {{ __('app.no_account') ?? 'Belum punya akun?' }}
            <a href="{{ route('register') }}" class="text-blue-900 font-medium hover:underline">{{ __('app.register_now') ?? 'Daftar sekarang' }}</a>
        </p>

    </div>
</div>

<script>
function togglePassword() {
    const input = document.getElementById('passwordInput');
    const eyeIcon = document.getElementById('eyeIcon');
    const eyeOffIcon = document.getElementById('eyeOffIcon');
    if (input.type === 'password') {
        input.type = 'text';
        eyeIcon.classList.add('hidden');
        eyeOffIcon.classList.remove('hidden');
    } else {
        input.type = 'password';
        eyeIcon.classList.remove('hidden');
        eyeOffIcon.classList.add('hidden');
    }
}
</script>
@endsection