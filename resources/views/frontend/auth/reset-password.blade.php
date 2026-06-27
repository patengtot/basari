@extends('frontend.layouts.app')

@section('title', 'Reset Password — Basari')

@section('content')
<div class="max-w-md mx-auto py-12">
    <div class="bg-white rounded-2xl border border-gray-100 p-8">

        <div class="text-center mb-8">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">{{ __('app.reset_password') }}</h1>
            <p class="text-sm text-gray-400">{{ __('app.reset_password_subtitle') }}</p>
        </div>

        @if($errors->any())
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm mb-6">
            {{ $errors->first() }}
        </div>
        @endif

        <form method="POST" action="{{ route('password.update') }}" class="space-y-4">
            @csrf
            <input type="hidden" name="token" value="{{ $token }}">

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input type="email" name="email" value="{{ $email ?? old('email') }}"
                       class="input-field bg-gray-50" readonly>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.new_password') }}</label>
                    <input type="password" name="password" class="input-field" placeholder="{{ __('app.min_8_chars') }}" required>
                @error('password')
                <p class="text-red-500 text-xs mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.confirm_new_password') }}</label>
                    <input type="password" name="password_confirmation" class="input-field" placeholder="{{ __('app.repeat_new_password') }}" required>
            </div>

            <button type="submit" class="btn-primary w-full">
                {{ __('app.reset_password_btn') }}
            </button>
        </form>

    </div>
</div>
@endsection