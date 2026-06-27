@extends('frontend.layouts.app')

@section('title', __('app.order_detail') . ' — Basari')

@section('content')

    <div class="max-w-2xl mx-auto space-y-4">
        @php
            $currency = $order->preferred_currency ?? 'IDR';
            $rates = \App\Helpers\CurrencyHelper::getRates();
            $subtotalIdr = $order->total_amount - $order->shipping_cost;
            $shippingIdr = $order->shipping_cost;

            $subtotalFmt = \App\Helpers\CurrencyHelper::convertAndFormat($subtotalIdr, $currency);
            $shippingFmt = \App\Helpers\CurrencyHelper::convertAndFormat($shippingIdr, $currency);
            $totalFmt = \App\Helpers\CurrencyHelper::convertAndFormat($order->total_amount, $currency);
        @endphp
        <div class="flex items-center gap-3">
            <a href="{{ route('orders.index') }}" class="text-gray-400 hover:text-gray-600 transition">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                </svg>
            </a>
            <h1 class="text-2xl font-bold text-gray-800">{{ __('app.order_detail') }}</h1>
        </div>

        {{-- Info Pesanan --}}
        <div class="bg-white rounded-xl border border-gray-100 p-6">
            <div class="flex justify-between items-start mb-4">
                <div>
                    <p class="font-semibold text-gray-800">{{ $order->invoice_number }}</p>
                    <p class="text-sm text-gray-400">{{ $order->created_at->format('d M Y, H:i') }}</p>
                </div>
                <span class="text-xs px-3 py-1 rounded-full
                    @if($order->status === 'pending') bg-yellow-100 text-yellow-700
                    @elseif($order->status === 'waiting_shipping_cost') bg-orange-100 text-orange-700
                    @elseif($order->status === 'paid') bg-blue-100 text-blue-700
                    @elseif($order->status === 'processing') bg-purple-100 text-purple-700
                    @elseif($order->status === 'shipped') bg-indigo-100 text-indigo-700
                    @elseif($order->status === 'done') bg-green-100 text-green-700
                    @else bg-red-100 text-red-700 @endif">
                    {{ $order->status === 'waiting_shipping_cost'
        ? (__('app.waiting_shipping_cost') ?? 'Menunggu Konfirmasi Ongkir')
        : __('app.' . $order->status) ?? ucfirst($order->status) }}
                </span>
            </div>


            {{-- Countdown Timer --}}
            @if(in_array($order->status, ['pending', 'waiting_shipping_cost']) && $order->payment_deadline)
                <div class="bg-amber-50 border border-amber-200 rounded-xl px-4 py-3 mb-4">
                    <p class="text-sm text-amber-700 font-medium mb-1">⏱ Batas Waktu Pembayaran</p>
                    <p class="text-xs text-amber-600 mb-2">Selesaikan pembayaran sebelum pesanan otomatis dibatalkan.</p>
                    <p class="text-2xl font-bold text-amber-800" id="countdown">--:--:--</p>
                </div>
                <script>
                    const deadline = new Date("{{ $order->payment_deadline->toIso8601String() }}");

                    function updateCountdown() {
                        const now = new Date();
                        const diff = deadline - now;

                        if (diff <= 0) {
                            document.getElementById('countdown').textContent = 'Waktu habis';
                            document.getElementById('countdown').classList.add('text-red-600');
                            setTimeout(() => location.reload(), 3000);
                            return;
                        }

                        const hours = Math.floor(diff / 3600000);
                        const minutes = Math.floor((diff % 3600000) / 60000);
                        const seconds = Math.floor((diff % 60000) / 1000);

                        document.getElementById('countdown').textContent =
                            String(hours).padStart(2, '0') + ':' +
                            String(minutes).padStart(2, '0') + ':' +
                            String(seconds).padStart(2, '0');
                    }

                    updateCountdown();
                    setInterval(updateCountdown, 1000);
                </script>
            @endif

            {{-- Hubungi Admin --}}
            <div class="bg-white rounded-xl border border-gray-100 p-6">
                <h2 class="font-semibold text-gray-800 mb-2">{{ __('app.contact_admin') ?? 'Ada Pertanyaan?' }}</h2>
                <p class="text-sm text-gray-400 mb-3">
                    {{ __('app.contact_admin_desc') ?? 'Hubungi admin jika ada kendala dengan pesanan ini.' }}</p>
                <form method="POST" action="{{ route('chat.start-order') }}">
                    @csrf
                    <input type="hidden" name="order_id" value="{{ $order->id }}">
                    <button type="submit" class="btn-outline w-full text-center">
                        💬 {{ __('app.contact_admin') ?? 'Hubungi Admin' }}
                    </button>
                </form>
            </div>

            <div class="border-t border-gray-100 pt-4 space-y-3">
                @foreach($order->items as $item)
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">
                            {{ $item->product_name }}
                            @if($item->size)
                                <span class="text-xs bg-blue-50 text-blue-800 px-1.5 py-0.5 rounded ml-1">{{ $item->size }}</span>
                            @endif
                            x{{ $item->quantity }}
                        </span>
                        <div class="text-right">
                            <span class="font-medium">
                                {{ \App\Helpers\CurrencyHelper::convertAndFormat($item->subtotal, $currency) }}
                            </span>
                            @if($currency !== 'IDR')
                                <p class="text-xs text-gray-400">Rp {{ number_format($item->subtotal, 0, ',', '.') }}</p>
                            @endif
                        </div>
                    </div>
                @endforeach
            </div>
            {{-- Rincian Harga --}}
            @if($order->shipping_cost > 0)
                <div class="border-t border-gray-100 pt-3 mt-3 space-y-2">
                    <div class="flex justify-between text-sm text-gray-500">
                        <span>{{ __('app.subtotal') }}</span>
                        <div class="text-right">
                            <span>{{ $subtotalFmt }}</span>
                            @if($currency !== 'IDR')
                                <p class="text-xs text-gray-400">Rp {{ number_format($subtotalIdr, 0, ',', '.') }}</p>
                            @endif
                        </div>
                    </div>
                    <div class="flex justify-between text-sm text-gray-500">
                        <span>{{ __('app.shipping_cost') }}
                            @if($order->courier)
                                ({{ strtoupper($order->courier) }} {{ $order->courier_service }})
                            @endif
                        </span>
                        <div class="text-right">
                            <span>{{ $shippingFmt }}</span>
                            @if($currency !== 'IDR')
                                <p class="text-xs text-gray-400">Rp {{ number_format($shippingIdr, 0, ',', '.') }}</p>
                            @endif
                        </div>
                    </div>
                    <div class="flex justify-between font-bold text-gray-800 text-base border-t border-gray-100 pt-2">
                        <span>{{ __('app.total') }}</span>
                        <div class="text-right">
                            <span class="text-blue-900">{{ $totalFmt }}</span>
                            @if($currency !== 'IDR')
                                <p class="text-xs text-gray-400 font-normal">≈ Rp
                                    {{ number_format($order->total_amount, 0, ',', '.') }}</p>
                                @if($order->shipping_type !== 'international')
                                    <p class="text-xs text-amber-600 font-normal">* Payment in IDR</p>
                                @endif
                            @endif
                        </div>
                    </div>
                </div>
            @else
                <div class="flex justify-between font-bold text-gray-800 border-t border-gray-100 pt-3 mt-3">
                    <span>{{ __('app.total') }}</span>
                    <div class="text-right">
                        <span class="text-blue-900">{{ $totalFmt }}</span>
                        @if($currency !== 'IDR')
                            <p class="text-xs text-gray-400 font-normal">≈ Rp {{ number_format($order->total_amount, 0, ',', '.') }}
                            </p>
                            @if($order->shipping_type !== 'international')
                                <p class="text-xs text-amber-600 font-normal">* Payment in IDR</p>
                            @endif
                        @endif
                    </div>
                </div>
            @endif

            {{-- Alamat Pengiriman --}}
            <div class="bg-white rounded-xl border border-gray-100 p-6">
                <h2 class="font-semibold text-gray-800 mb-3">{{ __('app.shipping_address') }}</h2>
                <div class="text-sm text-gray-600 space-y-1">
                    <p>{{ $order->shipping_name }}</p>
                    <p>{{ $order->shipping_address }}</p>
                    <p>{{ $order->shipping_city }}, {{ $order->shipping_postal }}</p>
                    <p>{{ $order->phone }}</p>
                </div>
            </div>

            {{-- Info Pengiriman --}}
            @if($order->courier)
                <div class="bg-white rounded-xl border border-gray-100 p-6">
                    <h2 class="font-semibold text-gray-800 mb-3">{{ __('app.shipping_info') ?? 'Info Pengiriman' }}</h2>
                    <div class="text-sm text-gray-600 space-y-2">
                        <div class="flex justify-between">
                            <span class="text-gray-400">{{ __('app.courier') }}</span>
                            <span class="font-medium">{{ strtoupper($order->courier) }} {{ $order->courier_service }}</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-400">{{ __('app.shipping_cost') }}</span>
                            <div class="text-right">
                                <span class="font-medium">{{ $shippingFmt }}</span>
                                @if($currency !== 'IDR')
                                    <p class="text-xs text-gray-400">Rp {{ number_format($shippingIdr, 0, ',', '.') }}</p>
                                @endif
                            </div>
                        </div>
                        @if($order->tracking_number)
                            <div class="flex justify-between items-center mt-2 pt-2 border-t border-gray-100">
                                <span class="text-gray-400">{{ __('app.tracking_number') ?? 'Nomor Resi' }}</span>
                                <span class="font-bold text-blue-900 text-base">{{ $order->tracking_number }}</span>
                            </div>
                        @else
                            <p class="text-xs text-gray-400 mt-2">
                                {{ __('app.tracking_not_available') ?? 'Nomor resi belum tersedia.' }}</p>
                        @endif
                    </div>
                </div>
            @endif

            {{-- Info Pengiriman Internasional --}}
            @if($order->shipping_type === 'international')
                <div class="bg-white rounded-xl border border-blue-100 p-6">
                    <div class="flex items-center gap-2 mb-3">
                        <span>🌍</span>
                        <h2 class="font-semibold text-gray-800">
                            {{ __('app.international_shipping') ?? 'Pengiriman Internasional' }}</h2>
                    </div>
                    <div class="text-sm text-gray-600 space-y-2">
                        <div class="flex justify-between">
                            <span class="text-gray-400">{{ __('app.destination_country') ?? 'Negara Tujuan' }}</span>
                            <span class="font-medium">{{ $order->destination_country }}</span>
                        </div>

                        @if($order->status === 'waiting_shipping_cost')
                            <div class="bg-orange-50 border border-orange-200 rounded-lg px-4 py-3 mt-2">
                                <p class="text-sm text-orange-700 font-medium">⏳
                                    {{ __('app.waiting_shipping_cost') ?? 'Menunggu Konfirmasi Ongkir' }}</p>
                                <p class="text-xs text-orange-600 mt-1">
                                    {{ __('app.waiting_shipping_desc') ?? 'Kami sedang menghitung ongkos kirim ke' }}
                                    {{ $order->destination_country }}.</p>
                            </div>

                        @elseif($order->intl_shipping_cost)
                            <div class="flex justify-between">
                                <span class="text-gray-400">{{ __('app.courier') }}</span>
                                <span class="font-medium">{{ $order->intl_courier }}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-400">{{ __('app.shipping_cost') }}</span>
                                <div class="text-right">
                                    <span class="font-medium">
                                        {{ \App\Helpers\CurrencyHelper::convertAndFormat($order->intl_shipping_cost, $currency) }}
                                    </span>
                                    @if($currency !== 'IDR')
                                        <p class="text-xs text-gray-400">Rp {{ number_format($order->intl_shipping_cost, 0, ',', '.') }}
                                        </p>
                                    @endif
                                </div>
                            </div>

                            @if($order->intl_tracking_number)
                                <div class="flex justify-between items-center pt-2 border-t border-gray-100">
                                    <span class="text-gray-400">{{ __('app.tracking_number') ?? 'Nomor Resi' }}</span>
                                    <span class="font-bold text-blue-900">{{ $order->intl_tracking_number }}</span>
                                </div>
                            @else
                                <p class="text-xs text-gray-400 mt-2">
                                    {{ __('app.tracking_after_shipped') ?? 'Nomor resi akan tersedia setelah paket dikirim.' }}</p>
                            @endif
                        @endif
                    </div>
                </div>
            @endif

            {{-- Tracking Real-time --}}
            @if($order->tracking_number && $order->biteship_tracking_id)
                <div class="bg-white rounded-xl border border-gray-100 p-6">
                    <h2 class="font-semibold text-gray-800 mb-3">{{ __('app.tracking') }}</h2>
                    <div id="trackingLoading" class="text-center py-4">
                        <div class="inline-block w-6 h-6 border-4 border-gray-200 border-t-blue-700 rounded-full animate-spin">
                        </div>
                        <span
                            class="text-sm text-gray-400 ml-2">{{ __('app.loading_tracking') ?? 'Memuat status pengiriman...' }}</span>
                    </div>
                    <div id="trackingContent" class="hidden">
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <p class="text-sm text-gray-500">{{ __('app.tracking_number') ?? 'Nomor Resi' }}</p>
                                <p class="font-bold text-blue-900 text-lg">{{ $order->tracking_number }}</p>
                                <p class="text-xs text-gray-400">{{ strtoupper($order->courier) }} -
                                    {{ strtoupper($order->courier_service) }}</p>
                            </div>
                            <span id="trackingStatus"
                                class="text-xs px-3 py-1 rounded-full bg-blue-100 text-blue-700 font-medium"></span>
                        </div>
                        <div id="trackingHistory" class="space-y-3 mt-4 border-t border-gray-100 pt-4"></div>
                    </div>
                    <div id="trackingError" class="hidden text-sm text-gray-400 text-center py-4">
                        {{ __('app.tracking_error') ?? 'Gagal memuat status pengiriman.' }}
                        <a href="https://track.biteship.com/{{ $order->biteship_tracking_id }}" target="_blank"
                            class="text-blue-700 hover:underline">{{ __('app.track_at_biteship') ?? 'Lacak di Biteship' }} →</a>
                    </div>
                </div>
            @endif

            {{-- Tombol Bayar --}}
            @if($order->status === 'pending')
                <div class="bg-white rounded-xl border border-gray-100 p-6">
                    <h2 class="font-semibold text-gray-800 mb-3">{{ __('app.pay_now') }}</h2>

                    <div class="bg-yellow-50 border border-yellow-200 rounded-lg px-4 py-3 mb-4">
                        <p class="text-sm text-yellow-700 font-medium">
                            {{ __('app.amount_to_pay') ?? 'Total yang harus dibayar:' }}</p>

                        @if($order->shipping_type === 'international')
                            {{-- Internasional: tampilkan dalam currency customer --}}
                            <p class="text-2xl font-bold text-yellow-800">{{ $totalFmt }}</p>
                            <p class="text-xs text-yellow-600 mt-1">≈ Rp {{ number_format($order->total_amount, 0, ',', '.') }} (IDR
                                reference)</p>
                        @else
                            {{-- Domestik: tampilkan dalam IDR --}}
                            <p class="text-2xl font-bold text-yellow-800">Rp {{ number_format($order->total_amount, 0, ',', '.') }}
                            </p>
                        @endif
                    </div>

                    @if($order->shipping_type === 'international')

                        {{-- Internasional: dua pilihan --}}
                        <p class="text-xs text-gray-500 mb-4">Choose your preferred payment method:</p>

                        {{-- PayPal --}}
                        <a href="{{ route('paypal.pay', $order->id) }}"
                            class="w-full text-center block py-3 px-4 rounded-lg font-bold text-white transition mb-3"
                            style="background-color: #0070ba;">
                            <span class="flex items-center justify-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                                    <path
                                        d="M7.076 21.337H2.47a.641.641 0 0 1-.633-.74L4.944.901C5.026.382 5.474 0 5.998 0h7.46c2.57 0 4.578.543 5.69 1.81 1.01 1.15 1.304 2.42 1.012 4.287-.023.143-.047.288-.077.437-.983 5.05-4.349 6.797-8.647 6.797h-2.19c-.524 0-.968.382-1.05.9l-1.12 7.106zm14.146-14.42a3.35 3.35 0 0 0-.607-.541c-.013.076-.026.175-.041.254-.93 4.778-4.005 7.201-9.138 7.201h-2.19a.563.563 0 0 0-.556.479l-1.187 7.527h-.506l-.24 1.516a.56.56 0 0 0 .554.647h3.882c.46 0 .85-.334.922-.788.06-.26.76-4.852.816-5.09a.932.932 0 0 1 .923-.788h.58c3.76 0 6.705-1.528 7.565-5.946.36-1.847.174-3.388-.777-4.471z" />
                                </svg>
                                Pay with PayPal
                            </span>
                        </a>

                        <div class="flex items-center gap-3 my-3">
                            <span class="flex-1 h-px bg-gray-100"></span>
                            <span class="text-xs text-gray-400">or</span>
                            <span class="flex-1 h-px bg-gray-100"></span>
                        </div>

                        {{-- iPaymu untuk kartu kredit/debit --}}
                        <a href="{{ route('payment.pay', $order->id) }}"
                            class="w-full text-center block py-3 px-4 rounded-lg font-bold text-white bg-blue-900 hover:bg-blue-800 transition">
                            <span class="flex items-center justify-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                                </svg>
                                Pay with Credit / Debit Card
                            </span>
                        </a>

                        <p class="text-xs text-gray-400 text-center mt-3">
                            PayPal — for PayPal account holders<br>
                            Credit/Debit Card — Visa, Mastercard accepted
                        </p>

                    @else

                        {{-- Domestik: iPaymu --}}
                        <p class="text-xs text-gray-400 mb-4">
                            {{ __('app.payment_hint') ?? 'Klik tombol di bawah untuk melanjutkan ke halaman pembayaran.' }}</p>
                        <a href="{{ route('payment.pay', $order->id) }}" class="btn-primary w-full text-center block">
                            {{ __('app.pay_now') }}
                        </a>

                    @endif
                </div>
            @endif
            {{-- Tombol Cancel --}}
            @if(in_array($order->status, ['pending', 'waiting_shipping_cost']))
                <div class="bg-white rounded-xl border border-gray-100 p-6">
                    <h2 class="font-semibold text-gray-800 mb-3">{{ __('app.cancel_order') }}</h2>
                    <p class="text-sm text-gray-400 mb-4">
                        {{ __('app.cancel_hint') ?? 'Pesanan masih bisa dibatalkan karena belum dilakukan pembayaran.' }}</p>
                    <form method="POST" action="{{ route('orders.cancel', $order->id) }}"
                        onsubmit="return confirm('{{ __("app.cancel_confirm") ?? "Yakin ingin membatalkan pesanan ini?" }}')">
                        @csrf @method('PATCH')
                        <button type="submit"
                            class="bg-red-50 border border-red-200 text-red-600 hover:bg-red-100 font-medium py-2 px-4 rounded-lg transition text-sm">
                            {{ __('app.cancel_order') }}
                        </button>
                    </form>
                </div>

            @elseif(in_array($order->status, ['paid', 'processing', 'shipped']))
                <div class="bg-yellow-50 border border-yellow-200 rounded-xl p-5">
                    <div class="flex items-start gap-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-500 flex-shrink-0 mt-0.5" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                        <div>
                            <p class="text-sm font-semibold text-yellow-700 mb-1">
                                {{ __('app.cannot_cancel') ?? 'Pesanan tidak dapat dibatalkan' }}</p>
                            <p class="text-xs text-yellow-600">
                                {{ __('app.cannot_cancel_desc') ?? 'Pesanan ini sudah diproses dan tidak bisa dibatalkan.' }}
                            </p>
                        </div>
                    </div>
                </div>
            @endif

            {{-- Form Review --}}
            @if($order->status === 'done')
                <div class="bg-white rounded-xl border border-gray-100 p-6">
                    <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.review') }}</h2>
                    <div class="space-y-4">
                        @foreach($order->items as $item)
                            @php $existingReview = $item->review; @endphp
                            <div class="border border-gray-100 rounded-xl p-4">
                                <div class="flex items-center gap-3 mb-3">
                                    <div class="flex-1">
                                        <p class="text-sm font-medium text-gray-800">{{ $item->product_name }}</p>
                                        @if($item->size)
                                            <span
                                                class="text-xs bg-blue-50 text-blue-800 px-1.5 py-0.5 rounded">{{ $item->size }}</span>
                                        @endif
                                    </div>
                                </div>

                                @if($existingReview)
                                    <div class="bg-gray-50 rounded-lg p-3">
                                        <div class="flex items-center gap-1 mb-1">
                                            @for($i = 1; $i <= 5; $i++)
                                                <svg class="w-4 h-4 {{ $i <= $existingReview->rating ? 'text-yellow-400' : 'text-gray-300' }}"
                                                    fill="currentColor" viewBox="0 0 20 20">
                                                    <path
                                                        d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                </svg>
                                            @endfor
                                        </div>
                                        <p class="text-sm text-gray-600">{{ $existingReview->comment ?? __('app.no_comment') }}</p>
                                        <p class="text-xs text-gray-400 mt-1">{{ $existingReview->created_at->diffForHumans() }}</p>
                                        @if($existingReview->admin_reply)
                                            <div class="mt-3 bg-blue-50 border border-blue-100 rounded-lg p-3">
                                                <p class="text-xs font-semibold text-blue-900 mb-1">{{ __('app.seller_reply') }}:</p>
                                                <p class="text-sm text-blue-800">{{ $existingReview->admin_reply }}</p>
                                                <p class="text-xs text-blue-400 mt-1">
                                                    {{ $existingReview->admin_replied_at->diffForHumans() }}</p>
                                            </div>
                                        @endif
                                    </div>
                                @else
                                    <form method="POST" action="{{ route('reviews.store') }}">
                                        @csrf
                                        <input type="hidden" name="order_item_id" value="{{ $item->id }}">
                                        <div class="mb-3">
                                            <p class="text-sm text-gray-600 mb-2">{{ __('app.rating') }}:</p>
                                            <div class="flex gap-1" id="stars-{{ $item->id }}">
                                                @for($i = 1; $i <= 5; $i++)
                                                    <label class="cursor-pointer">
                                                        <input type="radio" name="rating" value="{{ $i }}" class="hidden" required>
                                                        <svg class="w-7 h-7 text-gray-300 hover:text-yellow-400 transition star-icon"
                                                            fill="currentColor" viewBox="0 0 20 20">
                                                            <path
                                                                d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                                        </svg>
                                                    </label>
                                                @endfor
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <textarea name="comment" rows="3" class="input-field resize-none"
                                                placeholder="{{ __('app.review_placeholder') ?? 'Bagikan pengalamanmu dengan produk ini...' }}"></textarea>
                                        </div>
                                        <button type="submit" class="btn-primary text-sm px-4 py-2">
                                            {{ __('app.send_review') }}
                                        </button>
                                    </form>
                                @endif
                            </div>
                        @endforeach
                    </div>
                </div>
            @endif

        </div>

@endsection

    @push('scripts')
        @if($order->tracking_number && $order->biteship_tracking_id)
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.0/jquery.min.js"></script>
            <script>
                $(document).ready(function () {
                    $.ajax({
                        url: '/tracking/{{ $order->biteship_tracking_id }}',
                        type: 'GET',
                        success: function (data) {
                            $('#trackingLoading').addClass('hidden');
                            if (data.success !== false && data.courier) {
                                $('#trackingContent').removeClass('hidden');
                                const status = data.courier.status ?? data.status ?? 'Dalam Proses';
                                $('#trackingStatus').text(status);
                                const history = data.courier.history ?? [];
                                if (history.length > 0) {
                                    const historyHtml = [...history].reverse().map(function (h, index) {
                                        const isFirst = index === 0;
                                        const statusColors = {
                                            'delivered': { bg: '#dcfce7', dot: '#16a34a', text: '#15803d' },
                                            'dropping_off': { bg: '#eff6ff', dot: '#3b82f6', text: '#1d4ed8' },
                                            'in_transit': { bg: '#eff6ff', dot: '#3b82f6', text: '#1d4ed8' },
                                            'picked': { bg: '#f5f3ff', dot: '#7c3aed', text: '#6d28d9' },
                                            'picking_up': { bg: '#fff7ed', dot: '#f97316', text: '#c2410c' },
                                            'allocated': { bg: '#f9fafb', dot: '#6b7280', text: '#374151' },
                                            'confirmed': { bg: '#f9fafb', dot: '#6b7280', text: '#374151' },
                                            'on_hold': { bg: '#fefce8', dot: '#ca8a04', text: '#92400e' },
                                            'cancelled': { bg: '#fef2f2', dot: '#ef4444', text: '#b91c1c' },
                                        };
                                        const color = statusColors[h.status] || { bg: '#f9fafb', dot: '#6b7280', text: '#374151' };
                                        const date = h.updated_at ? new Date(h.updated_at).toLocaleString('id-ID', {
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
                                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#16a34a;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#dcfce7; color:#15803d;">Delivered</span><p class="text-sm text-gray-600 mt-1">{{ __('app.package_delivered') ?? 'Paket telah sampai di tujuan.' }}</p></div></div>`);
                                    } else if (status === 'cancelled') {
                                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#ef4444;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#fef2f2; color:#b91c1c;">Cancelled</span><p class="text-sm text-gray-600 mt-1">{{ __('app.package_cancelled') ?? 'Pengiriman paket dibatalkan.' }}</p></div></div>`);
                                    } else if (status === 'on_hold') {
                                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#ca8a04;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#fefce8; color:#92400e;">On Hold</span><p class="text-sm text-gray-600 mt-1">{{ __('app.package_on_hold') ?? 'Pengiriman paket ditahan sementara.' }}</p></div></div>`);
                                    } else if (status === 'in_transit') {
                                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#3b82f6;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#eff6ff; color:#1d4ed8;">In Transit</span><p class="text-sm text-gray-600 mt-1">{{ __('app.package_in_transit') ?? 'Paket sedang dalam perjalanan.' }}</p></div></div>`);
                                    } else if (status === 'picked') {
                                        $('#trackingHistory').html(`<div class="flex gap-4"><div class="flex-shrink-0 w-4 h-4 rounded-full mt-1" style="background:#7c3aed;"></div><div><span class="text-xs font-semibold px-2 py-0.5 rounded-full" style="background:#f5f3ff; color:#6d28d9;">Picked</span><p class="text-sm text-gray-600 mt-1">{{ __('app.package_picked') ?? 'Paket telah diambil oleh kurir.' }}</p></div></div>`);
                                    } 
                                    else {
                                        $('#trackingHistory').html('<p class="text-sm text-gray-400">{{ __("app.no_shipping_update") ?? "Belum ada update pengiriman." }}</p>');
                                    }
                                }
                            } else {
                                $('#trackingError').removeClass('hidden');
                            }
                        },
                        error: function () {
                            $('#trackingLoading').addClass('hidden');
                            $('#trackingError').removeClass('hidden');
                        }
                    });
                });
            </script>
        @endif

        @if($order->status === 'done')
            <script>
                document.querySelectorAll('[id^="stars-"]').forEach(starGroup => {
                    const labels = starGroup.querySelectorAll('label');
                    const icons = starGroup.querySelectorAll('svg');
                    let selectedIndex = -1;
                    function highlightStars(upToIndex) {
                        icons.forEach((icon, i) => {
                            if (i <= upToIndex) { icon.classList.add('text-yellow-400'); icon.classList.remove('text-gray-300'); }
                            else { icon.classList.remove('text-yellow-400'); icon.classList.add('text-gray-300'); }
                        });
                    }
                    labels.forEach((label, index) => {
                        label.addEventListener('mouseenter', () => highlightStars(index));
                        label.addEventListener('mouseleave', () => highlightStars(selectedIndex));
                        label.addEventListener('click', (e) => {
                            selectedIndex = index;
                            starGroup.querySelector(`input[value="${index + 1}"]`).checked = true;
                            highlightStars(selectedIndex);
                            e.stopPropagation();
                        });
                    });
                    starGroup.addEventListener('mouseleave', () => highlightStars(selectedIndex));
                    highlightStars(selectedIndex);
                });
            </script>
        @endif
    @endpush