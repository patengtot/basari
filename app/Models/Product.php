<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
    'category_id',
    'name',
    'slug',
    'description',
    'price',
    'price_usd',
    'price_myr',
    'stock',
    'weight',
    'length',
    'width',
    'height',
    'images',
    'video',
    'thumbnail_index',
    'is_active',
    'name_en',
    'description_en',
];

    protected $casts = [
        'images' => 'array',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function cartItems()
    {
        return $this->hasMany(CartItem::class);
    }

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }
    public function sizes()
    {
        return $this->hasMany(ProductSize::class);
    }
    public function views()
    {
    return $this->hasMany(\App\Models\ProductView::class);
    }
    public function reviews()
    {
        return $this->hasMany(Review::class);
    }

    public function averageRating()
    {
        return $this->reviews()->avg('rating');
    }
     public function colors()
    {
        return $this->hasMany(ProductColor::class)->orderBy('sort_order');
    }
    public function getLocalizedNameAttribute(): string
{
    return app()->getLocale() === 'en' && $this->name_en
        ? $this->name_en
        : $this->name;
}

public function getLocalizedDescriptionAttribute(): ?string
{
    return app()->getLocale() === 'en' && $this->description_en
        ? $this->description_en
        : $this->description;
}
}