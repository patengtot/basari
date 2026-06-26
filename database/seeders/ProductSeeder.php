<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        $products = [
            [
                'category_id' => 1,
                'name'        => 'Outer Blazer Hitam',
                'slug'        => 'outer-blazer-hitam',
                'description' => 'Blazer hitam elegan cocok untuk berbagai acara formal maupun kasual.',
                'price'       => 185000,
                'stock'       => 20,
                'weight'      => 400,
                'images'      => null,
                'is_active'   => true,
            ],
            [
                'category_id' => 1,
                'name'        => 'Outer Cardigan Krem',
                'slug'        => 'outer-cardigan-krem',
                'description' => 'Cardigan krem lembut berbahan rajut premium.',
                'price'       => 135000,
                'stock'       => 15,
                'weight'      => 300,
                'images'      => null,
                'is_active'   => true,
            ],
            [
                'category_id' => 2,
                'name'        => 'Baju Kemeja Floral',
                'slug'        => 'baju-kemeja-floral',
                'description' => 'Kemeja motif floral cerah cocok untuk aktivitas harian.',
                'price'       => 95000,
                'stock'       => 30,
                'weight'      => 250,
                'images'      => null,
                'is_active'   => true,
            ],
            [
                'category_id' => 2,
                'name'        => 'Baju Kaos Basic Putih',
                'slug'        => 'baju-kaos-basic-putih',
                'description' => 'Kaos basic putih bahan cotton combed 30s nyaman dipakai seharian.',
                'price'       => 75000,
                'stock'       => 50,
                'weight'      => 200,
                'images'      => null,
                'is_active'   => true,
            ],
            [
                'category_id' => 3,
                'name'        => 'Celana Kulot Abu',
                'slug'        => 'celana-kulot-abu',
                'description' => 'Celana kulot abu-abu bahan crinkle airflow adem dan stylish.',
                'price'       => 110000,
                'stock'       => 25,
                'weight'      => 350,
                'images'      => null,
                'is_active'   => true,
            ],
            [
                'category_id' => 3,
                'name'        => 'Celana Jeans Skinny',
                'slug'        => 'celana-jeans-skinny',
                'description' => 'Celana jeans skinny stretch nyaman untuk aktivitas sehari-hari.',
                'price'       => 165000,
                'stock'       => 20,
                'weight'      => 500,
                'images'      => null,
                'is_active'   => true,
            ],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}