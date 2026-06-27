@extends('admin.layouts.app')

@section('title', 'Pembeli — Basari Admin')
@section('header', 'Kelola Pembeli')

@section('content')

{{-- Desktop Table --}}
<div class="hidden md:block bg-white rounded-xl border border-gray-100 overflow-hidden">
    <table class="w-full text-sm">
        <thead>
            <tr class="text-left text-gray-400 border-b border-gray-100 bg-gray-50">
                <th class="px-4 py-3 font-medium">Nama</th>
                <th class="px-4 py-3 font-medium">Email</th>
                <th class="px-4 py-3 font-medium">No. HP</th>
                <th class="px-4 py-3 font-medium">Total Pesanan</th>
                <th class="px-4 py-3 font-medium">Bergabung</th>
                <th class="px-4 py-3 font-medium">Aksi</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-gray-50">
            @forelse($users as $user)
            <tr>
                <td class="px-4 py-3 font-medium text-gray-800">{{ $user->name }}</td>
                <td class="px-4 py-3 text-gray-500">{{ $user->email }}</td>
                <td class="px-4 py-3 text-gray-500">{{ $user->phone ?? '-' }}</td>
                <td class="px-4 py-3">
                    <span class="bg-blue-50 text-blue-900 text-xs font-semibold px-2 py-1 rounded-full">
                        {{ $user->orders_count }} pesanan
                    </span>
                </td>
                <td class="px-4 py-3 text-gray-400">{{ $user->created_at->format('d M Y') }}</td>
                <td class="px-4 py-3 flex items-center gap-3">
                    <a href="{{ route('admin.users.show', $user) }}" class="text-blue-500 hover:underline text-xs">Detail</a>
                    <form method="POST" action="{{ route('admin.users.destroy', $user) }}"
                        onsubmit="return confirm('Hapus user {{ $user->name }}?')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-red-500 hover:underline text-xs">Hapus</button>
                    </form>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="6" class="px-4 py-8 text-center text-gray-400">Belum ada pembeli terdaftar.</td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

{{-- Mobile Cards --}}
<div class="md:hidden space-y-3">
    @forelse($users as $user)
    <div class="bg-white rounded-xl border border-gray-100 p-4">
        <div class="flex items-start justify-between mb-2">
            <div>
                <p class="font-medium text-gray-800">{{ $user->name }}</p>
                <p class="text-xs text-gray-400 mt-0.5">{{ $user->email }}</p>
                <p class="text-xs text-gray-400">{{ $user->phone ?? '-' }}</p>
            </div>
            <span class="bg-blue-50 text-blue-900 text-xs font-semibold px-2 py-1 rounded-full flex-shrink-0">
                {{ $user->orders_count }} pesanan
            </span>
        </div>
        <p class="text-xs text-gray-400 mb-3">Bergabung: {{ $user->created_at->format('d M Y') }}</p>
        <div class="flex gap-2 pt-3 border-t border-gray-50">
            <a href="{{ route('admin.users.show', $user) }}"
               class="flex-1 text-center py-2 text-xs text-blue-700 border border-blue-200 rounded-lg hover:bg-blue-50 transition">
                Detail
            </a>
            <form method="POST" action="{{ route('admin.users.destroy', $user) }}"
                  onsubmit="return confirm('Hapus user {{ $user->name }}?')" class="flex-1">
                @csrf @method('DELETE')
                <button type="submit" class="w-full py-2 text-xs text-red-600 border border-red-200 rounded-lg hover:bg-red-50 transition">
                    Hapus
                </button>
            </form>
        </div>
    </div>
    @empty
    <div class="bg-white rounded-xl border border-gray-100 p-8 text-center text-gray-400">
        Belum ada pembeli terdaftar.
    </div>
    @endforelse
</div>

@endsection