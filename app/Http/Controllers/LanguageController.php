<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class LanguageController extends Controller
{
    public function switch($lang)
{
    session(['locale' => $lang]);

    // Simpan ke database kalau user sudah login
    if (auth()->check()) {
        auth()->user()->update(['locale' => $lang]);
    }

    return back();
}
}