<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function all(Request $request)
{
    $query = Product::with('category')->where('is_active', true);

    if ($request->min_price) {
        $query->where('price', '>=', $request->min_price);
    }
    if ($request->max_price) {
        $query->where('price', '<=', $request->max_price);
    }
    if ($request->category) {
        $query->where('category_id', $request->category);
    }

    switch ($request->sort) {
        case 'price_asc':  $query->orderBy('price', 'asc');  break;
        case 'price_desc': $query->orderBy('price', 'desc'); break;
        case 'oldest':     $query->oldest();                  break;
        default:           $query->latest();                  break;
    }

    $products         = $query->get();
    $categories       = Category::where('is_active', true)->get();
    $newestProductIds = Product::where('is_active', true)
                            ->orderBy('created_at', 'desc')
                            ->limit(3)
                            ->pluck('id');

    return view('frontend.products.all', compact('products', 'categories', 'newestProductIds'));
}

    public function category(Request $request, $slug)
{
    $category   = Category::where('slug', $slug)->firstOrFail();
    $categories = Category::where('is_active', true)->get();

    $query = Product::where('category_id', $category->id)->where('is_active', true);

    if ($request->min_price) {
        $query->where('price', '>=', $request->min_price);
    }
    if ($request->max_price) {
        $query->where('price', '<=', $request->max_price);
    }

    switch ($request->sort) {
        case 'price_asc':  $query->orderBy('price', 'asc');  break;
        case 'price_desc': $query->orderBy('price', 'desc'); break;
        case 'oldest':     $query->oldest();                  break;
        default:           $query->latest();                  break;
    }

    $products         = $query->get();
    $newestProductIds = Product::where('is_active', true)
                            ->orderBy('created_at', 'desc')
                            ->limit(3)
                            ->pluck('id');

    return view('frontend.products.category', compact('category', 'categories', 'products', 'newestProductIds'));
}
public function show($slug)
{
    $product = Product::with(['category', 'sizes', 'colors'])
                      ->where('slug', $slug)
                      ->where('is_active', true)
                      ->firstOrFail();

    \App\Models\ProductView::create([
        'product_id' => $product->id,
        'ip_address' => request()->ip(),
        'user_id'    => auth()->id(),
    ]);

    $related = Product::with('category')
                      ->where('category_id', $product->category_id)
                      ->where('id', '!=', $product->id)
                      ->where('is_active', true)
                      ->take(4)
                      ->get();

    return view('frontend.products.show', compact('product', 'related'));
}
    public function search(Request $request)
    {
        $query    = $request->get('q');
        $products = Product::with('category')
                           ->where('is_active', true)
                           ->where(function($q) use ($query) {
                               $q->where('name', 'ilike', '%' . $query . '%')
                                 ->orWhere('description', 'ilike', '%' . $query . '%');
                           })
                           ->get();

        return view('frontend.products.search', compact('products', 'query'));
    }
}