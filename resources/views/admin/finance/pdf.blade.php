<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'DejaVu Sans', sans-serif; font-size: 11px; color: #1f2937; }

        .header { padding: 20px 24px 16px; border-bottom: 2px solid #1e3a8a; margin-bottom: 20px; }
        .header h1 { font-size: 18px; font-weight: bold; color: #1e3a8a; }
        .header p  { font-size: 10px; color: #6b7280; margin-top: 4px; }

        .summary { display: flex; gap: 12px; margin-bottom: 20px; padding: 0 24px; }
        .summary-card { flex: 1; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 12px; }
        .summary-card .label { font-size: 9px; color: #94a3b8; margin-bottom: 4px; }
        .summary-card .value { font-size: 14px; font-weight: bold; color: #1e3a8a; }
        .summary-card .sub   { font-size: 9px; color: #94a3b8; margin-top: 2px; }

        .section { padding: 0 24px; margin-bottom: 20px; }
        .section h2 { font-size: 12px; font-weight: bold; color: #1f2937; margin-bottom: 10px; padding-bottom: 6px; border-bottom: 1px solid #e5e7eb; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #1e3a8a; color: white; padding: 7px 10px; text-align: left; font-size: 9px; font-weight: 600; }
        td { padding: 6px 10px; font-size: 10px; border-bottom: 1px solid #f1f5f9; }
        tr:nth-child(even) td { background: #f8fafc; }
        .text-right { text-align: right; }
        .text-center { text-align: center; }

        .badge { display: inline-block; padding: 2px 7px; border-radius: 9999px; font-size: 9px; font-weight: 600; }
        .badge-done       { background: #dcfce7; color: #15803d; }
        .badge-paid       { background: #dbeafe; color: #1d4ed8; }
        .badge-processing { background: #ede9fe; color: #6d28d9; }
        .badge-shipped    { background: #e0f2fe; color: #0369a1; }
        .badge-pending    { background: #fef9c3; color: #a16207; }
        .badge-cancelled  { background: #fee2e2; color: #dc2626; }

        .footer { margin-top: 24px; padding: 12px 24px 0; border-top: 1px solid #e5e7eb; text-align: right; font-size: 9px; color: #9ca3af; }
    </style>
</head>
<body>

    {{-- Header --}}
    <div class="header">
        <h1>Laporan Keuangan — Basari.id</h1>
        <p>Periode: {{ $start->format('d M Y') }} sampai {{ $end->format('d M Y') }} &nbsp;|&nbsp; Dicetak: {{ now()->format('d M Y, H:i') }}</p>
    </div>

    {{-- Summary --}}
    <div class="summary">
        <div class="summary-card">
            <div class="label">Total Pendapatan</div>
            <div class="value">Rp {{ number_format($summary['revenue'], 0, ',', '.') }}</div>
            <div class="sub">dari pesanan selesai</div>
        </div>
        <div class="summary-card">
            <div class="label">Pesanan Masuk</div>
            <div class="value">{{ $summary['totalOrders'] }}</div>
            <div class="sub">tidak termasuk dibatalkan</div>
        </div>
        <div class="summary-card">
            <div class="label">Pesanan Selesai</div>
            <div class="value">{{ $summary['doneOrders'] }}</div>
            <div class="sub">status done</div>
        </div>
        <div class="summary-card">
            <div class="label">Rata-rata per Pesanan</div>
            <div class="value">Rp {{ number_format($summary['avgOrder'], 0, ',', '.') }}</div>
            <div class="sub">dari pesanan selesai</div>
        </div>
        <div class="summary-card">
            <div class="label">Total Ongkir</div>
            <div class="value">Rp {{ number_format($summary['shippingCost'], 0, ',', '.') }}</div>
            <div class="sub">pesanan selesai</div>
        </div>
    </div>

    {{-- Pendapatan per Kategori --}}
    @if(count($byCategory))
    <div class="section">
        <h2>Pendapatan per Kategori</h2>
        <table>
            <thead>
                <tr>
                    <th>Kategori</th>
                    <th class="text-right">Qty Terjual</th>
                    <th class="text-right">Revenue</th>
                </tr>
            </thead>
            <tbody>
                @foreach($byCategory as $cat)
                <tr>
                    <td>{{ $cat['category'] }}</td>
                    <td class="text-right">{{ number_format($cat['qty'], 0, ',', '.') }} pcs</td>
                    <td class="text-right">Rp {{ number_format($cat['revenue'], 0, ',', '.') }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    @endif

    {{-- Detail Transaksi --}}
    <div class="section">
        <h2>Detail Transaksi</h2>
        <table>
            <thead>
                <tr>
                    <th>No. Invoice</th>
                    <th>Tanggal</th>
                    <th>Pembeli</th>
                    <th>Produk</th>
                    <th class="text-center">Qty</th>
                    <th class="text-right">Subtotal</th>
                    <th class="text-right">Total Pesanan</th>
                    <th class="text-center">Status</th>
                </tr>
            </thead>
            <tbody>
                @forelse($orders as $order)
                    @foreach($order->items as $item)
                    <tr>
                        <td>{{ $order->invoice_number }}</td>
                        <td>{{ $order->created_at->format('d/m/Y') }}</td>
                        <td>{{ $order->user?->name ?? '-' }}</td>
                        <td>{{ $item->product_name }}</td>
                        <td class="text-center">{{ $item->quantity }}</td>
                        <td class="text-right">Rp {{ number_format($item->subtotal, 0, ',', '.') }}</td>
                        <td class="text-right">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</td>
                        <td class="text-center">
                            <span class="badge badge-{{ $order->status }}">{{ $order->status }}</span>
                        </td>
                    </tr>
                    @endforeach
                @empty
                <tr>
                    <td colspan="8" class="text-center" style="padding: 20px; color: #9ca3af;">
                        Tidak ada transaksi dalam periode ini
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="footer">
        Basari.id &nbsp;|&nbsp; Laporan ini dibuat otomatis oleh sistem
    </div>

</body>
</html>