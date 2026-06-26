<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = [
    'user_id',
    'invoice_number',
    'status',
    'total_amount',
    'preferred_currency',
    'payment_ref',
    'shipping_name',
    'shipping_address',
    'shipping_city',
    'shipping_postal',
    'phone',
    'email',
    'notes',
    'paid_at',
    'courier',
    'courier_service',
    'shipping_cost',
    'tracking_number',
    'biteship_order_id',
    'biteship_tracking_id',
    'origin_postal_code',
    'destination_postal_code',
    'destination_district_id',
    'shipping_district',
    'shipping_type',
    'destination_country',
    'destination_country_code',
    'intl_shipping_cost',
    'intl_tracking_number',
    'intl_courier',
    'payment_deadline',
];

    protected $casts = [
        'paid_at' => 'datetime',
        'payment_deadline' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }
    public function reviews()
    {
    return $this->hasMany(Review::class);
    }
}