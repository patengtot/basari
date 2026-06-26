<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; background: #f9fafb; margin: 0; padding: 0; }
        .container { max-width: 560px; margin: 40px auto; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .header { background: #1e3a8a; padding: 32px; text-align: center; }
        .header h1 { color: white; margin: 0; font-size: 20px; letter-spacing: 4px; font-weight: 400; }
        .body { padding: 32px; }
        .status-badge { display: inline-block; padding: 6px 16px; border-radius: 999px; background: #dbeafe; color: #1e3a8a; font-size: 13px; font-weight: 600; margin-bottom: 20px; }
        .info-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f3f4f6; font-size: 14px; }
        .info-row span:first-child { color: #6b7280; }
        .info-row span:last-child { font-weight: 600; color: #111827; }
        .btn { display: block; text-align: center; background: #1e3a8a; color: white; padding: 14px 24px; border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 600; margin-top: 24px; }
        .footer { background: #f9fafb; padding: 20px 32px; text-align: center; font-size: 12px; color: #9ca3af; }
    </style>
</head>
<body>
    <div class="container">

        <div class="header">
            <h1>BASARI.ID</h1>
        </div>

        <div class="body">
            <p style="color: #374151; font-size: 15px; margin-bottom: 8px;">
                {{ __('app.email_greeting') }}, <strong>{{ $order->shipping_name }}</strong>!
            </p>
            <p style="color: #6b7280; font-size: 14px; margin-bottom: 20px;">
                {{ __('app.email_order_updated') }}
            </p>

            <span class="status-badge">{{ $statusLabel }}</span>

            <div class="info-row">
                <span>No. Invoice</span>
                <span>{{ $order->invoice_number }}</span>
            </div>
            <div class="info-row">
                <span>{{ app()->getLocale() === 'en' ? 'Order Date' : 'Tanggal Pesanan' }}</span>
                <span>{{ $order->created_at->format('d M Y, H:i') }}</span>
            </div>
            <div class="info-row">
                <span>{{ app()->getLocale() === 'en' ? 'Total Payment' : 'Total Pembayaran' }}</span>
                <span>Rp {{ number_format($order->total_amount, 0, ',', '.') }}</span>
            </div>
            @if($order->courier)
            <div class="info-row">
                <span>{{ app()->getLocale() === 'en' ? 'Courier' : 'Kurir' }}</span>
                <span>{{ strtoupper($order->courier) }} {{ $order->courier_service }}</span>
            </div>
            @endif
            @if($order->tracking_number)
            <div class="info-row">
                <span>{{ app()->getLocale() === 'en' ? 'Tracking Number' : 'Nomor Resi' }}</span>
                <span>{{ $order->tracking_number }}</span>
            </div>
            @endif

            <p style="color: #6b7280; font-size: 13px; margin-top: 20px;">
                @if($order->status === 'paid')
                    {{ __('app.email_order_confirmed') }}
                @elseif($order->status === 'processing')
                    {{ __('app.email_order_processing') }}
                @elseif($order->status === 'shipped')
                    {{ __('app.email_order_shipped') }}
                @elseif($order->status === 'done')
                    {{ __('app.email_order_done') }}
                @elseif($order->status === 'cancelled')
                    {{ __('app.email_order_cancelled') }}
                @endif
            </p>

            <a href="{{ route('orders.show', $order->id) }}" class="btn">
                {{ __('app.email_view_order') }}
            </a>
        </div>

        <div class="footer">
            © {{ date('Y') }} Basari.id — {{ app()->getLocale() === 'en' ? 'Indonesian Women\'s Fashion' : 'Fashion Wanita Indonesia' }}<br>
            {{ __('app.email_auto_sent') }}
        </div>

    </div>
</body>
</html>