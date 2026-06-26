@extends('frontend.layouts.app')

@section('title', __('app.register') . ' — Basari')

@section('content')

<div class="min-h-[70vh] flex items-center justify-center">
    <div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-8 w-full max-w-md">

        <div class="text-center mb-8">
            <h1 class="text-2xl font-bold text-blue-900">Basari</h1>
            <p class="text-gray-500 text-sm mt-1">{{ __('app.register_subtitle') ?? 'Buat akun baru' }}</p>
        </div>

        @if($errors->any())
        <div class="bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg mb-6">
            {{ $errors->first() }}
        </div>
        @endif

        <form method="POST" action="{{ route('register') }}" class="space-y-4">
            @csrf

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.full_name') }}</label>
                <input type="text" name="name" value="{{ old('name') }}"
                       class="input-field" placeholder="{{ __('app.your_name') ?? 'Nama kamu' }}" required autofocus>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.email') }}</label>
                <input type="email" name="email" value="{{ old('email') }}"
                       class="input-field" placeholder="email@gmail.com" required>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <div class="relative">
                    <input type="password" name="password" id="passwordInput"
                        class="input-field w-full pr-10" placeholder="{{ __('app.min_chars') ?? 'Minimal 8 karakter' }}" required>
                    <button type="button" onclick="togglePassword('passwordInput', 'eyeIcon1', 'eyeOffIcon1')"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                        <svg id="eyeIcon1" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                        </svg>
                        <svg id="eyeOffIcon1" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.477 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 4.411m0 0L21 21"/>
                        </svg>
                    </button>
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.confirm_password') ?? 'Konfirmasi Password' }}</label>
                <div class="relative">
                    <input type="password" name="password_confirmation" id="passwordConfirmInput"
                        class="input-field w-full pr-10" placeholder="{{ __('app.repeat_password') ?? 'Ulangi password' }}" required>
                    <button type="button" onclick="togglePassword('passwordConfirmInput', 'eyeIcon2', 'eyeOffIcon2')"
                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                        <svg id="eyeIcon2" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                        </svg>
                        <svg id="eyeOffIcon2" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.477 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 4.411m0 0L21 21"/>
                        </svg>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn-primary w-full text-center mt-2">
                {{ __('app.create_account') ?? 'Buat Akun' }}
            </button>
        </form>

        <p class="text-center text-sm text-gray-500 mt-6">
            {{ __('app.have_account') ?? 'Sudah punya akun?' }}
            <a href="{{ route('login') }}" class="text-blue-900 font-medium hover:underline">{{ __('app.login_here') ?? 'Masuk di sini' }}</a>
        </p>

    </div>
</div>

<script>
function togglePassword(inputId, eyeId, eyeOffId) {
    const input = document.getElementById(inputId);
    const eyeIcon = document.getElementById(eyeId);
    const eyeOffIcon = document.getElementById(eyeOffId);
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