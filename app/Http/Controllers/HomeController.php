<?php

namespace App\Http\Controllers;

use App\Models\Banner;
use App\Models\Product;
use App\Models\Category;

class HomeController extends Controller
{
    public function index()
{
    $banners    = Banner::where('is_active', true)->orderBy('order_position')->get();
    $categories = Category::where('is_active', true)->get();
    $products   = Product::where('is_active', true)
                   ->where('stock', '>', 0)
                   ->latest()
                   ->take(8)
                   ->get();

    $newestProductIds = Product::where('is_active', true)
                    ->orderBy('created_at', 'desc')
                    ->limit(3)
                    ->pluck('id');

    return view('frontend.home', compact('banners', 'categories', 'products', 'newestProductIds'));
}
}