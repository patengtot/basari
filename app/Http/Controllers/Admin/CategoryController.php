<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::withCount('products')->latest()->get();
        return view('admin.categories.index', compact('categories'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'name'  => 'required|string|max:100|unique:categories,name',
            'image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('categories', 'public');
        }

        Category::create([
            'name'      => $request->name,
            'name_en'   => $request->name_en,
            'slug'      => Str::slug($request->name),
            'image'     => $imagePath,
            'is_active' => true,
        ]);

        return back()->with('success', 'Kategori berhasil ditambahkan.');
    }

    public function update(Request $request, Category $category)
    {
        $request->validate([
            'name'      => 'required|string|max:100',
            'name_en'   => 'nullable|string|max:100',
            'is_active' => 'boolean',
            'image'     => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $imagePath = $category->image;
        if ($request->hasFile('image')) {
            if ($imagePath) {
                Storage::disk('public')->delete($imagePath);
            }
            $imagePath = $request->file('image')->store('categories', 'public');
        }

        $category->update([
            'name'      => $request->name,
            'name_en'   => $request->name_en,
            'slug'      => Str::slug($request->name),
            'image'     => $imagePath,
            'is_active' => $request->boolean('is_active'),
        ]);

        return back()->with('success', 'Kategori berhasil diperbarui.');
    }

    public function destroy(Category $category)
{
    // Cek apakah ada produk di kategori ini yang pernah diorder
    $hasOrders = $category->products()
                          ->whereHas('orderItems')
                          ->exists();

    if ($hasOrders) {
        return back()->with('error', 'Kategori tidak bisa dihapus karena ada produk yang pernah diorder.');
    }

    // Hapus gambar kategori
    if ($category->image) {
        Storage::disk('public')->delete($category->image);
    }

    // Hapus semua produk di kategori ini beserta gambarnya
    foreach ($category->products as $product) {
        if ($product->images) {
            foreach ($product->images as $image) {
                Storage::disk('public')->delete($image);
            }
        }
        $product->delete();
    }

    $category->delete();
    return back()->with('success', 'Kategori berhasil dihapus.');
}
}