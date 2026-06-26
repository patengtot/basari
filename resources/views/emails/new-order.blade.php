<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; color: #374151; font-size: 14px; margin: 0; padding: 0; background: #f9fafb; }
        .container { max-width: 600px; margin: 30px auto; background: #fff; border-radius: 12px; overflow: hidden; border: 1px solid #e5e7eb; }
        .header { background: #1e3a5f; padding: 24px 32px; }
        .header h1 { color: #fff; margin: 0; font-size: 20px; }
        .header p { color: #93c5fd; margin: 4px 0 0; font-size: 13px; }
        .body { padding: 28px 32px; }
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .badge-orange { background: #fff7ed; color: #c2410c; }
        .badge-blue { background: #eff6ff; color: #1d4ed8; }
        table { width: 100%; border-collapse: collapse; margin-top: 16px; }
        th { text-align: left; font-size: 12px; color: #9ca3af; padding: 8px 0; border-bottom: 1px solid #f3f4f6; }
        td { padding: 10px 0; border-bottom: 1px solid #f9fafb; font-size: 13px; }
        .total-row td { font-weight: bold; font-size: 15px; color: #1e3a5f; border-top: 2px solid #e5e7eb; border-bottom: none; padding-top: 14px; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-top: 20px; }
        .info-box { background: #f9fafb; border-radius: 8px; padding: 14px 16px; }
        .info-box p { margin: 0 0 4px; font-size: 11px; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.05em; }
        .info-box span { font-size: 13px; color: #374151; font-weight: 500; }
        .btn { display: inline-block; margin-top: 24px; background: #1e3a5f; color: #fff; text-decoration: none; padding: 12px 24px; border-radius: 8px; font-size: 13px; font-weight: bold; }
        .footer { padding: 16px 32px; text-align: center; font-size: 11px; color: #9ca3af; border-top: 1px solid #f3f4f6; }
    </style>
</head>
<body>
<div class="container">

    <div class="header">
        <h1>Pesanan Baru Masuk</h1>
        <p>{{ $order->invoice_number }} — {{ $order->created_at->format('d M Y, H:i') }}</p>
    </div>

    <div class="body">

        <p style="margin-top:0;">
            @if($order->shipping_type === 'international')
            <span class="badge badge-orange">🌍 Pesanan Internasional</span>
            @else
            <span class="badge badge-blue">🇮🇩 Pesanan Domestik</span>
            @endif
        </p>

        <div class="info-grid">
            <div class="info-box">
                <p>Pembeli</p>
                <span>{{ $order->shipping_name }}</span>
            </div>
            <div class="info-box">
                <p>Nomor HP</p>
                <span>{{ $order->phone }}</span>
            </div>
            <div class="info-box">
                <p>Email</p>
                <span>{{ $order->email }}</span>
            </div>
            <div class="info-box">
                <p>Tujuan</p>
                <span>
                    @if($order->shipping_type === 'international')
                        {{ $order->destination_country }}
                    @else
                        {{ $order->shipping_city }}
                    @endif
                </span>
            </div>
        </div>

        <table style="margin-top: 24px;">
            <thead>
                <tr>
                    <th>Produk</th>
                    <th>Qty</th>
                    <th style="text-align:right;">Harga</th>
                </tr>
            </thead>
            <tbody>
                @foreach($order->items as $item)
                <tr>
                    <td>
                        {{ $item->product_name }}
                        @if($item->size)
                        <span style="font-size:11px; color:#9ca3af; margin-left:4px;">({{ $item->size }})</span>
                        @endif
                    </td>
                    <td>{{ $item->quantity }}</td>
                    <td style="text-align:right;">Rp {{ number_format($item->subtotal, 0, ',', '.') }}</td>
                </tr>
                @endforeach
                @if($order->shipping_cost > 0)
                <tr>
                    <td colspan="2" style="color:#9ca3af; font-size:12px;">Ongkos Kirim</td>
                    <td style="text-align:right; color:#9ca3af; font-size:12px;">Rp {{ number_format($order->shipping_cost, 0, ',', '.') }}</td>
                </tr>
                @endif
            </tbody>
            <tfoot>
                <tr class="total-row">
                    <td colspan="2">Total</td>
                    <td style="text-align:right;">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</td>
                </tr>
            </tfoot>
        </table>

        @if($order->shipping_type === 'international')
        <div style="background:#fff7ed; border-left:3px solid #f97316; padding:12px 16px; border-radius:4px; margin-top:20px;">
            <p style="margin:0; font-size:13px; color:#92400e; font-weight:bold;">⚠ Perlu konfirmasi ongkir internasional</p>
            <p style="margin:4px 0 0; font-size:12px; color:#b45309;">Hitung ongkir ke {{ $order->destination_country }} dan konfirmasi melalui panel admin.</p>
        </div>
        @endif

        <a href="{{ route('admin.orders.show', $order->id) }}" class="btn">
            Lihat Detail Pesanan →
        </a>

    </div>

    <div class="footer">
        Basari.id — Email otomatis, jangan dibalas langsung.
    </div>

</div>
</body>
</html>