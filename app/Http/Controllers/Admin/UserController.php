<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;

class UserController extends Controller
{
    public function index()
    {
        $users = User::withCount('orders')->latest()->get();
        return view('admin.users.index', compact('users'));
    }

    public function show(User $user)
    {
        $user->load('orders');
        return view('admin.users.show', compact('user'));
    }
    public function destroy(User $user)
{
    // Cek apakah user punya pesanan aktif
    $activeOrders = $user->orders()
        ->whereNotIn('status', ['done', 'cancelled'])
        ->count();

    if ($activeOrders > 0) {
        return back()->with('error', 'User tidak bisa dihapus karena masih memiliki pesanan aktif.');
    }

    $user->delete();

    return back()->with('success', 'User berhasil dihapus.');
}
}