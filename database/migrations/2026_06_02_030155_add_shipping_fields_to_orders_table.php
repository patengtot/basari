<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
{
    Schema::table('orders', function (Blueprint $table) {
        $table->string('courier')->nullable()->after('notes');
        $table->string('courier_service')->nullable()->after('courier');
        $table->integer('shipping_cost')->default(0)->after('courier_service');
        $table->string('tracking_number')->nullable()->after('shipping_cost');
        $table->string('origin_city_id')->nullable()->after('tracking_number');
        $table->string('destination_city_id')->nullable()->after('origin_city_id');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            //
        });
    }
};
