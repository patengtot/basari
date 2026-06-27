<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\URL;

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

        // Simpan data sementara di session, belum buat akun
        session([
            'pending_registration' => [
                'name'     => $request->name,
                'email'    => $request->email,
                'password' => Hash::make($request->password),
            ]
        ]);

        // Buat signed URL verifikasi
        $verificationUrl = URL::temporarySignedRoute(
            'register.verify',
            now()->addMinutes(60),
            ['email' => $request->email]
        );

        // Kirim email verifikasi
        Mail::to($request->email)
            ->send(new \App\Mail\VerifyRegistrationMail($request->name, $verificationUrl));

        return view('frontend.auth.register-pending', [
            'email' => $request->email,
        ]);
    }

    public function verify(Request $request)
    {
        // Validasi signed URL
        if (!$request->hasValidSignature()) {
            return redirect()->route('register')
                ->with('error', 'Link verifikasi tidak valid atau sudah kadaluarsa. Silakan daftar ulang.');
        }

        $pending = session('pending_registration');

        if (!$pending || $pending['email'] !== $request->email) {
            return redirect()->route('register')
                ->with('error', 'Data registrasi tidak ditemukan. Silakan daftar ulang.');
        }

        // Buat akun setelah verifikasi berhasil
        $user = User::create([
            'name'              => $pending['name'],
            'email'             => $pending['email'],
            'password'          => $pending['password'],
            'email_verified_at' => now(),
        ]);

        // Hapus session pending
        session()->forget('pending_registration');

        // Login otomatis
        Auth::login($user);

        return redirect()->route('home')
            ->with('success', 'Akun berhasil dibuat dan terverifikasi! Selamat berbelanja di Basari.');
    }
}