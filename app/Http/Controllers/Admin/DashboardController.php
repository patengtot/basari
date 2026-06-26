<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\PageVisit;
use App\Models\Product;
use App\Models\ProductView;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        // Summary cards
        $totalOrders    = Order::count();
        $totalRevenue   = Order::where('status', 'done')->sum('total_amount');
        $totalCustomers = User::count();
        $totalProducts  = Product::where('is_active', true)->count();

        // Grafik penjualan 7 hari (existing)
        $salesChart = collect(range(6, 0))->map(function ($days) {
            $date = Carbon::today()->subDays($days);
            return [
                'date'  => $date->format('d M'),
                'total' => Order::whereDate('created_at', $date)
                                ->where('status', '!=', 'cancelled')
                                ->sum('total_amount'),
            ];
        });

      // Produk terpopuler
$popularProducts = Product::withCount('views')
                           ->orderByDesc('views_count')
                           ->get();

                           // Produk terlaris (orders)
$bestSellerProducts = Product::withCount(['orderItems as sold_count'])
                              ->orderByDesc('sold_count')
                              ->get();

        return view('admin.dashboard', compact(
            'totalOrders', 'totalRevenue', 'totalCustomers', 'totalProducts',
            'salesChart', 'popularProducts', 'bestSellerProducts'
        ));
    }

    // API endpoint traffic data
    public function trafficData(Request $request)
{
    $period = $request->get('period', 'daily');
    $from   = $request->get('from') ? Carbon::parse($request->get('from'))->startOfDay() : null;
    $to     = $request->get('to')   ? Carbon::parse($request->get('to'))->endOfDay()     : null;

    // Kalau ada custom date range, selalu pakai harian
    if ($from && $to) {
        $data    = collect();
        $current = $from->copy();
        while ($current->lte($to)) {
            $date   = $current->toDateString();
            $data[] = [
                'label'    => $current->format('d M'),
                'visitors' => PageVisit::whereDate('created_at', $date)->distinct('ip_address')->count(),
                'visits'   => PageVisit::whereDate('created_at', $date)->count(),
            ];
            $current->addDay();
        }
        return response()->json($data);
    }

    // Kalau tidak ada custom range, pakai preset period seperti semula
    switch ($period) {
        case 'weekly':
            $data = collect(range(6, 0))->map(function ($weeks) {
                $start = Carbon::now()->subWeeks($weeks)->startOfWeek();
                $end   = Carbon::now()->subWeeks($weeks)->endOfWeek();
                return [
                    'label'    => 'Minggu ' . $start->format('d M'),
                    'visitors' => PageVisit::whereBetween('created_at', [$start, $end])->distinct('ip_address')->count(),
                    'visits'   => PageVisit::whereBetween('created_at', [$start, $end])->count(),
                ];
            });
            break;

        case 'monthly':
            $data = collect(range(5, 0))->map(function ($months) {
                $start = Carbon::now()->subMonths($months)->startOfMonth();
                $end   = Carbon::now()->subMonths($months)->endOfMonth();
                return [
                    'label'    => $start->format('M Y'),
                    'visitors' => PageVisit::whereBetween('created_at', [$start, $end])->distinct('ip_address')->count(),
                    'visits'   => PageVisit::whereBetween('created_at', [$start, $end])->count(),
                ];
            });
            break;

        default:
            $data = collect(range(13, 0))->map(function ($days) {
                $date = Carbon::today()->subDays($days);
                return [
                    'label'    => $date->format('d M'),
                    'visitors' => PageVisit::whereDate('created_at', $date)->distinct('ip_address')->count(),
                    'visits'   => PageVisit::whereDate('created_at', $date)->count(),
                ];
            });
    }

    return response()->json($data);
}
    // API endpoint revenue data
    public function revenueData(Request $request)
    {
    $period = $request->get('period', 'daily');

    switch ($period) {
        case 'weekly':
            $data = collect(range(6, 0))->map(function ($weeks) {
                $start = Carbon::now()->subWeeks($weeks)->startOfWeek();
                $end   = Carbon::now()->subWeeks($weeks)->endOfWeek();
                return [
                    'label'   => 'Minggu ' . $start->format('d M'),
                    'revenue' => Order::whereBetween('created_at', [$start, $end])->where('status', 'done')->sum('total_amount'),
                    'orders'  => Order::whereBetween('created_at', [$start, $end])->where('status', '!=', 'cancelled')->count(),
                ];
            });

            // Summary = minggu ini saja
            $summaryStart = Carbon::now()->startOfWeek();
            $summaryEnd   = Carbon::now()->endOfWeek();
            break;

        case 'monthly':
            $data = collect(range(5, 0))->map(function ($months) {
                $start = Carbon::now()->subMonths($months)->startOfMonth();
                $end   = Carbon::now()->subMonths($months)->endOfMonth();
                return [
                    'label'   => $start->format('M Y'),
                    'revenue' => Order::whereBetween('created_at', [$start, $end])->where('status', 'done')->sum('total_amount'),
                    'orders'  => Order::whereBetween('created_at', [$start, $end])->where('status', '!=', 'cancelled')->count(),
                ];
            });

            // Summary = bulan ini saja
            $summaryStart = Carbon::now()->startOfMonth();
            $summaryEnd   = Carbon::now()->endOfMonth();
            break;

        case 'yearly':
            $data = collect(range(4, 0))->map(function ($years) {
                $start = Carbon::now()->subYears($years)->startOfYear();
                $end   = Carbon::now()->subYears($years)->endOfYear();
                return [
                    'label'   => $start->format('Y'),
                    'revenue' => Order::whereBetween('created_at', [$start, $end])->where('status', 'done')->sum('total_amount'),
                    'orders'  => Order::whereBetween('created_at', [$start, $end])->where('status', '!=', 'cancelled')->count(),
                ];
            });

            // Summary = tahun ini saja
            $summaryStart = Carbon::now()->startOfYear();
            $summaryEnd   = Carbon::now()->endOfYear();
            break;

        default: // daily
            $data = collect(range(13, 0))->map(function ($days) {
                $date = Carbon::today()->subDays($days);
                return [
                    'label'   => $date->format('d M'),
                    'revenue' => Order::whereDate('created_at', $date)->where('status', 'done')->sum('total_amount'),
                    'orders'  => Order::whereDate('created_at', $date)->where('status', '!=', 'cancelled')->count(),
                ];
            });

            // Summary = hari ini saja
            $summaryStart = Carbon::today()->startOfDay();
            $summaryEnd   = Carbon::today()->endOfDay();
            break;
    }

    // Hitung summary untuk periode aktif
    $summaryRevenue = Order::whereBetween('created_at', [$summaryStart, $summaryEnd])
                           ->where('status', 'done')
                           ->sum('total_amount');

    $summaryOrders  = Order::whereBetween('created_at', [$summaryStart, $summaryEnd])
                           ->where('status', '!=', 'cancelled')
                           ->count();

    return response()->json([
        'data'    => $data,
        'summary' => [
            'revenue' => (float) $summaryRevenue,
            'orders'  => $summaryOrders,
        ]
    ]);
    }
}