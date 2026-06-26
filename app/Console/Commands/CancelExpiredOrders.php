<?php

namespace App\Console\Commands;

use App\Helpers\NotificationHelper;
use App\Models\Order;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CancelExpiredOrders extends Command
{
    protected $signature   = 'orders:cancel-expired';
    protected $description = 'Cancel pesanan yang sudah melewati batas waktu pembayaran';

    public function handle()
    {
        $expired = Order::whereIn('status', ['pending', 'waiting_shipping_cost'])
            ->whereNotNull('payment_deadline')
            ->where('payment_deadline', '<', Carbon::now())
            ->get();

        foreach ($expired as $order) {
            DB::transaction(function () use ($order) {
                // Kembalikan stok
                foreach ($order->items as $item) {
                    if ($item->product) {
                        $item->product->increment('stock', $item->quantity);
                        if ($item->size) {
                            $item->product->sizes()
                                ->where('size', $item->size)
                                ->increment('stock', $item->quantity);
                        }
                    }
                }

                $order->update(['status' => 'cancelled']);
            });

            // Notifikasi ke customer
            NotificationHelper::toUser(
                $order->user_id,
                'Pesanan Dibatalkan Otomatis',
                "Pesanan {$order->invoice_number} dibatalkan karena batas waktu pembayaran 1 jam telah terlewati.",
                route('orders.show', $order->id)
            );

            // Notifikasi ke admin
            NotificationHelper::toAdmin(
                'Pesanan Auto-Cancel',
                "Pesanan {$order->invoice_number} dari {$order->shipping_name} dibatalkan otomatis karena timeout pembayaran.",
                route('admin.orders.show', $order->id)
            );

            $this->info("Cancelled: {$order->invoice_number}");
        }

        $this->info("Total dibatalkan: {$expired->count()} pesanan.");
    }
}