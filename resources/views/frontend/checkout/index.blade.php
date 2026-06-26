@extends('frontend.layouts.app')

@section('title', __('app.checkout') . ' — Basari')

@section('content')

<h1 class="text-2xl font-bold text-gray-800 mb-6">{{ __('app.checkout') }}</h1>

<div class="grid grid-cols-1 md:grid-cols-3 gap-6">

    {{-- Form Data Diri --}}
    <div class="md:col-span-2">
        <form method="POST" action="{{ route('checkout.store') }}" class="space-y-4" id="checkoutForm">
            @csrf

            {{-- Toggle Dalam/Luar Negeri --}}
            <div class="bg-white rounded-xl border border-gray-100 p-6">
                <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.shipping_destination') ?? 'Tujuan Pengiriman' }}</h2>
                <div class="flex gap-3">
                    <label class="cursor-pointer flex-1">
                        <input type="radio" name="shipping_type" value="domestic"
                               class="hidden peer" checked onchange="toggleShippingType('domestic')">
                        <span class="block border-2 border-gray-200 rounded-xl p-3 text-center text-sm font-medium
                                     peer-checked:border-blue-700 peer-checked:text-blue-900 peer-checked:bg-blue-50
                                     hover:border-blue-400 transition">
                            🇮🇩 {{ __('app.domestic') ?? 'Dalam Negeri' }}
                        </span>
                    </label>
                    <label class="cursor-pointer flex-1">
                        <input type="radio" name="shipping_type" value="international"
                               class="hidden peer" onchange="toggleShippingType('international')">
                        <span class="block border-2 border-gray-200 rounded-xl p-3 text-center text-sm font-medium
                                     peer-checked:border-blue-700 peer-checked:text-blue-900 peer-checked:bg-blue-50
                                     hover:border-blue-400 transition">
                            🌍 {{ __('app.international') ?? 'Luar Negeri' }}
                        </span>
                    </label>
                </div>
            </div>

            <div class="bg-white rounded-xl border border-gray-100 p-6">
                <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.shipping_address') }}</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.full_name') }}</label>
                        <input type="text" name="shipping_name" value="{{ old('shipping_name', auth()->user()->name) }}"
                               class="input-field" required>
                        @error('shipping_name') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.full_address') }} <span class="text-red-500">*</span></label>
                        <textarea name="shipping_address" rows="3"
                                class="input-field resize-none" required
                                placeholder="{{ __('app.address_placeholder') ?? 'Contoh: Jl. Mawar No. 5, RT 02/RW 03, Kelurahan Sukajadi' }}">{{ old('shipping_address', auth()->user()->address) }}</textarea>
                        <p class="text-xs text-gray-400 mt-1">{{ __('app.address_hint') ?? 'Isi dengan alamat lengkap termasuk nama jalan, nomor rumah, RT/RW, dan kelurahan.' }}</p>
                        @error('shipping_address') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
                    </div>

                    {{-- Field Dalam Negeri --}}
                    <div id="domesticFields" class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.city') }} <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <input type="text" id="locationSearch" placeholder="{{ __('app.search_city') ?? 'Ketik nama kota atau kecamatan...' }}"
                                    class="input-field" oninput="searchLocation(this.value)" autocomplete="off">
                                <div id="locationSuggestions" class="hidden absolute z-10 bg-white border border-gray-200 rounded-xl shadow-lg mt-1 w-full max-h-48 overflow-y-auto"></div>
                            </div>
                            <input type="hidden" name="destination_postal_code" id="destinationPostalCode">
                            <input type="hidden" name="shipping_city" id="shippingCityName">
                            <p class="text-xs text-gray-400 mt-1" id="selectedLocationText">{{ __('app.not_selected') ?? 'Belum dipilih — wajib dipilih dari daftar' }}</p>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.postal_code') }}</label>
                            <input type="text" name="shipping_postal" value="{{ old('shipping_postal', auth()->user()->postal_code) }}"
                                   class="input-field">
                        </div>
                    </div>

                    {{-- Field Luar Negeri --}}
                    <div id="internationalFields" class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4 hidden">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.destination_country') ?? 'Negara Tujuan' }} <span class="text-red-500">*</span></label>
                            <input type="text" id="destinationCountry" 
                                placeholder="{{ __('app.select_country') ?? 'Ketik nama negara...' }}"
                                class="input-field" list="countryList" oninput="onCountryChange()">
                            <datalist id="countryList">
                            @foreach([
                                'AF' => 'Afghanistan',
                                'AU' => 'Australia',
                                'BE' => 'Belgium',
                                'BR' => 'Brazil',
                                'CA' => 'Canada',
                                'CN' => 'China',
                                'DE' => 'Germany',
                                'EG' => 'Egypt',
                                'FR' => 'France',
                                'GB' => 'United Kingdom',
                                'HK' => 'Hong Kong',
                                'IN' => 'India',
                                'IT' => 'Italy',
                                'JP' => 'Japan',
                                'KR' => 'South Korea',
                                'MX' => 'Mexico',
                                'MY' => 'Malaysia',
                                'NL' => 'Netherlands',
                                'NZ' => 'New Zealand',
                                'PH' => 'Philippines',
                                'PK' => 'Pakistan',
                                'QA' => 'Qatar',
                                'RU' => 'Russia',
                                'SA' => 'Saudi Arabia',
                                'SE' => 'Sweden',
                                'SG' => 'Singapore',
                                'TH' => 'Thailand',
                                'TR' => 'Turkey',
                                'TW' => 'Taiwan',
                                'AE' => 'United Arab Emirates',
                                'US' => 'United States',
                                'VN' => 'Vietnam',
                                'ZA' => 'South Africa',
                            ] as $code => $name)
                            <option value="{{ $name }}" data-code="{{ $code }}">
                            @endforeach
                        </datalist>
                            <input type="hidden" name="destination_country" id="destinationCountryName">
                            <input type="hidden" name="destination_country_code" id="destinationCountryCode">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.destination_postal_code') ?? 'Kode Pos Negara Tujuan' }}</label>
                            <input type="text" name="destination_postal_code_intl" id="intlPostalCode"
                                   placeholder="{{ __('app.intl_postal_placeholder') ?? 'Contoh: 098585 (Singapura)' }}" class="input-field">
                            <p class="text-xs text-gray-400 mt-1">
                                {{ __('app.intl_postal_hint') ?? 'Isi kode pos kota tujuan. Contoh: Singapura (098585), Malaysia (50480), Australia (2000).' }}
                            </p>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.phone') }}</label>
                        <input type="text" name="phone" value="{{ old('phone', auth()->user()->phone) }}"
                               class="input-field" required>
                        @error('phone') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.email') }}</label>
                        <input type="email" name="email" value="{{ old('email', auth()->user()->email) }}"
                               class="input-field" required>
                        @error('email') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ __('app.notes') }}</label>
                        <textarea name="notes" rows="2"
                                  class="input-field resize-none" placeholder="{{ __('app.notes_placeholder') ?? 'Catatan untuk penjual...' }}">{{ old('notes') }}</textarea>
                    </div>
                </div>
            </div>

            {{-- Pilih Pengiriman --}}
            <div class="bg-white rounded-xl border border-gray-100 p-6">
                <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.courier') }}</h2>

                {{-- Kurir Dalam Negeri --}}
                <div id="domesticCouriers">
                    <p class="text-xs text-gray-400">{{ __('app.shipping_auto') ?? 'Layanan pengiriman akan muncul otomatis setelah memilih lokasi tujuan.' }}</p>
                </div>

                {{-- Info Luar Negeri --}}
                <div id="internationalCouriers" class="hidden">
                    <div class="bg-blue-50 border border-blue-200 rounded-xl px-4 py-4">
                        <p class="text-sm font-medium text-blue-800 mb-1">ℹ️ {{ __('app.intl_shipping_info_title') ?? 'Informasi Pengiriman Internasional' }}</p>
                        <p class="text-xs text-blue-600">{{ __('app.intl_shipping_info') ?? 'Ongkos kirim ke luar negeri akan dihitung oleh tim kami setelah pesanan masuk. Kamu akan mendapat notifikasi dengan total tagihan sebelum melakukan pembayaran.' }}</p>
                    </div>
                </div>

                <div id="shippingServices" class="hidden space-y-2 mt-3">
                    <p class="text-sm font-medium text-gray-700 mb-2">{{ __('app.select_service') ?? 'Pilih Layanan:' }}</p>
                    <div id="serviceList" class="space-y-2"></div>
                </div>

                <div id="shippingLoading" class="hidden text-sm text-gray-400 text-center py-4">
                    {{ __('app.checking_shipping') ?? 'Mengecek ongkos kirim...' }}
                </div>

                <div id="shippingError" class="hidden bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg mt-2"></div>

                <input type="hidden" name="courier" id="selectedCourier">
                <input type="hidden" name="courier_service" id="selectedService">
                <input type="hidden" name="shipping_cost" id="selectedCost" value="0">
            </div>

            <button type="submit" id="submitBtn" class="btn-primary w-full text-center" disabled
                    style="opacity: 0.5; cursor: not-allowed;">
                {{ __('app.place_order') }}
            </button>
        </form>
    </div>

    {{-- Ringkasan Pesanan --}}
    <div class="bg-white rounded-xl border border-gray-100 p-6 h-fit">
        <h2 class="font-semibold text-gray-800 mb-4">{{ __('app.order_summary') }}</h2>
        <div class="space-y-3 mb-4">
            @foreach($cart->items as $item)
            <div class="flex justify-between text-sm">
                <span class="text-gray-600">{{ $item->product->localized_name }} x{{ $item->quantity }}</span>
                <span class="font-medium"
                    data-price-idr="{{ $item->price_at_time * $item->quantity }}"
                    data-price-usd="{{ ($item->product->price_usd ?? 0) * $item->quantity ?: '' }}"
                    data-price-myr="{{ ($item->product->price_myr ?? 0) * $item->quantity ?: '' }}">
                    Rp {{ number_format($item->price_at_time * $item->quantity, 0, ',', '.') }}
                </span>
            </div>
            @endforeach
        </div>
        <div class="flex justify-between text-sm text-gray-600 border-t border-gray-100 pt-3">
            <span>{{ __('app.subtotal') }}</span>
            <span data-price-idr="{{ $total }}"
                data-price-usd="{{ $cart->items->sum(fn($i) => ($i->product->price_usd ?? 0) * $i->quantity) ?: '' }}"
                data-price-myr="{{ $cart->items->sum(fn($i) => ($i->product->price_myr ?? 0) * $i->quantity) ?: '' }}">
                Rp {{ number_format($total, 0, ',', '.') }}
            </span>
        </div>
        <div class="flex justify-between text-sm text-gray-600 mt-2">
            <span>{{ __('app.shipping_cost') }}</span>
            <span id="shippingCostDisplay">Rp 0</span>
        </div>
        <div class="flex justify-between font-bold text-gray-800 text-lg border-t border-gray-100 pt-3 mt-3">
            <span>{{ __('app.total') }}</span>
            <span class="text-blue-900" id="grandTotalDisplay">Rp {{ number_format($total, 0, ',', '.') }}</span>
        </div>
        {{-- Keterangan konversi --}}
        <div id="currencyNote" class="hidden mt-3 bg-amber-50 border border-amber-100 text-amber-700 text-xs px-3 py-2 rounded-lg">
            @if(app()->getLocale() === 'en')
                * Product prices are shown in estimated currency. Payment will be processed in <strong>Indonesian Rupiah (IDR)</strong>.
            @else
                * Harga produk ditampilkan dalam estimasi mata uang yang dipilih. Pembayaran dilakukan dalam <strong>Rupiah (IDR)</strong>.
            @endif
        </div>
        <div id="shippingNote" class="mt-4 bg-yellow-50 border border-yellow-200 text-yellow-700 text-xs px-3 py-2 rounded-lg">
            {{ __('app.shipping_note') ?? 'Pilih tujuan dan kurir untuk melihat ongkos kirim.' }}
        </div>
    </div>

</div>

<script>
window.checkoutPage = true;

const subtotal  = {{ $total }};
const weight    = {{ $cart->items->sum(fn($item) => ($item->product->weight ?? 100) * $item->quantity) }};
const itemValue = {{ $cart->items->sum(fn($item) => $item->price_at_time * $item->quantity) }};

let currentShippingType = 'domestic';
let searchTimeout = null;
let checkoutRates = { USD: 0.000064, MYR: 0.000296, IDR: 1 };

// Load rates saat halaman dibuka
async function loadCheckoutRates() {
    try {
        const res = await fetch('https://open.er-api.com/v6/latest/IDR');
        const data = await res.json();
        if (data.rates) {
            checkoutRates = {
                USD: data.rates.USD || 0.000064,
                MYR: data.rates.MYR || 0.000296,
                IDR: 1
            };
        }
    } catch(e) {
        console.warn('Rate API gagal, pakai fallback.');
    }
}

function convertFromIdr(amountIdr, currency) {
    if (currency === 'IDR') return amountIdr;
    return amountIdr * (checkoutRates[currency] || 1);
}

function formatCheckout(amount, currency) {
    if (currency === 'USD') return '$ ' + amount.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    if (currency === 'MYR') return 'RM ' + amount.toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    return 'Rp ' + amount.toLocaleString('id-ID');
}

function updateSummaryDisplay(shippingCostIdr) {
    const currency = localStorage.getItem('basari_currency') || 'IDR';

    // Update item prices
    document.querySelectorAll('[data-price-idr]').forEach(el => {
        const idr = parseFloat(el.dataset.priceIdr) || 0;
        const converted = convertFromIdr(idr, currency);
        el.textContent = formatCheckout(converted, currency);
    });

    // Ongkir selalu IDR
    const shippingEl = document.getElementById('shippingCostDisplay');
    if (shippingCostIdr > 0) {
        shippingEl.textContent = 'Rp ' + shippingCostIdr.toLocaleString('id-ID');
    } else {
        shippingEl.textContent = currency !== 'IDR' ? 'To be confirmed' : 'Rp 0';
    }

    // Grand total
    const grandTotalEl = document.getElementById('grandTotalDisplay');
    const subtotalConverted = convertFromIdr(subtotal, currency);

    if (currency !== 'IDR') {
        if (shippingCostIdr > 0) {
            grandTotalEl.innerHTML =
                formatCheckout(subtotalConverted, currency) +
                '<span class="block text-xs text-gray-400 font-normal mt-0.5">+ Rp ' + shippingCostIdr.toLocaleString('id-ID') + ' shipping</span>' +
                '<span class="block text-xs text-amber-600 font-normal">* Payment in IDR</span>';
        } else {
            grandTotalEl.innerHTML =
                formatCheckout(subtotalConverted, currency) +
                '<span class="block text-xs text-amber-600 font-normal mt-0.5">* Payment in IDR</span>';
        }
    } else {
        grandTotalEl.textContent = 'Rp ' + (subtotal + shippingCostIdr).toLocaleString('id-ID');
    }

    // Currency note
    const note = document.getElementById('currencyNote');
    if (note) note.classList.toggle('hidden', currency === 'IDR');
}

function toggleShippingType(type) {
    currentShippingType = type;
    resetShipping();
    if (type === 'domestic') {
        document.getElementById('domesticFields').classList.remove('hidden');
        document.getElementById('internationalFields').classList.add('hidden');
        document.getElementById('domesticCouriers').classList.remove('hidden');
        document.getElementById('internationalCouriers').classList.add('hidden');
        document.getElementById('shippingNote').textContent = '{{ __("app.select_location_for_shipping") ?? "Pilih lokasi tujuan untuk melihat ongkos kirim." }}';
        document.getElementById('submitBtn').disabled = true;
        document.getElementById('submitBtn').style.opacity = '0.5';
        document.getElementById('submitBtn').style.cursor = 'not-allowed';
    } else {
        document.getElementById('domesticFields').classList.add('hidden');
        document.getElementById('internationalFields').classList.remove('hidden');
        document.getElementById('domesticCouriers').classList.add('hidden');
        document.getElementById('internationalCouriers').classList.remove('hidden');
        document.getElementById('shippingNote').textContent = '{{ __("app.intl_shipping_note") ?? "Ongkos kirim akan dikonfirmasi oleh tim kami." }}';
        document.getElementById('submitBtn').disabled = false;
        document.getElementById('submitBtn').style.opacity = '1';
        document.getElementById('submitBtn').style.cursor = 'pointer';
    }
}

async function searchLocation(keyword) {
    clearTimeout(searchTimeout);
    if (keyword.length < 3) {
        document.getElementById('locationSuggestions').classList.add('hidden');
        return;
    }
    searchTimeout = setTimeout(async () => {
        try {
            const response = await fetch(`{{ route('shipping.search') }}?keyword=${encodeURIComponent(keyword)}`);
            const areas = await response.json();
            const suggestions = document.getElementById('locationSuggestions');
            suggestions.innerHTML = '';
            if (areas.length === 0) { suggestions.classList.add('hidden'); return; }
            areas.forEach(area => {
                const div = document.createElement('div');
                div.className = 'px-4 py-2 hover:bg-blue-50 cursor-pointer text-sm text-gray-700 border-b border-gray-50 last:border-0';
                div.textContent = area.name;
                div.onclick = () => selectLocation(area);
                suggestions.appendChild(div);
            });
            suggestions.classList.remove('hidden');
        } catch(e) {}
    }, 400);
}

function selectLocation(area) {
    document.getElementById('locationSearch').value = area.name;
    document.getElementById('destinationPostalCode').value = area.postal_code;
    document.getElementById('shippingCityName').value = area.name;
    document.getElementById('selectedLocationText').textContent = '📍 ' + area.name;
    document.getElementById('locationSuggestions').classList.add('hidden');
    document.querySelector('input[name="shipping_postal"]').value = area.postal_code;
    resetShipping();
    checkShipping('jne,sicepat,jnt,pos');
}

function onCountryChange() {
    const input = document.getElementById('destinationCountry');
    const val   = input.value;
    const options = document.querySelectorAll('#countryList option');
    let code = '';
    options.forEach(opt => { if (opt.value === val) code = opt.dataset.code; });
    document.getElementById('destinationCountryCode').value = code;
    document.getElementById('destinationCountryName').value = val;
}

function resetShipping() {
    document.getElementById('shippingServices').classList.add('hidden');
    document.getElementById('shippingError').classList.add('hidden');
    document.getElementById('selectedCourier').value = '';
    document.getElementById('selectedService').value = '';
    document.getElementById('selectedCost').value = '0';
    updateSummaryDisplay(0);
    if (currentShippingType === 'domestic') {
        document.getElementById('submitBtn').disabled = true;
        document.getElementById('submitBtn').style.opacity = '0.5';
        document.getElementById('submitBtn').style.cursor = 'not-allowed';
    }
}

async function checkShipping(courier) {
    const postalCode = document.getElementById('destinationPostalCode').value;
    if (!postalCode) return;
    document.getElementById('shippingLoading').classList.remove('hidden');
    document.getElementById('shippingServices').classList.add('hidden');
    document.getElementById('shippingError').classList.add('hidden');
    try {
        const response = await fetch('{{ route("shipping.rates") }}', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': '{{ csrf_token() }}' },
            body: JSON.stringify({
                origin_postal_code: '40234',
                destination_postal_code: postalCode,
                weight: weight,
                item_value: itemValue,
                is_international: false,
                couriers: courier,
            })
        });
        const data = await response.json();
        document.getElementById('shippingLoading').classList.add('hidden');
        renderRates(data, courier);
    } catch(e) {
        document.getElementById('shippingLoading').classList.add('hidden');
        showShippingError('{{ __("app.shipping_error") ?? "Gagal mengecek ongkos kirim. Coba lagi." }}');
    }
}

function renderRates(data, courier) {
    if (!data.success || !data.rates || data.rates.length === 0) {
        showShippingError('{{ __("app.no_shipping") ?? "Layanan pengiriman tidak tersedia untuk rute ini." }}');
        return;
    }
    document.getElementById('shippingServices').classList.remove('hidden');
    const serviceList = document.getElementById('serviceList');
    serviceList.innerHTML = '';
    data.rates.forEach(rate => {
        const price = rate.price;
        const etd   = rate.shipment_duration_range || rate.etd || '-';
        const name  = rate.courier_name + ' - ' + rate.courier_service_name;
        const div = document.createElement('label');
        div.className = 'cursor-pointer';
        div.innerHTML = `
            <input type="radio" name="service_choice" value="${rate.courier_service_code}"
                   data-cost="${price}" data-courier="${rate.courier_code}"
                   class="hidden peer service-radio">
            <span class="flex justify-between items-center border-2 border-gray-200 rounded-xl px-4 py-3
                         peer-checked:border-blue-700 peer-checked:bg-blue-50 hover:border-blue-400 transition">
                <div>
                    <p class="text-sm font-medium text-gray-800">${name}</p>
                    <p class="text-xs text-gray-400">{{ __("app.estimated") ?? "Estimasi" }} ${etd} {{ __("app.working_days") ?? "hari kerja" }}</p>
                </div>
                <p class="text-sm font-bold text-blue-900">Rp ${price.toLocaleString('id-ID')}</p>
            </span>
        `;
        serviceList.appendChild(div);
    });
    document.querySelectorAll('.service-radio').forEach(radio => {
        radio.addEventListener('change', function() {
            const cost    = parseInt(this.dataset.cost);
            const courier = this.dataset.courier;
            const service = this.value;
            document.getElementById('selectedCourier').value = courier;
            document.getElementById('selectedService').value = service;
            document.getElementById('selectedCost').value    = cost;
            updateSummaryDisplay(cost);
            document.getElementById('submitBtn').disabled    = false;
            document.getElementById('submitBtn').style.opacity = '1';
            document.getElementById('submitBtn').style.cursor  = 'pointer';
        });
    });
}

function showShippingError(msg) {
    const errorDiv = document.getElementById('shippingError');
    errorDiv.textContent = msg;
    errorDiv.classList.remove('hidden');
}

document.addEventListener('DOMContentLoaded', async function() {
    // Set preferred currency ke hidden input
    const saved = localStorage.getItem('basari_currency') || 'IDR';
    const input = document.getElementById('preferredCurrencyInput');
    if (input) input.value = saved;

    // Load rates dulu baru update display
    await loadCheckoutRates();
    updateSummaryDisplay(0);

    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
        const shippingAddress = document.querySelector('textarea[name="shipping_address"]').value.trim();
        const locationSelected = document.getElementById('destinationPostalCode').value;
        const shippingCost = document.getElementById('selectedCost').value;
        if (!shippingAddress) { e.preventDefault(); alert('{{ __("app.address_required") ?? "Alamat lengkap wajib diisi." }}'); return; }
        if (shippingAddress.length < 10) { e.preventDefault(); alert('{{ __("app.address_too_short") ?? "Alamat terlalu pendek." }}'); return; }
        if (currentShippingType === 'domestic') {
            if (!locationSelected) { e.preventDefault(); alert('{{ __("app.select_city_first") ?? "Pilih kota/kecamatan tujuan terlebih dahulu." }}'); return; }
            if (!shippingCost || shippingCost === '0') { e.preventDefault(); alert('{{ __("app.select_shipping_first") ?? "Pilih layanan pengiriman terlebih dahulu." }}'); return; }
        }
        if (currentShippingType === 'international') {
            const country = document.getElementById('destinationCountry').value;
            if (!country) { e.preventDefault(); alert('{{ __("app.select_country_first") ?? "Pilih negara tujuan terlebih dahulu." }}'); return; }
        }
    });
});

document.addEventListener('click', function(e) {
    if (!e.target.closest('#locationSearch') && !e.target.closest('#locationSuggestions')) {
        document.getElementById('locationSuggestions').classList.add('hidden');
    }
});
</script>

@endsection