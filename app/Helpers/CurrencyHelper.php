<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class CurrencyHelper
{
    const SUPPORTED = ['IDR', 'USD', 'MYR'];

    const FALLBACK_RATES = [
        'USD' => 0.000064,
        'MYR' => 0.000296,
        'IDR' => 1,
    ];

    public static function getRates(): array
    {
        return Cache::store('file')->remember('exchange_rates_IDR', 3600, function () {
            try {
                $response = Http::timeout(5)->get('https://open.er-api.com/v6/latest/IDR');
                if ($response->successful()) {
                    $rates = $response->json()['rates'] ?? [];
                    if (!empty($rates)) {
                        return [
                            'USD' => $rates['USD'] ?? self::FALLBACK_RATES['USD'],
                            'MYR' => $rates['MYR'] ?? self::FALLBACK_RATES['MYR'],
                            'IDR' => 1,
                        ];
                    }
                }
            } catch (\Exception $e) {
                Log::error('Exchange rate API error: ' . $e->getMessage());
            }
            return self::FALLBACK_RATES;
        });
    }

    public static function convert(float $amountIdr, string $toCurrency): float
    {
        if ($toCurrency === 'IDR') return $amountIdr;
        $rates = self::getRates();
        $rate  = $rates[$toCurrency] ?? self::FALLBACK_RATES[$toCurrency] ?? 1;
        return $amountIdr * $rate;
    }

    public static function format(float $amount, string $currency): string
    {
        return match($currency) {
            'USD' => '$ ' . number_format($amount, 2, '.', ','),
            'MYR' => 'RM ' . number_format($amount, 2, '.', ','),
            default => 'Rp ' . number_format($amount, 0, ',', '.'),
        };
    }

    public static function formatIdr(float $amount): string
    {
        return 'Rp ' . number_format($amount, 0, ',', '.');
    }

    public static function symbol(string $currency): string
    {
        return match($currency) {
            'USD' => '$',
            'MYR' => 'RM',
            default => 'Rp',
        };
    }

    public static function convertAndFormat(float $amountIdr, string $currency): string
    {
        $converted = self::convert($amountIdr, $currency);
        return self::format($converted, $currency);
    }

    public static function isValid(string $currency): bool
    {
        return in_array($currency, self::SUPPORTED);
    }
}