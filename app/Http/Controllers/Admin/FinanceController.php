<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Order;
use App\Models\OrderItem;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;

class FinanceController extends Controller
{
    public function index(Request $request)
    {
        [$start, $end] = $this->resolveDateRange($request);
        $categories = Category::all();

        return view('admin.finance.index', compact('categories', 'start', 'end'));
    }

    public function chartData(Request $request)
    {
        [$start, $end] = $this->resolveDateRange($request);

        return response()->json([
            'chart'       => $this->buildChartData($start, $end),
            'summary'     => $this->getSummary($start, $end),
            'byCategory'  => $this->getByCategory($start, $end),
            'topProducts' => $this->getTopProducts($start, $end),
            'byStatus'    => $this->getByStatus($start, $end),
        ]);
    }

    public function export(Request $request)
    {
        [$start, $end] = $this->resolveDateRange($request);

        $summary = $this->getSummary($start, $end);
        $byCategory = $this->getByCategory($start, $end);

        $orders = Order::with(['items.product.category', 'user'])
            ->whereBetween('created_at', [$start, $end->copy()->endOfDay()])
            ->whereNotIn('status', ['cancelled'])
            ->orderBy('created_at', 'desc')
            ->get();

        $pdf = Pdf::loadView('admin.finance.pdf', compact('summary', 'byCategory', 'orders', 'start', 'end'))
                  ->setPaper('a4', 'landscape');

        $filename = 'laporan-keuangan-' . $start->format('Ymd') . '-' . $end->format('Ymd') . '.pdf';

        return $pdf->download($filename);
    }

    // ── Private helpers ────────────────────────────────────────────────

    private function resolveDateRange(Request $request): array
    {
        $from = $request->get('from') ? Carbon::parse($request->get('from'))->startOfDay() : Carbon::today()->subDays(29);
        $to   = $request->get('to')   ? Carbon::parse($request->get('to'))->endOfDay()     : Carbon::today()->endOfDay();

        return [$from, $to];
    }

    private function getSummary(Carbon $start, Carbon $end): array
    {
        $base = Order::whereBetween('created_at', [$start, $end->copy()->endOfDay()]);

        $revenue      = (clone $base)->where('status', 'done')->sum('total_amount');
        $totalOrders  = (clone $base)->whereNotIn('status', ['cancelled'])->count();
        $doneOrders   = (clone $base)->where('status', 'done')->count();
        $cancelOrders = (clone $base)->where('status', 'cancelled')->count();
        $avgOrder     = $doneOrders > 0 ? $revenue / $doneOrders : 0;
        $shippingCost = (clone $base)->where('status', 'done')
                            ->selectRaw('SUM(shipping_cost + COALESCE(intl_shipping_cost, 0)) as total')
                            ->value('total') ?? 0;

        return compact('revenue', 'totalOrders', 'doneOrders', 'cancelOrders', 'avgOrder', 'shippingCost');
    }

    private function buildChartData(Carbon $start, Carbon $end): array
    {
        $data    = [];
        $current = $start->copy();

        while ($current->lte($end)) {
            $date   = $current->toDateString();
            $data[] = [
                'label'   => $current->format('d M'),
                'revenue' => (float) Order::whereDate('created_at', $date)->where('status', 'done')->sum('total_amount'),
                'orders'  => Order::whereDate('created_at', $date)->whereNotIn('status', ['cancelled'])->count(),
            ];
            $current->addDay();
        }

        return $data;
    }

    private function getByCategory(Carbon $start, Carbon $end): array
    {
        return OrderItem::join('orders', 'order_items.order_id', '=', 'orders.id')
            ->join('products', 'order_items.product_id', '=', 'products.id')
            ->join('categories', 'products.category_id', '=', 'categories.id')
            ->whereBetween('orders.created_at', [$start, $end->copy()->endOfDay()])
            ->where('orders.status', 'done')
            ->groupBy('categories.id', 'categories.name')
            ->selectRaw('categories.name as category, SUM(order_items.subtotal) as revenue, SUM(order_items.quantity) as qty')
            ->orderByDesc('revenue')
            ->get()->toArray();
    }

    private function getTopProducts(Carbon $start, Carbon $end, int $limit = 10): array
    {
        return OrderItem::join('orders', 'order_items.order_id', '=', 'orders.id')
            ->whereBetween('orders.created_at', [$start, $end->copy()->endOfDay()])
            ->where('orders.status', 'done')
            ->groupBy('order_items.product_id', 'order_items.product_name')
            ->selectRaw('order_items.product_name as name, SUM(order_items.quantity) as qty, SUM(order_items.subtotal) as revenue')
            ->orderByDesc('revenue')
            ->limit($limit)
            ->get()->toArray();
    }

    private function getByStatus(Carbon $start, Carbon $end): array
    {
        return Order::whereBetween('created_at', [$start, $end->copy()->endOfDay()])
            ->groupBy('status')
            ->selectRaw('status, COUNT(*) as total')
            ->pluck('total', 'status')
            ->toArray();
    }
}