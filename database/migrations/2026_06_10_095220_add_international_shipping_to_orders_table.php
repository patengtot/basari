<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->string('shipping_type')->default('domestic')->after('shipping_cost');
            $table->string('destination_country')->nullable()->after('shipping_type');
            $table->string('destination_country_code', 5)->nullable()->after('destination_country');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['shipping_type', 'destination_country', 'destination_country_code']);
        });
    }
};