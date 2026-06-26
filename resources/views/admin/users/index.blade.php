@extends('admin.layouts.app')

@section('title', 'Pembeli — Basari Admin')
@section('header', 'Kelola Pembeli')

@section('content')

<div class="bg-white rounded-xl border border-gray-100 overflow-hidden">
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
                        onsubmit="return confirm('Hapus user {{ $user->name }}? Tindakan ini tidak bisa dibatalkan.')">
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

@endsection
