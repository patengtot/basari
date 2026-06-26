<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->integer('intl_shipping_cost')->default(0)->after('shipping_cost');
            $table->string('intl_tracking_number')->nullable()->after('intl_shipping_cost');
            $table->string('intl_courier')->nullable()->after('intl_tracking_number');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['intl_shipping_cost', 'intl_tracking_number', 'intl_courier']);
        });
    }
};