<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserRegisterController extends Controller
{
    public function showRegister()
    {
        return view('frontend.auth.register');
    }

    public function register(Request $request)
{
    $request->validate([
        'name'     => 'required|string|max:255',
        'email'    => 'required|email|unique:users,email',
        'password' => 'required|min:8|confirmed',
    ]);

    $user = User::create([
        'name'     => $request->name,
        'email'    => $request->email,
        'password' => Hash::make($request->password),
    ]);

    // Kirim email verifikasi
    $user->sendEmailVerificationNotification();

    // Login tapi arahkan ke halaman verifikasi
    Auth::login($user);

    return redirect()->route('verification.notice')
        ->with('success', 'Akun berhasil dibuat! Silakan verifikasi email kamu.');
}
}