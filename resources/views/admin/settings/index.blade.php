@extends('admin.layouts.app')

@section('title', 'Pengaturan — Basari Admin')
@section('header', 'Pengaturan')

@section('content')

<div class="max-w-lg space-y-6">

    {{-- Info Admin --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-4">Informasi Akun</h2>
        <div class="space-y-2 text-sm">
            <div class="flex justify-between">
                <span class="text-gray-400">Nama</span>
                <span class="text-gray-800 font-medium">{{ $admin->name }}</span>
            </div>
            <div class="flex justify-between">
                <span class="text-gray-400">Email</span>
                <span class="text-gray-800 font-medium">{{ $admin->email }}</span>
            </div>
        </div>
    </div>

    {{-- Ganti Password --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-4">Ganti Password</h2>

        @if(session('success'))
        <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg text-sm mb-4">
            {{ session('success') }}
        </div>
        @endif

        @if($errors->any())
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm mb-4">
            @foreach($errors->all() as $error)
            <p>{{ $error }}</p>
            @endforeach
        </div>
        @endif

        <form method="POST" action="{{ route('admin.settings.password') }}" class="space-y-4">
            @csrf

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password Saat Ini</label>
                <input type="password" name="current_password"
                    class="input-field" placeholder="Masukkan password saat ini" required>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password Baru</label>
                <input type="password" name="password"
                    class="input-field" placeholder="Minimal 8 karakter" required>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Konfirmasi Password Baru</label>
                <input type="password" name="password_confirmation"
                    class="input-field" placeholder="Ulangi password baru" required>
            </div>

            <button type="submit" class="btn-primary">Perbarui Password</button>
        </form>
    </div>

</div>

@endsection