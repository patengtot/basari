<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ProductController extends Controller
{
   public function index(Request $request)
{
    $categories = Category::where('is_active', true)->get();

    $allProducts = Product::with('category')->withCount('orderItems')->get();

    $products = $allProducts->when($request->category, fn($q) => $q->where('category_id', $request->category));

    return view('admin.products.index', compact('products', 'categories', 'allProducts'));
}

    public function create()
    {
        $categories = Category::where('is_active', true)->get();
        return view('admin.products.create', compact('categories'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'name'                  => 'required|string|max:255',
            'name_en'               => 'nullable|string|max:255',
            'category_id'           => 'required|exists:categories,id',
            'description'           => 'nullable|string',
            'description_en'        => 'nullable|string',
            'price'                 => 'required|numeric|min:0',
            'stock'                 => 'required|integer|min:0',
            'weight'                => 'required|integer|min:0',
            'length'                => 'nullable|integer|min:0',
            'width'                 => 'nullable|integer|min:0',
            'height'                => 'nullable|integer|min:0',
            'images'                => 'nullable|array',
            'images.*'              => 'image|mimes:jpg,jpeg,png,webp|max:2048',
            'video'                 => 'nullable|file|mimes:mp4,webm|max:51200',
            'is_active'             => 'boolean',
            'sizes'                 => 'nullable|array',
            'sizes.*.size'          => 'required_with:sizes|string|max:10',
            'sizes.*.stock'         => 'required_with:sizes|integer|min:0',
            'colors'                => 'nullable|array',
            'colors.*.name'         => 'required_with:colors|string|max:50',
            'colors.*.hex_code'     => 'nullable|string|max:7',
            'colors.*.image_index'  => 'nullable|integer|min:0',
            'colors.*.stock'        => 'nullable|integer|min:0',
            'thumbnail_index'       => 'nullable|integer|min:0',
        ]);

        $imagePaths = [];
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $image) {
                $imagePaths[] = $image->store('products', 'public');
            }
        }

        $videoPath = null;
        if ($request->hasFile('video')) {
            $videoPath = $request->file('video')->store('products/videos', 'public');
        }

        $product = Product::create([
            'name'            => $request->name,
            'slug'            => Str::slug($request->name) . '-' . Str::random(4),
            'category_id'     => $request->category_id,
            'description'     => $request->description,
            'price'           => $request->price,
            'stock'           => $request->stock,
            'weight'          => $request->weight,
            'length'          => (int) ($request->length ?? 30),
            'width'           => (int) ($request->width ?? 25),
            'height'          => (int) ($request->height ?? 5),
            'images'          => $imagePaths,
            'video'           => $videoPath,
            'thumbnail_index' => (int) ($request->thumbnail_index ?? 0),
            'is_active'       => $request->boolean('is_active', true),
        ]);

        if ($request->sizes) {
            foreach ($request->sizes as $size) {
                if (!empty($size['size'])) {
                    $product->sizes()->create([
                        'size'  => strtoupper($size['size']),
                        'stock' => $size['stock'] ?? 0,
                    ]);
                }
            }
        }

        if ($request->colors) {
            foreach ($request->colors as $i => $color) {
                if (!empty($color['name'])) {
                    $product->colors()->create([
                        'name'        => $color['name'],
                        'hex_code'    => $color['hex_code'] ?? null,
                        'image_index' => (int) ($color['image_index'] ?? 0),
                        'stock'       => (int) ($color['stock'] ?? 0),
                        'sort_order'  => $i,
                    ]);
                }
            }
        }

        return redirect()->route('admin.products.index')->with('success', 'Produk berhasil ditambahkan.');
    }

    public function edit(Product $product)
    {
        $product->load('sizes', 'colors');
        $categories = Category::where('is_active', true)->get();
        return view('admin.products.edit', compact('product', 'categories'));
    }

    public function update(Request $request, Product $product)
    {
        $request->validate([
            'name'                  => 'required|string|max:255',
            'name_en'               => 'nullable|string|max:255',
            'category_id'           => 'required|exists:categories,id',
            'description'           => 'nullable|string',
            'description_en'        => 'nullable|string',
            'price'                 => 'required|numeric|min:0',
            'stock'                 => 'required|integer|min:0',
            'weight'                => 'required|integer|min:0',
            'length'                => 'nullable|integer|min:0',
            'width'                 => 'nullable|integer|min:0',
            'height'                => 'nullable|integer|min:0',
            'images'                => 'nullable|array',
            'images.*'              => 'image|mimes:jpg,jpeg,png,webp|max:2048',
            'video'                 => 'nullable|file|mimes:mp4,webm|max:51200',
            'sizes'                 => 'nullable|array',
            'sizes.*.size'          => 'required_with:sizes|string|max:10',
            'sizes.*.stock'         => 'required_with:sizes|integer|min:0',
            'colors'                => 'nullable|array',
            'colors.*.name'         => 'required_with:colors|string|max:50',
            'colors.*.hex_code'     => 'nullable|string|max:7',
            'colors.*.image_index'  => 'nullable|integer|min:0',
            'colors.*.stock'        => 'nullable|integer|min:0',
            'thumbnail_index'       => 'nullable|integer|min:0',
        ]);

        $existingImages = $request->existing_images ?? [];

        if ($product->images) {
            foreach ($product->images as $oldImage) {
                if (!in_array($oldImage, $existingImages)) {
                    Storage::disk('public')->delete($oldImage);
                }
            }
        }

        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $image) {
                $existingImages[] = $image->store('products', 'public');
            }
        }

        // Handle video
        $videoPath = $product->video;
        if ($request->hasFile('video')) {
            // Hapus video lama
            if ($videoPath) {
                Storage::disk('public')->delete($videoPath);
            }
            $videoPath = $request->file('video')->store('products/videos', 'public');
        } elseif ($request->remove_video) {
            if ($videoPath) {
                Storage::disk('public')->delete($videoPath);
            }
            $videoPath = null;
        }

        $product->update([
            'name'            => $request->name,
            'name_en'         => $request->name_en,
            'slug'            => $product->name !== $request->name
                                 ? Str::slug($request->name) . '-' . Str::random(4)
                                 : $product->slug,
            'category_id'     => $request->category_id,
            'description'     => $request->description,
            'description_en'  => $request->description_en,
            'price'           => $request->price,
            'stock'           => $request->stock,
            'weight'          => $request->weight,
            'images'          => $existingImages,
            'video'           => $videoPath,
            'thumbnail_index' => (int) ($request->thumbnail_index ?? 0),
            'is_active'       => $request->boolean('is_active'),
        ]);

        $product->sizes()->delete();
        if ($request->sizes) {
            foreach ($request->sizes as $size) {
                if (!empty($size['size'])) {
                    $product->sizes()->create([
                        'size'  => strtoupper($size['size']),
                        'stock' => $size['stock'] ?? 0,
                    ]);
                }
            }
        }

        $product->colors()->delete();
        if ($request->colors) {
            foreach ($request->colors as $i => $color) {
                if (!empty($color['name'])) {
                    $product->colors()->create([
                        'name'        => $color['name'],
                        'hex_code'    => $color['hex_code'] ?? null,
                        'image_index' => (int) ($color['image_index'] ?? 0),
                        'stock'       => (int) ($color['stock'] ?? 0),
                        'sort_order'  => $i,
                    ]);
                }
            }
        }

        return redirect()->route('admin.products.index')->with('success', 'Produk berhasil diperbarui.');
    }

    public function destroy(Product $product)
    {
        if ($product->order_items_count > 0) {
            $product->update(['is_active' => false]);
            return back()->with('success', 'Produk dinonaktifkan karena pernah diorder.');
        }

        if ($product->images) {
            foreach ($product->images as $image) {
                Storage::disk('public')->delete($image);
            }
        }

        if ($product->video) {
            Storage::disk('public')->delete($product->video);
        }

        $product->delete();
        return back()->with('success', 'Produk berhasil dihapus.');
    }
}