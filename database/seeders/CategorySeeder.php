<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            ['name' => 'Outer',  'slug' => 'outer',  'is_active' => true],
            ['name' => 'Baju',   'slug' => 'baju',   'is_active' => true],
            ['name' => 'Celana', 'slug' => 'celana', 'is_active' => true],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }
    }
}