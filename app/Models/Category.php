<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        'name',
        'name_en',
        'slug',
        'image',
        'is_active',
    ];

    public function products()
    {
        return $this->hasMany(Product::class);
    }
    public function getLocalizedNameAttribute(): string
{
    return app()->getLocale() === 'en' && $this->name_en
        ? $this->name_en
        : $this->name;
}
}