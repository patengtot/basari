<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderItem extends Model
{
    protected $fillable = [
    'order_id',
    'product_id',
    'product_name',
    'product_price',
    'size',
    'color',
    'quantity',
    'subtotal',
    'biteship_tracking_id',
];

    public function order()
    {
        return $this->belongsTo(Order::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    public function review()
    {
    return $this->hasOne(Review::class);
    }
}