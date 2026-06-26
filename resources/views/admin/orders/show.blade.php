@extends('admin.layouts.app')

@section('title', 'Detail Pesanan — Basari Admin')
@section('header', 'Detail Pesanan')

@section('content')

<div class="max-w-2xl space-y-6">

    {{-- Info Pesanan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <div class="flex justify-between items-start mb-4">
            <div>
                <p class="font-semibold text-gray-800 text-lg">{{ $order->invoice_number }}</p>
                <p class="text-sm text-gray-400">{{ $order->created_at->format('d M Y, H:i') }}</p>
            </div>
            <span class="text-xs px-3 py-1 rounded-full
                @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                @elseif($order->status === 'done') bg-green-100 text-green-700
                @else bg-red-100 text-red-700 @endif">
                {{ ucfirst($order->status) }}
            </span>
        </div>

        {{-- Item Pesanan --}}
        <div class="border-t border-gray-100 pt-4 space-y-3 mb-4">
            @foreach($order->items as $item)
            <div class="flex justify-between items-start gap-4 text-sm">
                <div class="flex-1 min-w-0">
                    <p class="text-gray-600 leading-snug">{{ $item->product_name }}</p>
                    <div class="flex items-center gap-2 mt-1">
                        @if($item->size)
                        <span class="text-xs bg-blue-50 text-blue-800 px-1.5 py-0.5 rounded">{{ $item->size }}</span>
                        @endif
                        @if($item->color)
                        <span class="text-xs bg-blue-50 text-blue-800 px-1.5 py-0.5 rounded">{{ $item->color }}</span>
                        @endif
                        <span class="text-xs text-gray-400">x{{ $item->quantity }}</span>
                    </div>
                </div>
                <span class="font-medium text-gray-800 flex-shrink-0">Rp {{ number_format($item->subtotal, 0, ',', '.') }}</span>
            </div>
            @endforeach
        </div>

        <div class="flex justify-between font-bold text-gray-800 border-t border-gray-100 pt-3">
            <span>Total</span>
            <span class="text-blue-900">Rp {{ number_format($order->total_amount, 0, ',', '.') }}</span>
        </div>
    </div>

    {{-- Info Pembeli --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-3">Data Pengiriman</h2>
        <div class="text-sm text-gray-600 space-y-1">
            <p><span class="font-medium">Nama:</span> {{ $order->shipping_name }}</p>
            <p><span class="font-medium">Alamat:</span> {{ $order->shipping_address }}</p>
            <p><span class="font-medium">Kota:</span> {{ $order->shipping_city }}, {{ $order->shipping_postal }}</p>
            <p><span class="font-medium">HP:</span> {{ $order->phone }}</p>
            <p><span class="font-medium">Email:</span> {{ $order->email }}</p>
            @if($order->notes)
            <p><span class="font-medium">Catatan:</span> {{ $order->notes }}</p>
            @endif
        </div>
    </div>

    {{-- Update Status --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6">
        <h2 class="font-semibold text-gray-800 mb-3">Update Status Pesanan</h2>
        <form method="POST" action="{{ route('admin.orders.status', $order) }}" class="flex gap-3">
            @csrf @method('PATCH')
            <select name="status" class="input-field">
                <option value="pending"    {{ $order->status === 'pending'    ? 'selected' : '' }}>Pending</option>
                <option value="waiting_shipping_cost" {{ $order->status === 'waiting_shipping_cost' ? 'selected' : '' }}>Waiting Shipping Cost</option>
                <option value="paid"       {{ $order->status === 'paid'       ? 'selected' : '' }}>Paid</option>
                <option value="processing" {{ $order->status === 'processing' ? 'selected' : '' }}>Processing</option>
                <option value="shipped"    {{ $order->status === 'shipped'    ? 'selected' : '' }}>Shipped</option>
                <option value="done"       {{ $order->status === 'done'       ? 'selected' : '' }}>Done</option>
                <option value="cancelled"  {{ $order->status === 'cancelled'  ? 'selected' : '' }}>Cancelled</option>
            </select>
            <button type="submit" class="btn-primary">Update</button>
        </form>
    </div>

    {{-- Internasional: Konfirmasi Ongkir --}}
@if($order->shipping_type === 'international')
<div class="bg-white rounded-xl border border-blue-200 p-6">
    <div class="flex items-center gap-2 mb-4">
        <span class="text-lg">🌍</span>
        <h2 class="font-semibold text-gray-800">Pengiriman Internasional</h2>
        <span class="text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">
            {{ $order->destination_country }} ({{ $order->destination_country_code }})
        </span>
    </div>

    <div class="text-sm text-gray-600 space-y-1 mb-4">
        <p><span class="font-medium">Negara Tujuan:</span> {{ $order->destination_country }}</p>
        <p><span class="font-medium">Alamat:</span> {{ $order->shipping_address }}</p>
        <p><span class="font-medium">Kode Pos:</span> {{ $order->destination_postal_code }}</p>
    </div>

    @if(!$order->intl_shipping_cost)
<div class="bg-yellow-50 border border-yellow-200 rounded-lg px-4 py-3 mb-4">
    <p class="text-sm text-yellow-700 font-medium">⚠ Ongkos kirim belum dikonfirmasi</p>
    <p class="text-xs text-yellow-600 mt-1">Hitung ongkir manual via kurir pilihan, lalu input di bawah dalam IDR.</p>
    @php $preferredCurrency = $order->preferred_currency ?? 'IDR'; @endphp
    @if($preferredCurrency !== 'IDR')
    <p class="text-xs text-blue-600 mt-2">
        💡 Customer menggunakan currency <strong>{{ $preferredCurrency }}</strong> — 
        input ongkir dalam IDR, sistem akan otomatis konversi ke {{ $preferredCurrency }} untuk ditampilkan ke customer.
    </p>
    @endif
</div>

<form method="POST" action="{{ route('admin.orders.intl-shipping', $order) }}" class="space-y-3">
    @csrf
    <div class="grid grid-cols-2 gap-3">
        <div>
            <label class="block text-xs font-medium text-gray-700 mb-1">Nama Kurir</label>
            <input type="text" name="intl_courier" placeholder="Contoh: DHL, EasyParcel"
                   class="input-field" required>
        </div>
        <div>
            <label class="block text-xs font-medium text-gray-700 mb-1">Ongkos Kirim (IDR / Rp)</label>
            <input type="number" name="intl_shipping_cost" placeholder="0" min="0"
                   class="input-field" required id="intlCostInput">
            <p class="text-xs text-gray-400 mt-1" id="convertedPreview">
                Masukkan nominal dalam Rupiah
            </p>
        </div>
    </div>
    <button type="submit" class="btn-primary w-full"
            onclick="return confirm('Konfirmasi ongkir dan notifikasi pembeli?')">
        ✓ Konfirmasi Ongkir & Notifikasi Pembeli
    </button>
</form>

    @else
    {{-- Sudah dikonfirmasi ongkir --}}
    <div class="bg-green-50 border border-green-200 rounded-lg px-4 py-3 mb-4">
        <p class="text-sm text-green-700 font-medium">✓ Ongkos kirim sudah dikonfirmasi</p>
        <p class="text-xs text-green-600 mt-1">
            Kurir: <strong>{{ $order->intl_courier }}</strong> —
            Ongkir: <strong>Rp {{ number_format($order->intl_shipping_cost, 0, ',', '.') }}</strong>
        </p>
    </div>

    {{-- Input Resi --}}
    @if(in_array($order->status, ['paid', 'processing', 'shipped']))
    <div class="border-t border-gray-100 pt-4">
        <h3 class="text-sm font-medium text-gray-700 mb-3">Input Nomor Resi</h3>
        @if($order->intl_tracking_number)
        <div class="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 mb-3">
            <p class="text-xs text-blue-600">Nomor Resi:</p>
            <p class="font-bold text-blue-900">{{ $order->intl_tracking_number }}</p>
        </div>
        @endif
        <form method="POST" action="{{ route('admin.orders.intl-resi', $order) }}" class="flex gap-3">
            @csrf
            <input type="text" name="intl_tracking_number"
                   value="{{ $order->intl_tracking_number }}"
                   placeholder="Masukkan nomor resi internasional..."
                   class="input-field flex-1" required>
            <button type="submit" class="btn-primary flex-shrink-0">Simpan Resi</button>
        </form>
    </div>
    @endif
    @endif
</div>
@endif

    {{-- Request Pickup Biteship --}}
@if($order->status === 'paid' && !$order->biteship_order_id && $order->shipping_type !== 'international')
<div class="bg-white rounded-xl border border-gray-100 p-6">
    <h2 class="font-semibold text-gray-800 mb-3">Request Pickup Kurir</h2>
    <p class="text-sm text-gray-400 mb-4">
        Klik tombol di bawah untuk membuat order pengiriman di Biteship.
        Kurir akan menjemput paket dan nomor resi akan otomatis terisi.
    </p>
    <form method="POST" action="{{ route('admin.orders.biteship', $order) }}">
        @csrf
        <input type="hidden" name="order_id" value="{{ $order->id }}">
        <button type="submit" class="btn-primary"
                onclick="return confirm('Request pickup ke Biteship untuk pesanan ini?')">
            🚚 Request Pickup Biteship
        </button>
    </form>
</div>

@elseif($order->biteship_order_id && $order->shipping_type !== 'international')
<div class="bg-green-50 border border-green-200 rounded-xl p-5">
    <div class="flex items-center justify-between mb-2">
        <p class="text-sm font-semibold text-green-700">✓ Sudah terdaftar di Biteship</p>
        <form method="POST" action="{{ route('admin.orders.sync-tracking', $order) }}">
            @csrf
            <input type="hidden" name="order_id" value="{{ $order->id }}">
            <button type="submit" class="text-xs text-blue-700 hover:underline">
                🔄 Sync Tracking ID
            </button>
        </form>
            {{-- Cetak Label --}}
        <a href="https://dashboard.biteship.com/orders/details/{{ $order->biteship_order_id }}"
        target="_blank"
        class="text-xs text-green-700 hover:underline">
            🖨️ Cetak Label
        </a>
    </div>
    <p class="text-xs text-green-600">Biteship Order ID: {{ $order->biteship_order_id }}</p>
    @if($order->tracking_number)
    <p class="text-xs text-green-600 mt-1">Nomor Resi: <strong>{{ $order->tracking_number }}</strong></p>
    @endif
    @if($order->biteship_tracking_id)
    <p class="text-xs text-green-600 mt-1">Tracking ID: {{ $order->biteship_tracking_id }}</p>
    @else
    <p class="text-xs text-red-500 mt-1">⚠ Tracking ID belum tersinkron — klik Sync Tracking ID</p>
    @endif
</div>
@endif

    {{-- Tracking Real-time Admin --}}
@if($order->biteship_tracking_id)
<div class="bg-white rounded-xl border border-gray-100 p-6 mt-4">
    <h2 class="font-semibold text-gray-800 mb-3">Tracking Pengiriman</h2>

    <div id="trackingLoading" class="text-center py-4">
        <div class="inline-block w-6 h-6 border-4 border-gray-200 border-t-blue-700 rounded-full animate-spin"></div>
        <span class="text-sm text-gray-400 ml-2">Memuat status pengiriman...</span>
    </div>

    <div id="trackingContent" class="hidden">
        <div class="flex items-center justify-between mb-4">
            <div>
                <p class="text-sm text-gray-500">Nomor Resi</p>
                <p class="font-bold text-blue-900 text-lg">{{ $order->tracking_number }}</p>
                <p class="text-xs text-gray-400">{{ strtoupper($order->courier) }} - {{ strtoupper($order->courier_service) }}</p>
            </div>
            <span id="trackingStatus" class="text-xs px-3 py-1 rounded-full bg-blue-100 text-blue-700 font-medium"></span>
        </div>
        <div id="trackingHistory" class="space-y-3 mt-4 border-t border-gray-100 pt-4"></div>
    </div>

    <div id="trackingError" class="hidden text-sm text-gray-400 text-center py-4">
        Gagal memuat status pengiriman.
        <a href="https://track.biteship.com/{{ $order->biteship_tracking_id }}"
           target="_blank" class="text-blue-700 hover:underline">Lacak di Biteship →</a>
    </div>
</div>

@push('scripts')
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.0/jquery.min.js"></script>
@if($order->biteship_tracking_id)
<script>
$(document).ready(function() {
    $.ajax({
        url: '/tracking/{{ $order->biteship_tracking_id }}',
        type: 'GET',
        success: function(data) {
            $('#trackingLoading').addClass('hidden');
            if (data.success !== false && data.courier) {
                $('#trackingContent').removeClass('hidden');
                const status  = data.courier.status ?? data.status ?? 'Dalam Proses';
                $('#trackingStatus').text(status);
                const history = data.courier.history ?? [];
                if (history.length > 0) {
                    const statusColors = {
                        'delivered':    { bg: '#dcfce7', dot: '#16a34a', text: '#15803d' },
                        'dropping_off': { bg: '#eff6ff', dot: '#3b82f6', text: '#1d4ed8' },
                        'in_transit':   { bg: '#eff6ff', dot: '#3b82f6', text: '#1d4ed8' },
                        'picked':       { bg: '#f5f3ff', dot: '#7c3aed', text: '#6d28d9' },
                        'picking_up':   { bg: '#fff7ed', dot: '#f97316', text: '#c2410c' },
                        'allocated':    { bg: '#f9fafb', dot: '#6b7280', text: '#374151' },
                        'confirmed':    { bg: '#f9fafb', dot: '#6b7280', text: '#374151' },
                        'on_hold':      { bg: '#fefce8', dot: '#ca8a04', text: '#92400e' },
                        'cancelled':    { bg: '#fef2f2', dot: '#ef4444', text: '#b91c1c' },
                    };
                    const historyHtml = [...history].reverse().map(function(h, index) {
                        const isFirst = index === 0;
                        const color   = statusColors[h.status] || { bg: '#f9fafb', dot: '#6b7280', text: '#374151' };
                        const date    = h.updated_at ? new Date(h.updated_at).toLocaleString('id-ID', {
                            day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit'
                        }) : '';
                        const label = h.status.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
                        return `
                            <div class="flex gap-4 relative">
                                <div class="flex flex-col items-center flex-shrink-0">
                                    <div class="w-4 h-4 rounded-full border-2 flex-shrink-0 mt-1"
                                         style="background:${isFirst ? color.dot : '#fff'}; border-color:${color.dot};"></div>
                                    ${index < history.length - 1 ? `<div class="w-0.5 flex-1 mt-1" style="background:#e5e7eb; min-height:24px;"></div>` : ''}
                                </div>
                                <div class="pb-4 flex-1">
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-xs font-semibold px-2 py-0.5 rounded-full"
                                              style="background:${color.bg}; color:${color.text};">${label}</span>
                                        <span class="text-xs text-gray-400">${date}</span>
                                    </div>
                                    <p class="text-sm text-gray-600">${h.note ?? ''}</p>
                                </div>
                            </div>
                        `;
                    }).join('');
                    $('#trackingHistory').html(historyHtml);
                } else {
                    if (status === 'delivered') {
                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#16a34a;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#dcfce7; color:#15803d;">Delivered</span><p class="text-sm text-gray-600 mt-1">Paket telah sampai di tujuan.</p></div></div>`);
                    } else {
                        $('#trackingHistory').html('<p class="text-sm text-gray-400">Belum ada update pengiriman.</p>');
                    }
                }
            } else {
                $('#trackingError').removeClass('hidden');
            }
        },
        error: function() {
            $('#trackingLoading').addClass('hidden');
            $('#trackingError').removeClass('hidden');
        }
    });
});
</script>
@endif

{{-- Preview konversi ongkir internasional --}}
@if(($order->preferred_currency ?? 'IDR') !== 'IDR' && !$order->intl_shipping_cost)
<script>
const preferredCurrency = '{{ $order->preferred_currency }}';

fetch('https://open.er-api.com/v6/latest/IDR')
    .then(r => r.json())
    .then(data => {
        const rate   = data.rates[preferredCurrency] || 1;
        const symbol = preferredCurrency === 'USD' ? '$' : 'RM';
        const input  = document.getElementById('intlCostInput');
        const preview = document.getElementById('convertedPreview');
        if (!input || !preview) return;

        input.addEventListener('input', function() {
            const idr = parseFloat(this.value) || 0;
            if (idr === 0) {
                preview.textContent = 'Masukkan nominal dalam Rupiah';
                return;
            }
            const converted = idr * rate;
            preview.textContent = '≈ ' + symbol + ' ' + converted.toLocaleString('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }) + ' ' + preferredCurrency + ' (estimasi kurs saat ini)';
        });
    })
    .catch(() => {
        const preview = document.getElementById('convertedPreview');
        if (preview) preview.textContent = 'Preview konversi tidak tersedia';
    });
</script>
@endif
@endpush
@endif
{{-- Chat dengan Customer --}}
@php
    $orderConversation = \App\Models\Conversation::where('user_id', $order->user_id)
                                                  ->where('order_id', $order->id)
                                                  ->first();
@endphp
<div class="bg-white rounded-xl border border-gray-100 p-6">
    <div class="flex items-center justify-between">
        <div>
            <h2 class="font-semibold text-gray-800">Chat dengan Customer</h2>
            <p class="text-xs text-gray-400 mt-1">{{ $order->shipping_name }} — {{ $order->email }}</p>
        </div>
        @if($orderConversation)
        <a href="{{ route('admin.chat.show', $orderConversation->id) }}"
           class="btn-primary text-sm flex items-center gap-2">
            💬 Buka Chat
            @php $unread = $orderConversation->messages()->where('sender', 'user')->where('is_read', false)->count(); @endphp
            @if($unread > 0)
            <span class="bg-white text-blue-900 text-xs rounded-full w-5 h-5 flex items-center justify-center font-bold">
                {{ $unread }}
            </span>
            @endif
        </a>
        @else
        <form method="POST" action="{{ route('admin.chat.start-order') }}">
            @csrf
            <input type="hidden" name="order_id" value="{{ $order->id }}">
            <input type="hidden" name="user_id" value="{{ $order->user_id }}">
            <button type="submit" class="btn-outline text-sm">
                💬 Mulai Chat
            </button>
        </form>
        @endif
    </div>
</div>

    <a href="{{ route('admin.orders.index') }}" class="text-sm text-gray-400 hover:text-gray-600">← Kembali ke daftar pesanan</a>

</div>

@endsection
