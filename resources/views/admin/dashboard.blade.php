@extends('admin.layouts.app')

@section('title', 'Dashboard — Basari Admin')
@section('header', 'Dashboard')

@section('content')

{{-- Summary Cards --}}
<div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
    <div class="bg-white rounded-xl border border-gray-100 p-5">
        <p class="text-xs text-gray-400 mb-1">Total Pesanan</p>
        <p class="text-2xl font-bold text-gray-800">{{ number_format($totalOrders) }}</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-5">
        <p class="text-xs text-gray-400 mb-1">Total Pendapatan</p>
        <p class="text-2xl font-bold text-blue-900">Rp {{ number_format($totalRevenue, 0, ',', '.') }}</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-5">
        <p class="text-xs text-gray-400 mb-1">Total Pembeli</p>
        <p class="text-2xl font-bold text-gray-800">{{ number_format($totalCustomers) }}</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-5">
        <p class="text-xs text-gray-400 mb-1">Produk Aktif</p>
        <p class="text-2xl font-bold text-gray-800">{{ number_format($totalProducts) }}</p>
    </div>
</div>

{{-- Traffic Chart --}}
<div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
    <div class="flex items-center justify-between mb-4">
        <h2 class="font-semibold text-gray-800">Traffic Pengunjung</h2>
        <div class="flex flex-col md:flex-row md:items-center gap-3">
            {{-- Date range --}}
            <div class="flex items-center gap-2">
                <input type="date" id="trafficFrom"
                    value="{{ now()->subDays(6)->format('Y-m-d') }}"
                    class="text-xs border border-gray-200 rounded-lg px-2 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-300">
                <span class="text-gray-400 text-xs">–</span>
                <input type="date" id="trafficTo"
                    value="{{ now()->format('Y-m-d') }}"
                    class="text-xs border border-gray-200 rounded-lg px-2 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-300">
                <button onclick="applyTrafficDate()"
                    class="px-3 py-1.5 text-xs bg-blue-900 text-white rounded-lg hover:bg-blue-800 transition">
                    Terapkan
                </button>
            </div>
            <div class="w-px h-5 bg-gray-200"></div>
            {{-- Period buttons --}}
            <div class="flex flex-wrap gap-2">
                <button onclick="loadTraffic('daily')" id="traffic-daily"
                    class="traffic-btn px-3 py-1.5 text-xs rounded-lg border border-blue-700 bg-blue-700 text-white transition">
                    Harian
                </button>
                <button onclick="loadTraffic('weekly')" id="traffic-weekly"
                    class="traffic-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                    Mingguan
                </button>
                <button onclick="loadTraffic('monthly')" id="traffic-monthly"
                    class="traffic-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                    Bulanan
                </button>
            </div>
        </div>
    </div>
    <p class="text-xs text-gray-400 mb-3" id="trafficDateLabel"></p>
    <div class="relative h-48 md:h-64">
        <canvas id="trafficChart"></canvas>
    </div>
    <div class="flex gap-6 mt-4">
    <div class="flex items-center gap-2">
        <div class="w-3 h-3 rounded-full bg-blue-700"></div>
        <span class="text-xs text-gray-500">Total Kunjungan</span>
    </div>
</div>
</div>

{{-- Revenue Chart + Popular Products --}}
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">

    {{-- Revenue Chart --}}
<div class="md:col-span-2 bg-white rounded-xl border border-gray-100 p-6">
    <div class="flex items-center justify-between mb-4">
        <h2 class="font-semibold text-gray-800">Laporan Keuangan</h2>
        <div class="flex gap-2">
            <button onclick="loadRevenue('daily')" id="revenue-daily"
                class="revenue-btn px-3 py-1.5 text-xs rounded-lg border border-blue-700 bg-blue-700 text-white transition">
                Harian
            </button>
            <button onclick="loadRevenue('weekly')" id="revenue-weekly"
                class="revenue-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                Mingguan
            </button>
            <button onclick="loadRevenue('monthly')" id="revenue-monthly"
                class="revenue-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                Bulanan
            </button>
            <button onclick="loadRevenue('yearly')" id="revenue-yearly"
                class="revenue-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                Tahunan
            </button>
        </div>
    </div>

    {{-- Summary angka --}}
    <div class="grid grid-cols-3 gap-3 mb-5">
    <div class="bg-blue-50 rounded-xl p-4">
        <p class="text-xs text-gray-400 mb-1">Total Pendapatan <span id="summaryPeriodLabel" class="text-blue-700 font-medium"></span></p>
        <p class="text-lg font-bold text-blue-900" id="summaryRevenue">Rp 0</p>
    </div>
    <div class="bg-gray-50 rounded-xl p-4">
        <p class="text-xs text-gray-400 mb-1">Jumlah Pesanan</p>
        <p class="text-lg font-bold text-gray-800" id="summaryOrders">0</p>
    </div>
    <div class="bg-gray-50 rounded-xl p-4">
        <p class="text-xs text-gray-400 mb-1">Rata-rata per Pesanan</p>
        <p class="text-lg font-bold text-gray-800" id="summaryAvg">Rp 0</p>
    </div>
</div>

    <div class="relative h-40 md:h-56">
        <canvas id="revenueChart"></canvas>
    </div>
</div>

    {{-- Popular Products --}}
<div class="bg-white rounded-xl border border-gray-100 p-6">
    <div class="flex items-center justify-between mb-4">
        <h2 class="font-semibold text-gray-800">Statistik Produk</h2>
        <div class="flex gap-1 bg-gray-100 rounded-lg p-1 overflow-x-auto">
            <button onclick="showTab('views')" id="tab-views"
                class="product-tab px-3 py-1 text-xs rounded-md font-medium transition bg-white text-gray-800 shadow-sm">
                Terbanyak Dilihat
            </button>
            <button onclick="showTab('sold')" id="tab-sold"
                class="product-tab px-3 py-1 text-xs rounded-md font-medium transition text-gray-500">
                Terlaris
            </button>
        </div>
    </div>

    {{-- Views --}}
    <div id="list-views" class="space-y-3 max-h-72 overflow-y-auto pr-1">
        @forelse($popularProducts as $index => $product)
        @php
            $maxViews = $popularProducts->first()->views_count ?? 1;
            $percent  = $maxViews > 0 ? ($product->views_count / $maxViews * 100) : 0;
            $colors   = ['#1e3a8a', '#2563eb', '#3b82f6', '#60a5fa', '#93c5fd'];
            $color    = $colors[min($index, 4)];
        @endphp
        <div>
            <div class="flex items-center gap-3 mb-1">
                <span class="w-5 h-5 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0"
                      style="background: {{ $color }}; font-size: 10px;">
                    {{ $index + 1 }}
                </span>
                <p class="text-sm text-gray-700 flex-1 truncate">{{ $product->name }}</p>
                <span class="text-xs font-semibold text-gray-500 flex-shrink-0">{{ number_format($product->views_count) }} views</span>
            </div>
            <div class="ml-8 bg-gray-100 rounded-full h-2">
                <div class="h-2 rounded-full transition-all duration-500"
                     style="width: {{ $percent }}%; background: {{ $color }};"></div>
            </div>
        </div>
        @empty
        <p class="text-sm text-gray-400 text-center py-4">Belum ada data views.</p>
        @endforelse
    </div>

    {{-- Terlaris --}}
    <div id="list-sold" class="space-y-3 max-h-72 overflow-y-auto pr-1 hidden">
        @forelse($bestSellerProducts as $index => $product)
        @php
            $maxSold  = $bestSellerProducts->first()->sold_count ?? 1;
            $percent  = $maxSold > 0 ? ($product->sold_count / $maxSold * 100) : 0;
            $colors   = ['#15803d', '#16a34a', '#22c55e', '#4ade80', '#86efac'];
            $color    = $colors[min($index, 4)];
        @endphp
        <div>
            <div class="flex items-center gap-3 mb-1">
                <span class="w-5 h-5 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0"
                      style="background: {{ $color }}; font-size: 10px;">
                    {{ $index + 1 }}
                </span>
                <p class="text-sm text-gray-700 flex-1 truncate">{{ $product->name }}</p>
                <span class="text-xs font-semibold text-gray-500 flex-shrink-0">{{ number_format($product->sold_count) }} terjual</span>
            </div>
            <div class="ml-8 bg-gray-100 rounded-full h-2">
                <div class="h-2 rounded-full transition-all duration-500"
                     style="width: {{ $percent }}%; background: {{ $color }};"></div>
            </div>
        </div>
        @empty
        <p class="text-sm text-gray-400 text-center py-4">Belum ada data penjualan.</p>
        @endforelse
    </div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
let trafficChart, revenueChart;

// ===== TRAFFIC CHART =====
async function loadTraffic(period) {
    document.querySelectorAll('.traffic-btn').forEach(btn => {
        btn.classList.remove('bg-blue-700', 'text-white', 'border-blue-700');
        btn.classList.add('border-gray-200', 'text-gray-600');
    });
    const active = document.getElementById('traffic-' + period);
    if (active) {
        active.classList.add('bg-blue-700', 'text-white', 'border-blue-700');
        active.classList.remove('border-gray-200', 'text-gray-600');
    }

    // Reset date picker ke preset period
    const today = new Date().toISOString().split('T')[0];
    let fromDate = today;
    if (period === 'daily')   fromDate = subtractDays(today, 6);
    if (period === 'weekly')  fromDate = subtractDays(today, 27);
    if (period === 'monthly') fromDate = subtractDays(today, 179);

    document.getElementById('trafficFrom').value = fromDate;
    document.getElementById('trafficTo').value   = today;

    fetchTraffic(period, fromDate, today);
}

function applyTrafficDate() {
    const from = document.getElementById('trafficFrom').value;
    const to   = document.getElementById('trafficTo').value;
    if (!from || !to) return;

    // Nonaktifkan semua period button karena pakai custom range
    document.querySelectorAll('.traffic-btn').forEach(btn => {
        btn.classList.remove('bg-blue-700', 'text-white', 'border-blue-700');
        btn.classList.add('border-gray-200', 'text-gray-600');
    });

    fetchTraffic('daily', from, to);
}

async function fetchTraffic(period, from, to) {
    const res  = await fetch(`/admin/dashboard/traffic?period=${period}&from=${from}&to=${to}`);
    const data = await res.json();

    const labels = data.map(d => d.label);
    const visits = data.map(d => d.visits);

    const fromFmt = new Date(from).toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' });
    const toFmt   = new Date(to).toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' });
    document.getElementById('trafficDateLabel').textContent = `Menampilkan data ${fromFmt} — ${toFmt}`;

    if (trafficChart) trafficChart.destroy();

    trafficChart = new Chart(document.getElementById('trafficChart'), {
        type: 'bar',
        data: {
            labels,
            datasets: [
                { label: 'Total Kunjungan', data: visits, backgroundColor: '#1e3a8a', borderRadius: 4 }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, ticks: { precision: 0, font: { size: 11 } }, grid: { color: '#f3f4f6' } },
                x: { ticks: { font: { size: 11 } }, grid: { display: false } }
            }
        }
    });
}

function subtractDays(dateStr, days) {
    const d = new Date(dateStr);
    d.setDate(d.getDate() - days);
    return d.toISOString().split('T')[0];
}

// ===== REVENUE CHART =====
async function loadRevenue(period) {
    document.querySelectorAll('.revenue-btn').forEach(btn => {
        btn.classList.remove('bg-blue-700', 'text-white', 'border-blue-700');
        btn.classList.add('border-gray-200', 'text-gray-600');
    });
    const active = document.getElementById('revenue-' + period);
    active.classList.add('bg-blue-700', 'text-white', 'border-blue-700');
    active.classList.remove('border-gray-200', 'text-gray-600');

    const res     = await fetch(`/admin/dashboard/revenue?period=${period}`);
    const result  = await res.json();
    const data    = result.data;
    const summary = result.summary;

    const labels  = data.map(d => d.label);
    const revenue = data.map(d => parseFloat(d.revenue));
    const orders  = data.map(d => parseInt(d.orders));

    // Update summary angka — pakai data periode aktif saja
    const totalRevenue = parseFloat(summary.revenue);
    const totalOrders  = parseInt(summary.orders);
    const avgOrder     = totalOrders > 0 ? Math.round(totalRevenue / totalOrders) : 0;

    const periodLabels = {
        'daily':   'Hari Ini',
        'weekly':  'Minggu Ini',
        'monthly': 'Bulan Ini',
        'yearly':  'Tahun Ini',
    };

    document.getElementById('summaryRevenue').textContent = 'Rp ' + Math.round(totalRevenue).toLocaleString('id-ID');
    document.getElementById('summaryOrders').textContent  = totalOrders.toLocaleString('id-ID') + ' pesanan';
    document.getElementById('summaryAvg').textContent     = 'Rp ' + avgOrder.toLocaleString('id-ID');
    document.getElementById('summaryPeriodLabel').textContent = periodLabels[period] ?? '';

    if (revenueChart) revenueChart.destroy();

    revenueChart = new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels,
            datasets: [
                {
                    label: 'Pendapatan (Rp)',
                    data: revenue,
                    borderColor: '#1e3a8a',
                    backgroundColor: 'rgba(30,58,138,0.08)',
                    borderWidth: 2,
                    pointRadius: 4,
                    pointBackgroundColor: '#1e3a8a',
                    tension: 0.4,
                    fill: true,
                    yAxisID: 'y',
                },
                {
                    label: 'Jumlah Pesanan',
                    data: orders,
                    borderColor: '#93c5fd',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    pointRadius: 3,
                    pointBackgroundColor: '#93c5fd',
                    tension: 0.4,
                    borderDash: [4, 4],
                    yAxisID: 'y1',
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: true, position: 'top', labels: { font: { size: 11 }, boxWidth: 12 } },
                tooltip: {
                    callbacks: {
                        label: function(ctx) {
                            if (ctx.datasetIndex === 0) return ' Rp ' + ctx.raw.toLocaleString('id-ID');
                            return ' ' + ctx.raw + ' pesanan';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    position: 'left',
                    ticks: { font: { size: 10 }, callback: val => 'Rp ' + (val/1000).toFixed(0) + 'k' },
                    grid: { color: '#f3f4f6' }
                },
                y1: {
                    beginAtZero: true,
                    position: 'right',
                    ticks: { precision: 0, font: { size: 10 } },
                    grid: { display: false }
                },
                x: {
                    ticks: { font: { size: 11 } },
                    grid: { display: false }
                }
            }
        }
    });
}

loadTraffic('daily');
loadRevenue('daily');
</script>
<script>
function showTab(tab) {
    document.getElementById('list-views').classList.toggle('hidden', tab !== 'views');
    document.getElementById('list-sold').classList.toggle('hidden', tab !== 'sold');

    document.querySelectorAll('.product-tab').forEach(btn => {
        btn.classList.remove('bg-white', 'text-gray-800', 'shadow-sm');
        btn.classList.add('text-gray-500');
    });

    const active = document.getElementById('tab-' + tab);
    active.classList.add('bg-white', 'text-gray-800', 'shadow-sm');
    active.classList.remove('text-gray-500');
}
</script>

@endsection