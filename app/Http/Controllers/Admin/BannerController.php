<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BannerController extends Controller
{
    public function index()
    {
        $banners   = Banner::orderBy('order_position')->get();
        $heroVideo = Setting::get('hero_video');
        return view('admin.banners.index', compact('banners', 'heroVideo'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'title'          => 'required|string|max:255',
            'image'          => 'required|image|mimes:jpg,jpeg,png,webp|max:3048',
            'link_url'       => 'nullable|url',
            'order_position' => 'integer|min:0',
        ]);

        $path = $request->file('image')->store('banners', 'public');

        Banner::create([
            'title'          => $request->title,
            'image'          => $path,
            'link_url'       => $request->link_url,
            'is_active'      => true,
            'order_position' => $request->order_position ?? 0,
        ]);

        return back()->with('success', 'Banner berhasil ditambahkan.');
    }

    public function update(Request $request, Banner $banner)
{
    $request->validate([
        'title'          => 'required|string|max:255',
        'image'          => 'nullable|image|mimes:jpg,jpeg,png,webp|max:3048',
        'link_url'       => 'nullable|url',
        'order_position' => 'integer|min:0',
    ]);

    if ($request->hasFile('image')) {
        Storage::disk('public')->delete($banner->image);
        $path = $request->file('image')->store('banners', 'public');
        $banner->image = $path;
    }

    $banner->update([
        'title'          => $request->title,
        'image'          => $banner->image,
        'link_url'       => $request->link_url,
        'order_position' => $request->order_position ?? 0,
    ]);

    return back()->with('success', 'Banner berhasil diperbarui.');
}

    public function destroy(Banner $banner)
    {
        Storage::disk('public')->delete($banner->image);
        $banner->delete();
        return back()->with('success', 'Banner berhasil dihapus.');
    }

    public function updateHeroVideo(Request $request)
    {
        $request->validate([
            'hero_video' => 'nullable|file|mimes:mp4,webm|max:51200',
        ]);

        if ($request->hasFile('hero_video')) {
            $oldVideo = Setting::get('hero_video');
            if ($oldVideo) {
                Storage::disk('public')->delete($oldVideo);
            }

            $path = $request->file('hero_video')->store('videos', 'public');
            Setting::set('hero_video', $path);
        } elseif ($request->remove_video) {
            $oldVideo = Setting::get('hero_video');
            if ($oldVideo) {
                Storage::disk('public')->delete($oldVideo);
            }
            Setting::set('hero_video', null);
        }

        return back()->with('success', 'Hero video berhasil diperbarui.');
    }
}