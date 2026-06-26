<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class SettingsController extends Controller
{
    public function index()
{
    $admin = \App\Models\Admin::first();
    return view('admin.settings.index', compact('admin'));
}

public function updatePassword(Request $request)
{
    $request->validate([
        'current_password' => 'required',
        'password'         => 'required|min:8|confirmed',
    ], [
        'current_password.required' => 'Password saat ini wajib diisi.',
        'password.required'         => 'Password baru wajib diisi.',
        'password.min'              => 'Password baru minimal 8 karakter.',
        'password.confirmed'        => 'Konfirmasi password tidak cocok.',
    ]);

    $admin = Auth::guard('admin')->user();

    if (!Hash::check($request->current_password, $admin->password)) {
        return back()->withErrors(['current_password' => 'Password saat ini tidak sesuai.']);
    }

    $admin->update([
        'password' => Hash::make($request->password),
    ]);

    return back()->with('success', 'Password admin berhasil diperbarui.');
}
}