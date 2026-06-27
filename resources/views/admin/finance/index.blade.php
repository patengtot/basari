@extends('admin.layouts.app')

@section('title', 'Analisis Keuangan — Basari Admin')
@section('header', 'Analisis Keuangan')

@section('content')

{{-- Filter Bar --}}
<div class="bg-white rounded-xl border border-gray-100 p-5 mb-6">
    <div class="flex flex-col gap-4">

        {{-- Rentang Tanggal --}}
        <div>
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2">Rentang Tanggal</p>
            <div class="flex flex-wrap items-center gap-2">
                <input type="date" id="dateFrom" value="{{ $start->format('Y-m-d') }}"
                    class="text-sm border border-gray-200 rounded-lg px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-300 flex-1 min-w-0">
                <span class="text-gray-400">–</span>
                <input type="date" id="dateTo" value="{{ $end->format('Y-m-d') }}"
                    class="text-sm border border-gray-200 rounded-lg px-3 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-300 flex-1 min-w-0">
                <button id="applyDate"
                    class="px-4 py-1.5 text-sm bg-blue-900 text-white rounded-lg hover:bg-blue-800 transition whitespace-nowrap">
                    Tampilkan
                </button>
            </div>
        </div>

        {{-- Pilihan Cepat --}}
        <div>
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2">Pilihan Cepat</p>
            <div class="flex gap-2 flex-wrap">
                @foreach ([
                    'today'      => 'Hari Ini',
                    '7days'      => '7 Hari',
                    '30days'     => '30 Hari',
                    'this_month' => 'Bulan Ini',
                    'last_month' => 'Bulan Lalu',
                    'this_year'  => 'Tahun Ini',
                ] as $key => $label)
                <button data-preset="{{ $key }}"
                    class="preset-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                    {{ $label }}
                </button>
                @endforeach
            </div>
        </div>

        {{-- Tampilan Grafik + Export --}}
        <div class="flex flex-wrap items-end justify-between gap-3">
            <div>
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2">Tampilan Grafik</p>
                <div class="flex gap-2 flex-wrap">
                    @foreach (['daily' => 'Harian', 'weekly' => 'Mingguan', 'monthly' => 'Bulanan'] as $k => $v)
                    <button data-group="{{ $k }}"
                        class="group-btn px-3 py-1.5 text-xs rounded-lg border border-gray-200 text-gray-600 hover:border-blue-700 hover:text-blue-700 transition">
                        {{ $v }}
                    </button>
                    @endforeach
                </div>
            </div>
            <button id="exportPdf"
                class="flex items-center gap-2 px-4 py-1.5 text-sm border border-red-500 text-red-600 rounded-lg hover:bg-red-50 transition">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                </svg>
                Export PDF
            </button>
        </div>

    </div>

    <p class="text-xs text-gray-400 mt-4 pt-4 border-t border-gray-50" id="dateRangeLabel">Memuat data...</p>
</div>

{{-- Summary Cards --}}
<div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
    <div class="bg-white rounded-xl border border-gray-100 p-4">
        <p class="text-xs text-gray-400 mb-1">Total Pendapatan</p>
        <p class="text-lg font-bold text-blue-900" id="cardRevenue">Rp –</p>
        <p class="text-xs text-gray-400 mt-1">dari pesanan selesai</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-4">
        <p class="text-xs text-gray-400 mb-1">Pesanan Masuk</p>
        <p class="text-lg font-bold text-gray-800" id="cardOrders">–</p>
        <p class="text-xs text-gray-400 mt-1">tidak termasuk dibatalkan</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-4">
        <p class="text-xs text-gray-400 mb-1">Rata-rata per Pesanan</p>
        <p class="text-lg font-bold text-gray-800" id="cardAvg">Rp –</p>
        <p class="text-xs text-gray-400 mt-1">dari pesanan selesai</p>
    </div>
    <div class="bg-white rounded-xl border border-gray-100 p-4">
        <p class="text-xs text-gray-400 mb-1">Dibatalkan</p>
        <p class="text-lg font-bold text-red-500" id="cardCancel">–</p>
        <p class="text-xs text-gray-400 mt-1">pesanan</p>
    </div>
</div>

{{-- Grafik Utama --}}
<div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
    <div class="flex items-center justify-between mb-4">
        <h2 class="font-semibold text-gray-800">Grafik Pendapatan & Pesanan</h2>
        <span id="chartLoading" class="text-xs text-gray-400 hidden">Memuat...</span>
    </div>
    <div class="relative h-56 md:h-72">
        <canvas id="financeChart"></canvas>
    </div>
</div>

{{-- Category & Status --}}
<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-4">Pendapatan per Kategori</h2>
        <div class="relative h-48 mb-4">
            <canvas id="categoryChart"></canvas>
        </div>
        <div id="categoryTable" class="space-y-2"></div>
    </div>

    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-4">Distribusi Status Pesanan</h2>
        <div class="relative h-48 mb-4">
            <canvas id="statusChart"></canvas>
        </div>
        <div id="statusTable" class="space-y-2"></div>
    </div>
</div>

{{-- Top Products --}}
<div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
    <h2 class="font-semibold text-gray-800 mb-4">Produk Terlaris</h2>
    <div class="overflow-x-auto">
        <table class="w-full text-sm">
            <thead>
                <tr class="text-xs text-gray-400 border-b border-gray-100">
                    <th class="pb-3 text-left font-medium">#</th>
                    <th class="pb-3 text-left font-medium">Produk</th>
                    <th class="pb-3 text-right font-medium">Terjual</th>
                    <th class="pb-3 text-right font-medium">Revenue</th>
                </tr>
            </thead>
            <tbody id="topProductsTable" class="divide-y divide-gray-50">
                <tr><td colspan="4" class="py-6 text-center text-gray-400 text-xs">Memuat data...</td></tr>
            </tbody>
        </table>
    </div>
</div>

@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
let currentFrom   = '{{ $start->format('Y-m-d') }}';
let currentTo     = '{{ $end->format('Y-m-d') }}';
let currentGroup  = 'daily';
let currentPreset = '30days';

let financeChart = null, categoryChart = null, statusChart = null;

const fmt = n => 'Rp ' + Number(n).toLocaleString('id-ID');

function initFinanceChart(labels, revenues, orders) {
    const ctx = document.getElementById('financeChart').getContext('2d');
    if (financeChart) financeChart.destroy();
    financeChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels,
            datasets: [
                {
                    label: 'Pendapatan',
                    data: revenues,
                    backgroundColor: 'rgba(30,64,175,0.85)',
                    borderRadius: 6,
                    yAxisID: 'y',
                },
                {
                    label: 'Pesanan',
                    data: orders,
                    type: 'line',
                    borderColor: '#f59e0b',
                    backgroundColor: 'rgba(245,158,11,0.1)',
                    pointBackgroundColor: '#f59e0b',
                    tension: 0.4,
                    yAxisID: 'y1',
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top', labels: { font: { size: 11 } } } },
            scales: {
                y:  { position: 'left',  grid: { color: '#f3f4f6' }, ticks: { callback: v => fmt(v), font: { size: 10 } } },
                y1: { position: 'right', grid: { drawOnChartArea: false }, ticks: { font: { size: 10 } } },
                x:  { grid: { display: false }, ticks: { font: { size: 10 } } },
            }
        }
    });
}

function initDoughnut(id, labels, values, colors) {
    const ctx = document.getElementById(id).getContext('2d');
    const existing = id === 'categoryChart' ? categoryChart : statusChart;
    if (existing) existing.destroy();
    const chart = new Chart(ctx, {
        type: 'doughnut',
        data: { labels, datasets: [{ data: values, backgroundColor: colors, borderWidth: 2 }] },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
    });
    if (id === 'categoryChart') categoryChart = chart;
    else statusChart = chart;
}

function loadData() {
    document.getElementById('chartLoading').classList.remove('hidden');
    const params = new URLSearchParams({ from: currentFrom, to: currentTo });

    fetch(`{{ route('admin.finance.chart') }}?` + params)
        .then(r => r.json())
        .then(data => {
            document.getElementById('chartLoading').classList.add('hidden');

            const s = data.summary;
            document.getElementById('cardRevenue').textContent = fmt(s.revenue);
            document.getElementById('cardOrders').textContent  = s.totalOrders;
            document.getElementById('cardAvg').textContent     = fmt(s.avgOrder);
            document.getElementById('cardCancel').textContent  = s.cancelOrders;

            document.getElementById('dateRangeLabel').textContent =
                `Data dari ${fmtDate(currentFrom)} sampai ${fmtDate(currentTo)}`;

            initFinanceChart(
                data.chart.map(d => d.label),
                data.chart.map(d => d.revenue),
                data.chart.map(d => d.orders)
            );

            const catColors = ['#1e3a8a','#2563eb','#60a5fa','#93c5fd','#bfdbfe'];
            initDoughnut('categoryChart',
                data.byCategory.map(c => c.category),
                data.byCategory.map(c => parseFloat(c.revenue)),
                catColors.slice(0, data.byCategory.length)
            );
            document.getElementById('categoryTable').innerHTML = data.byCategory.map(c =>
                `<div class="flex justify-between items-center text-xs py-1 border-b border-gray-50">
                    <span class="text-gray-700 font-medium">${c.category}</span>
                    <div class="flex gap-4 text-gray-500">
                        <span>${Number(c.qty).toLocaleString('id-ID')} pcs</span>
                        <span class="font-semibold text-blue-900">${fmt(c.revenue)}</span>
                    </div>
                </div>`
            ).join('') || '<p class="text-xs text-gray-400 text-center py-4">Tidak ada data</p>';

            const statusColor = {
                done: '#22c55e', paid: '#3b82f6', processing: '#8b5cf6',
                shipped: '#0ea5e9', pending: '#f59e0b', cancelled: '#ef4444',
                waiting_shipping_cost: '#f97316',
            };
            const statusLabel = {
                pending: 'Menunggu', paid: 'Dibayar', processing: 'Diproses',
                shipped: 'Dikirim', done: 'Selesai', cancelled: 'Dibatalkan',
                waiting_shipping_cost: 'Menunggu Ongkir',
            };
            const statusKeys = Object.keys(data.byStatus);
            const statusVals = Object.values(data.byStatus);
            initDoughnut('statusChart', statusKeys, statusVals, statusKeys.map(k => statusColor[k] || '#94a3b8'));

            const total = statusVals.reduce((a, b) => a + b, 0);
            document.getElementById('statusTable').innerHTML = statusKeys.map((st, i) => {
                const pct = total > 0 ? ((statusVals[i] / total) * 100).toFixed(1) : 0;
                const colorClass = {
                    done: 'bg-green-100 text-green-700', paid: 'bg-blue-100 text-blue-700',
                    processing: 'bg-purple-100 text-purple-700', shipped: 'bg-sky-100 text-sky-700',
                    pending: 'bg-yellow-100 text-yellow-700', cancelled: 'bg-red-100 text-red-700',
                    waiting_shipping_cost: 'bg-orange-100 text-orange-700',
                }[st] || 'bg-gray-100 text-gray-600';
                return `<div class="flex justify-between items-center text-xs py-1 border-b border-gray-50">
                    <span class="px-2 py-0.5 rounded-full font-medium ${colorClass}">${statusLabel[st] || st}</span>
                    <div class="flex gap-3 text-gray-500">
                        <span>${statusVals[i]} pesanan</span>
                        <span class="text-gray-400">${pct}%</span>
                    </div>
                </div>`;
            }).join('') || '<p class="text-xs text-gray-400 text-center py-4">Tidak ada data</p>';

            document.getElementById('topProductsTable').innerHTML = data.topProducts.length
                ? data.topProducts.map((p, i) =>
                    `<tr>
                        <td class="py-3 pr-3 text-gray-400 text-xs">${i + 1}</td>
                        <td class="py-3 text-gray-800 font-medium">${p.name}</td>
                        <td class="py-3 text-right text-gray-600">${Number(p.qty).toLocaleString('id-ID')} pcs</td>
                        <td class="py-3 text-right font-semibold text-blue-900">${fmt(p.revenue)}</td>
                    </tr>`
                ).join('')
                : '<tr><td colspan="4" class="py-6 text-center text-gray-400 text-xs">Tidak ada data</td></tr>';
        });
}

function fmtDate(str) {
    const d = new Date(str);
    const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return `${d.getDate()} ${m[d.getMonth()]} ${d.getFullYear()}`;
}

const presetRanges = {
    today:      () => { const d = todayStr(); return [d, d]; },
    '7days':    () => [addDays(-6), todayStr()],
    '30days':   () => [addDays(-29), todayStr()],
    this_month: () => { const d = new Date(); return [`${d.getFullYear()}-${pad(d.getMonth()+1)}-01`, todayStr()]; },
    last_month: () => {
        const d = new Date(); d.setDate(1); d.setMonth(d.getMonth() - 1);
        const start = toISO(d); d.setMonth(d.getMonth() + 1); d.setDate(0);
        return [start, toISO(d)];
    },
    this_year: () => { const y = new Date().getFullYear(); return [`${y}-01-01`, `${y}-12-31`]; },
};
const todayStr = () => toISO(new Date());
const toISO    = d => new Date(d).toISOString().split('T')[0];
const addDays  = n => { const d = new Date(); d.setDate(d.getDate() + n); return toISO(d); };
const pad      = n => String(n).padStart(2, '0');

function setActive(selector, activeKey) {
    document.querySelectorAll(selector).forEach(b => {
        const key = b.dataset[selector === '.preset-btn' ? 'preset' : 'group'];
        const isActive = key === activeKey;
        b.classList.toggle('bg-blue-700', isActive);
        b.classList.toggle('text-white', isActive);
        b.classList.toggle('border-blue-700', isActive);
        b.classList.toggle('text-gray-600', !isActive);
        b.classList.toggle('border-gray-200', !isActive);
    });
}

document.querySelectorAll('.preset-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const key = btn.dataset.preset;
        const [from, to] = presetRanges[key]();
        currentFrom = from; currentTo = to; currentPreset = key;
        document.getElementById('dateFrom').value = from;
        document.getElementById('dateTo').value   = to;
        setActive('.preset-btn', key);
        loadData();
    });
});

document.querySelectorAll('.group-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        currentGroup = btn.dataset.group;
        setActive('.group-btn', currentGroup);
        loadData();
    });
});

document.getElementById('applyDate').addEventListener('click', () => {
    currentFrom = document.getElementById('dateFrom').value;
    currentTo   = document.getElementById('dateTo').value;
    currentPreset = '';
    setActive('.preset-btn', null);
    loadData();
});

document.getElementById('exportPdf').addEventListener('click', () => {
    const params = new URLSearchParams({ from: currentFrom, to: currentTo });
    window.location.href = `{{ route('admin.finance.export') }}?` + params;
});

setActive('.preset-btn', '30days');
setActive('.group-btn', 'daily');
loadData();
</script>
@endpush