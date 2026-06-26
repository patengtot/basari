<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Basari — Fashion Wanita')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-50 font-sans">

    {{-- Navbar --}}
    <nav id="navbar" class="fixed top-0 left-0 right-0 z-50 transition-all duration-300
        {{ Route::is('home') ? 'bg-transparent' : 'bg-white shadow-sm' }}">
        <div class="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between">

            {{-- Logo --}}
            <a href="{{ route('home') }}" id="nav-logo"
            class="font-serif text-xl tracking-[0.2em] transition-colors duration-300
            {{ Route::is('home') ? 'text-white' : 'text-gray-900' }}">
                BASARI.ID
            </a>

            {{-- Menu + Search --}}
            <div class="hidden md:flex items-center gap-6">
                <a href="{{ route('home') }}" class="nav-icon transition-colors duration-300
                   {{ Route::is('home') ? 'text-white hover:text-gray-200' : 'text-gray-600 hover:text-gray-900' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                </a>

                {{-- Dropdown Shop --}}
                <div class="relative group">
                    <button id="shopBtn" class="flex items-center gap-1 transition-colors duration-300
                        {{ Route::is('home') ? 'text-white/80 hover:text-white' : 'text-gray-600 hover:text-gray-900' }}">
                        <span class="text-xs uppercase tracking-[0.2em]">Shop</span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                    </button>
                    <div class="absolute left-0 mt-3 w-48 bg-white rounded-xl shadow-lg border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50 overflow-hidden">
                        <a href="{{ route('products.all') }}"
                        class="block px-4 py-3 text-xs uppercase tracking-widest text-gray-500 hover:bg-gray-50 hover:text-gray-900 transition border-b border-gray-100">
                            {{ __('app.all_products') }}
                        </a>
                        @foreach($navCategories ?? [] as $cat)
                        <a href="{{ route('products.category', $cat->slug) }}"
                        class="block px-4 py-3 text-xs uppercase tracking-widest text-gray-500 hover:bg-gray-50 hover:text-gray-900 transition border-b border-gray-50 last:border-0">
                            {{ $cat->localized_name }}
                        </a>
                        @endforeach
                    </div>
                </div>

                <form action="{{ route('products.search') }}" method="GET" class="relative">
                    <input id="navSearchInput" type="text" name="q" value="{{ request('q') }}"
                        placeholder="{{ __('app.search') }}"
                        class="bg-white/20 backdrop-blur-sm rounded-full px-4 py-2 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-white/50 w-48 transition focus:w-64
                        {{ Route::is('home') ? 'text-white placeholder-white/70' : 'bg-gray-100 text-gray-700 placeholder-gray-400 focus:ring-blue-400' }}">
                    <button type="submit" id="navSearchBtn" class="absolute right-3 top-1/2 -translate-y-1/2 transition-colors duration-300
                        {{ Route::is('home') ? 'text-white/70 hover:text-white' : 'text-gray-400 hover:text-blue-800' }}">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </button>
                </form>
            </div>

            {{-- Language Switcher --}}
           <div id="langSwitcher" class="flex items-center gap-1 border rounded-lg overflow-hidden transition-colors duration-300
                {{ Route::is('home') ? 'border-white/40' : 'border-gray-200' }}">
                <a href="{{ route('language.switch', 'id') }}" id="langId"
                class="px-2 py-1 text-xs font-medium transition
                {{ app()->getLocale() === 'id' 
                    ? (Route::is('home') ? 'bg-white/30 text-white' : 'bg-blue-900 text-white')
                    : (Route::is('home') ? 'text-white/70' : 'text-gray-500') }}">
                    ID
                </a>
                <a href="{{ route('language.switch', 'en') }}" id="langEn"
                class="px-2 py-1 text-xs font-medium transition
                {{ app()->getLocale() === 'en'
                    ? (Route::is('home') ? 'bg-white/30 text-white' : 'bg-blue-900 text-white')
                    : (Route::is('home') ? 'text-white/70' : 'text-gray-500') }}">
                    EN
                </a>
            </div>

            {{-- Right Side --}}
            <div class="hidden md:flex items-center gap-4">
                {{-- Currency Switcher --}}
            <div class="relative group">
                <button class="flex items-center gap-1 text-xs transition-colors duration-300
                    {{ Route::is('home') ? 'text-white/70 hover:text-white' : 'text-gray-500 hover:text-gray-900' }}">
                    <span id="currencyLabel">IDR</span>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                    </svg>
                </button>
                <div class="absolute right-0 mt-2 w-48 bg-white rounded-xl shadow-lg border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50 overflow-hidden">
                    <button onclick="setCurrency('IDR')" class="w-full text-left px-5 py-3 text-sm text-gray-700 hover:bg-gray-50 border-b border-gray-50 transition">
                        Indonesia Rupiah (IDR)
                    </button>
                    <button onclick="setCurrency('USD')" class="w-full text-left px-5 py-3 text-sm text-gray-700 hover:bg-gray-50 border-b border-gray-50 transition">
                        USD Dollar (USD)
                    </button>
                    <button onclick="setCurrency('MYR')" class="w-full text-left px-5 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                        Malaysian Ringgit (MYR)
                    </button>
                </div>
            </div>
                @auth
                @php
                    $cartCount      = auth()->user()->cart?->items->count() ?? 0;
                    $unreadNotifs   = \App\Models\Notification::where('user_id', auth()->id())->where('is_read', false)->count();
                    $unreadMessages = \App\Models\Message::whereHas('conversation', function($q) {
                        $q->where('user_id', auth()->id());
                    })->where('sender', 'admin')->where('is_read', false)->count();
                    $notifs = \App\Models\Notification::where('user_id', auth()->id())->latest()->take(10)->get();
                @endphp

            
                {{-- Keranjang --}}
                <a href="{{ route('cart.index') }}" class="relative nav-icon transition-colors duration-300
                   {{ Route::is('home') ? 'text-white hover:text-gray-200' : 'text-gray-600 hover:text-gray-900' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    @if($cartCount > 0)
                    <span class="absolute -top-2 -right-2 bg-blue-900 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">
                        {{ $cartCount }}
                    </span>
                    @endif
                </a>

                {{-- Notifikasi --}}
                <div class="relative group">
                    <button class="relative nav-icon transition-colors duration-300
                        {{ Route::is('home') ? 'text-white hover:text-gray-200' : 'text-gray-600 hover:text-gray-900' }}">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
                        </svg>
                        @if($unreadNotifs > 0)
                        <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">
                            {{ $unreadNotifs > 9 ? '9+' : $unreadNotifs }}
                        </span>
                        @endif
                    </button>

                    <div class="absolute right-0 mt-2 w-80 bg-white rounded-xl shadow-lg border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50">
                        <div class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                            <p class="font-semibold text-gray-800 text-sm">{{ __('app.notifications') }}</p>
                            <div class="flex items-center gap-3">
                                @if($unreadNotifs > 0)
                                <form method="POST" action="{{ route('notifications.readAll') }}">
                                    @csrf
                                    <button type="submit" class="text-xs text-blue-700 hover:underline">{{ __('app.mark_read') }}</button>
                                </form>
                                @endif
                                <form method="POST" action="{{ route('notifications.deleteAll') }}"
                                      onsubmit="return confirm('{{ __('app.confirm_delete_notif') }}')">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="text-xs text-red-500 hover:underline">{{ __('app.delete_all') }}</button>
                                </form>
                            </div>
                        </div>
                        <div class="max-h-72 overflow-y-auto">
                            @forelse($notifs as $notif)
                            <div class="flex items-start gap-2 px-4 py-3 hover:bg-gray-50 transition border-b border-gray-50 {{ $notif->is_read ? 'opacity-60' : '' }}">
                                <a href="{{ route('notifications.read', $notif->id) }}" class="flex gap-2 flex-1 min-w-0">
                                    <div class="w-2 h-2 rounded-full mt-2 flex-shrink-0 {{ $notif->is_read ? 'bg-gray-300' : 'bg-blue-900' }}"></div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-gray-800">{{ $notif->title }}</p>
                                        <p class="text-xs text-gray-500 mt-0.5 line-clamp-2">{{ $notif->message }}</p>
                                        <p class="text-xs text-gray-300 mt-1">{{ $notif->created_at->diffForHumans() }}</p>
                                    </div>
                                </a>
                                <form method="POST" action="{{ route('notifications.delete', $notif->id) }}">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="text-gray-300 hover:text-red-500 transition flex-shrink-0 mt-1">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                        </svg>
                                    </button>
                                </form>
                            </div>
                            @empty
                            <div class="px-4 py-6 text-center text-gray-400 text-xs">{{ __('app.no_notifications') }}</div>
                            @endforelse
                        </div>
                    </div>
                </div>

                {{-- User Dropdown --}}
                <div class="relative group">
                    <button id="userDropdownBtn" class="flex items-center gap-1 text-sm transition-colors duration-300
                        {{ Route::is('home') ? 'text-white hover:text-gray-200' : 'text-gray-600 hover:text-gray-900' }}">
                        {{ auth()->user()->name }}
                        @if($unreadMessages > 0)
                        <span class="bg-red-500 text-white text-xs rounded-full px-1.5 py-0.5 min-w-[18px] text-center">
                            {{ $unreadMessages > 9 ? '9+' : $unreadMessages }}
                        </span>
                        @endif
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                    </button>
                    <div class="absolute right-0 mt-2 w-44 bg-white rounded-lg shadow-lg border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50">
                        <a href="{{ route('profile.index') }}" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">{{ __('app.my_profile') }}</a>
                        <a href="{{ route('orders.index') }}" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">{{ __('app.my_orders') }}</a>
                        <a href="{{ route('chat.index') }}" class="flex items-center justify-between px-4 py-2 text-sm text-gray-700 hover:bg-gray-50">
                            <span>{{ __('app.my_messages') }}</span>
                            @if($unreadMessages > 0)
                            <span class="bg-red-500 text-white text-xs rounded-full px-1.5 py-0.5 min-w-[18px] text-center">
                                {{ $unreadMessages > 9 ? '9+' : $unreadMessages }}
                            </span>
                            @endif
                        </a>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-50">
                                {{ __('app.logout') }}
                            </button>
                        </form>
                    </div>
                </div>

                @else
                <a href="{{ route('login') }}" class="text-sm transition-colors duration-300
                {{ Route::is('home') ? 'text-white border border-white/70 rounded-lg px-3 py-1.5 hover:bg-white/10' : 'text-gray-700 border border-gray-300 rounded-lg px-3 py-1.5 hover:bg-gray-50' }}">
                {{ __('app.login') }}
                </a>
                <a href="{{ route('register') }}" class="text-sm transition-colors duration-300
                {{ Route::is('home') ? 'text-white border border-white rounded-lg px-3 py-1.5 hover:bg-white/10' : 'btn-primary' }}">
                {{ __('app.register') }}
                </a>
                @endauth
            </div>

            {{-- Mobile: Hamburger + Cart --}}
            <div class="flex md:hidden items-center gap-3">
                @auth
                @php $cartCountMobile = auth()->user()->cart?->items->count() ?? 0; @endphp
                <a href="{{ route('cart.index') }}" id="mobileCartBtn" class="relative transition-colors duration-300
                    {{ Route::is('home') ? 'text-white' : 'text-gray-600' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    @if($cartCountMobile > 0)
                    <span class="absolute -top-2 -right-2 bg-blue-900 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">{{ $cartCountMobile }}</span>
                    @endif
                </a>
                @endauth

                <button id="mobileMenuBtn" class="transition-colors duration-300
                    {{ Route::is('home') ? 'text-white' : 'text-gray-700' }}">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
            </div>
        </div>
    </nav>

    {{-- Mobile Drawer --}}
<div id="mobileDrawer" class="fixed inset-0 z-50 hidden">
    <div class="absolute inset-0 bg-black/40" onclick="closeMobileMenu()"></div>
    <div class="absolute top-0 right-0 h-full w-72 bg-white shadow-xl flex flex-col overflow-y-auto">

        {{-- Header --}}
        <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
            <p class="font-serif text-lg tracking-[0.2em] text-gray-900">BASARI.ID</p>
            <button onclick="closeMobileMenu()" class="text-gray-400 hover:text-gray-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <div class="flex-1 px-5 py-4 space-y-1">

            {{-- Search --}}
            <form action="{{ route('products.search') }}" method="GET" class="mb-4">
                <div class="relative">
                    <input type="text" name="q" placeholder="{{ __('app.search') }}"
                        class="w-full bg-gray-100 rounded-full px-4 py-2 pr-10 text-sm focus:outline-none text-gray-700 placeholder-gray-400">
                    <button type="submit" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </button>
                </div>
            </form>

            {{-- Language --}}
            <div class="flex items-center gap-2 py-2 border-b border-gray-50">
                <span class="text-xs text-gray-400 uppercase tracking-widest">{{ __('app.language') }}</span>
                <div class="flex gap-1 border border-gray-200 rounded-lg overflow-hidden ml-auto">
                    <a href="{{ route('language.switch', 'id') }}"
                       class="px-3 py-1.5 text-xs font-medium transition {{ app()->getLocale() === 'id' ? 'bg-blue-900 text-white' : 'text-gray-500 hover:bg-gray-50' }}">ID</a>
                    <a href="{{ route('language.switch', 'en') }}"
                       class="px-3 py-1.5 text-xs font-medium transition {{ app()->getLocale() === 'en' ? 'bg-blue-900 text-white' : 'text-gray-500 hover:bg-gray-50' }}">EN</a>
                </div>
            </div>

            <div class="border-t border-gray-100 my-2"></div>

            {{-- Shop Mobile --}}
            <div class="border-b border-gray-100">
                <button onclick="toggleShopMenu()" class="w-full flex items-center justify-between py-3">
                    <span class="text-xs uppercase tracking-widest text-gray-700 font-medium">Shop</span>
                    <svg id="shopArrow" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 transition-transform duration-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                    </svg>
                </button>
                <div id="shopMenu" class="hidden pb-1">
                    <a href="{{ route('products.all') }}"
                    class="block py-2.5 px-3 text-sm text-gray-600 hover:text-gray-900 border-t border-gray-50 transition"
                    onclick="closeMobileMenu()">
                        {{ __('app.all_products') }}
                    </a>
                    @foreach($navCategories ?? [] as $cat)
                    <a href="{{ route('products.category', $cat->slug) }}"
                    class="block py-2.5 px-3 text-sm text-gray-600 hover:text-gray-900 border-t border-gray-50 transition"
                    onclick="closeMobileMenu()">
                        {{ $cat->localized_name }}
                    </a>
                    @endforeach
                </div>
            </div>
            {{-- Currency --}}
            <div class="py-3 border-b border-gray-50">
                <p class="text-xs text-gray-400 uppercase tracking-widest mb-2">{{ __('app.currency') }}</p>
                <div class="flex gap-2">
                    <button onclick="setCurrency('IDR'); closeMobileMenu()" id="mobileCurrIDR"
                        class="flex-1 py-2 text-xs border border-gray-200 rounded-lg transition">IDR</button>
                    <button onclick="setCurrency('USD'); closeMobileMenu()" id="mobileCurrUSD"
                        class="flex-1 py-2 text-xs border border-gray-200 rounded-lg transition">USD</button>
                    <button onclick="setCurrency('MYR'); closeMobileMenu()" id="mobileCurrMYR"
                        class="flex-1 py-2 text-xs border border-gray-200 rounded-lg transition">MYR</button>
                </div>
            </div>

            @auth
            <a href="{{ route('profile.index') }}" class="flex items-center gap-3 py-3 text-sm text-gray-700 hover:text-gray-900 border-b border-gray-50">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
                {{ __('app.my_profile') }}
            </a>
            <a href="{{ route('orders.index') }}" class="flex items-center gap-3 py-3 text-sm text-gray-700 hover:text-gray-900 border-b border-gray-50">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                </svg>
                {{ __('app.my_orders') }}
            </a>
            <a href="{{ route('chat.index') }}" class="flex items-center gap-3 py-3 text-sm text-gray-700 hover:text-gray-900 border-b border-gray-50">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                </svg>
                {{ __('app.my_messages') }}
                @php
                    $mobileUnreadMsg = \App\Models\Message::whereHas('conversation', function($q) {
                        $q->where('user_id', auth()->id());
                    })->where('sender', 'admin')->where('is_read', false)->count();
                @endphp
                @if($mobileUnreadMsg > 0)
                <span class="ml-auto bg-red-500 text-white text-xs rounded-full px-1.5 py-0.5">{{ $mobileUnreadMsg }}</span>
                @endif
            </a>

            {{-- Notifikasi mobile --}}
            <div class="flex items-center gap-3 py-3 text-sm text-gray-700 border-b border-gray-50 cursor-pointer"
                onclick="document.getElementById('mobileNotifModal').classList.remove('hidden'); closeMobileMenu();">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
                </svg>
                Notifikasi
                @php $mobileUnreadNotifs = \App\Models\Notification::where('user_id', auth()->id())->where('is_read', false)->count(); @endphp
                @if($mobileUnreadNotifs > 0)
                <span class="ml-auto bg-red-500 text-white text-xs rounded-full px-1.5 py-0.5">{{ $mobileUnreadNotifs }}</span>
                @endif
            </div>
            <div class="pt-2">
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="w-full text-left flex items-center gap-3 py-3 text-sm text-red-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                        {{ __('app.logout') }}
                    </button>
                </form>
            </div>

            @else
            <a href="{{ route('login') }}" class="block w-full text-center py-2.5 text-sm border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition mb-2">
                {{ __('app.login') }}
            </a>
            <a href="{{ route('register') }}" class="block w-full text-center py-2.5 text-sm bg-blue-900 text-white rounded-lg hover:bg-blue-800 transition">
                {{ __('app.register') }}
            </a>
            @endauth
        </div>
    </div>
</div>

{{-- Modal Notifikasi Mobile --}}
@auth
<div id="mobileNotifModal" class="hidden fixed inset-0 z-50 flex items-end">
    <div class="absolute inset-0 bg-black/40" onclick="document.getElementById('mobileNotifModal').classList.add('hidden')"></div>
    <div class="relative w-full bg-white rounded-t-2xl shadow-xl max-h-[80vh] flex flex-col">
        <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
            <p class="font-semibold text-gray-800 text-sm">{{ __('app.notifications') }}</p>
            <div class="flex items-center gap-3">
                @php
                    $mobileNotifs = \App\Models\Notification::where('user_id', auth()->id())->latest()->take(10)->get();
                    $mobileUnread = \App\Models\Notification::where('user_id', auth()->id())->where('is_read', false)->count();
                @endphp
                @if($mobileUnread > 0)
                <form method="POST" action="{{ route('notifications.readAll') }}">
                    @csrf
                    <button type="submit" class="text-xs text-blue-700 hover:underline">{{ __('app.mark_read') }}</button>
                </form>
                @endif
                <button onclick="document.getElementById('mobileNotifModal').classList.add('hidden')"
                    class="text-gray-400 hover:text-gray-600">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
        </div>
        <div class="overflow-y-auto flex-1">
            @forelse($mobileNotifs as $notif)
            <div class="flex items-start gap-3 px-5 py-4 border-b border-gray-50 {{ $notif->is_read ? 'opacity-60' : '' }}">
                <a href="{{ route('notifications.read', $notif->id) }}" class="flex gap-3 flex-1 min-w-0">
                    <div class="w-2 h-2 rounded-full mt-2 flex-shrink-0 {{ $notif->is_read ? 'bg-gray-300' : 'bg-blue-900' }}"></div>
                    <div class="flex-1 min-w-0">
                        <p class="text-sm font-semibold text-gray-800">{{ $notif->title }}</p>
                        <p class="text-xs text-gray-500 mt-0.5">{{ $notif->message }}</p>
                        <p class="text-xs text-gray-300 mt-1">{{ $notif->created_at->diffForHumans() }}</p>
                    </div>
                </a>
            </div>
            @empty
            <div class="px-5 py-8 text-center text-gray-400 text-xs">{{ __('app.no_notifications') }}</div>
            @endforelse
        </div>
    </div>
</div>
@endauth

    {{-- Spacer untuk halaman non-home agar konten tidak tertutup navbar fixed --}}
    @if(!Route::is('home'))
    <div class="h-16"></div>
    @endif

    {{-- Flash Message --}}
    @if(session('success'))
    <div class="max-w-6xl mx-auto px-4 mt-4">
        <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg text-sm">
            {{ session('success') }}
        </div>
    </div>
    @endif

    @if(session('error'))
    <div class="max-w-6xl mx-auto px-4 mt-4">
        <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
            {{ session('error') }}
        </div>
    </div>
    @endif

    {{-- Main Content --}}
    @hasSection('fullwidth')
    <main class="min-h-[calc(100vh-140px)]">
        @yield('content')
    </main>
    @else
    <main class="max-w-6xl mx-auto px-4 py-6 min-h-[calc(100vh-140px)]">
        @yield('content')
    </main>
    @endif

    {{-- Footer --}}
<footer class="bg-white border-t border-gray-100 mt-20">
    <div class="max-w-6xl mx-auto px-8 py-16">

        <div class="grid grid-cols-1 md:grid-cols-3 gap-10 mb-14">

            {{-- Informations --}}
            <div>
                <p class="text-xs uppercase tracking-[0.1em] text-gray-900 font-medium mb-5">{{ __('app.footer_informations') }}</p>
                <div class="space-y-3">
                    <a href="{{ route('info.payment') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_payment_method') }}</a>
                    <a href="{{ route('info.shipping') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_shipping_info') }}</a>
                    <a href="{{ route('info.return') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_return_exchange') }}</a>
                    <a href="{{ route('info.faq') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_faq') }}</a>
                    <a href="{{ route('info.how-to-order') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_how_to_order') }}</a>
                    <a href="{{ route('tracking.page') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_track_order') }}</a>
                </div>
            </div>

            {{-- Contact --}}
            <div>
                <p class="text-xs uppercase tracking-[0.1em] text-gray-900 font-medium mb-5">{{ __('app.footer_contact') }}</p>
                <div class="space-y-3">
                    <a href="{{ route('kontak') }}" class="block text-xs text-gray-400 hover:text-gray-900 transition">{{ __('app.footer_contact_us') }}</a>
                    <a href="https://wa.me/6282120755736" target="_blank" class="block text-xs text-gray-400 hover:text-gray-900 transition">WhatsApp</a>
                    <a href="https://instagram.com/basari.id" target="_blank" class="block text-xs text-gray-400 hover:text-gray-900 transition">Instagram</a>
                </div>
            </div>

            {{-- Basari.id --}}
            <div>
                <p class="font-serif text-lg tracking-[0.3em] text-gray-900 mb-4">BASARI.ID</p>
                <p class="text-xs tracking-[0.15em] text-gray-400 mb-5">{{ __('app.footer_tagline') }}</p>
            </div>

        </div>

        {{-- Bottom --}}
        <div class="pt-8 border-t border-gray-100 text-center">
            <p class="text-xs tracking-[0.2em] text-gray-300">© {{ date('Y') }} BASARI.ID</p>
        </div>

    </div>
</footer>
    @stack('scripts')
    {{-- Floating WhatsApp Button --}}
    <a href="https://wa.me/6282120755736?text=Halo%20Basari%2C%20saya%20ingin%20bertanya%20tentang%20produk"
        target="_blank"
        style="background-color: #25D366;"
        class="fixed z-50 text-white rounded-full w-14 h-14 flex items-center justify-center shadow-lg transition group
                {{ auth()->check() ? 'bottom-24 right-6' : 'bottom-6 right-6' }}"
        onmouseover="this.style.backgroundColor='#1ebe57'"
        onmouseout="this.style.backgroundColor='#25D366'">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="currentColor" viewBox="0 0 24 24">
            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
        </svg>
        <span class="absolute right-16 bg-gray-800 text-white text-xs px-3 py-1.5 rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition pointer-events-none">
            💬 Chat WhatsApp
        </span>
    </a>

    {{-- Floating Chat Button --}}
    @auth
    @php
        $unreadChat = \App\Models\Conversation::where('user_id', Auth::id())
                        ->with(['messages' => fn($q) => $q->where('sender', 'admin')->where('is_read', false)])
                        ->get()
                        ->sum(fn($c) => $c->messages->count());
    @endphp
    <a href="{{ route('chat.index') }}"
    class="fixed bottom-6 right-6 z-50 bg-blue-900 hover:bg-blue-800 text-white rounded-full w-14 h-14 flex items-center justify-center shadow-lg transition group">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
        </svg>
        @if($unreadChat > 0)
        <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full min-w-[20px] h-5 flex items-center justify-center font-bold px-1">
            {{ $unreadChat > 9 ? '9+' : $unreadChat }}
        </span>
        @endif
        <span class="absolute right-16 bg-gray-800 text-white text-xs px-3 py-1.5 rounded-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition pointer-events-none">
            💬 Chat dengan Kami
        </span>
    </a>
    @endauth

    {{-- Navbar Scroll Script --}}
    @if(Route::is('home'))
<script>
    const navbar       = document.getElementById('navbar');
    const logo         = document.getElementById('nav-logo');
    const icons        = document.querySelectorAll('.nav-icon');
    const userBtn      = document.getElementById('userDropdownBtn');
    const searchInput  = document.getElementById('navSearchInput');
    const searchBtn    = document.getElementById('navSearchBtn');
    const langSwitcher = document.getElementById('langSwitcher');
    const langId       = document.getElementById('langId');
    const langEn       = document.getElementById('langEn');
    const loginBtn     = document.querySelector('a[href*="login"]');
    const registerBtn  = document.querySelector('a[href*="register"]');
    const currencyBtn  = document.getElementById('currencyLabel')?.parentElement;
    const mobileBtn    = document.getElementById('mobileMenuBtn');
    const mobileCart   = document.getElementById('mobileCartBtn');
    const shopBtn = document.getElementById('shopBtn');

    function updateNavbar() {
        if (window.scrollY > 80) {
            navbar.classList.remove('bg-transparent');
            navbar.classList.add('bg-white', 'shadow-sm');
            logo.classList.remove('text-white');
            logo.classList.add('text-gray-900');
            icons.forEach(el => {
                el.classList.remove('text-white', 'hover:text-gray-200');
                el.classList.add('text-gray-600', 'hover:text-gray-900');
            });
            if (userBtn) { userBtn.classList.remove('text-white', 'hover:text-gray-200'); userBtn.classList.add('text-gray-600', 'hover:text-gray-900'); }
            if (searchInput) { searchInput.classList.remove('text-white', 'placeholder-white/70', 'bg-white/20'); searchInput.classList.add('text-gray-700', 'placeholder-gray-400', 'bg-gray-100'); }
            if (searchBtn) { searchBtn.classList.remove('text-white/70', 'hover:text-white'); searchBtn.classList.add('text-gray-400', 'hover:text-blue-800'); }
            if (langSwitcher) { langSwitcher.classList.remove('border-white/40'); langSwitcher.classList.add('border-gray-200'); }
            if (langId) {
                if (langId.classList.contains('bg-white') || langId.classList.contains('bg-white/30')) {
                    langId.classList.remove('bg-white', 'bg-white/30', 'text-blue-900', 'text-white');
                    langId.classList.add('bg-blue-900', 'text-white');
                } else {
                    langId.classList.remove('text-white/70');
                    langId.classList.add('text-gray-500');
                }
            }
            if (langEn) {
                if (langEn.classList.contains('bg-white') || langEn.classList.contains('bg-white/30')) {
                    langEn.classList.remove('bg-white', 'bg-white/30', 'text-blue-900', 'text-white');
                    langEn.classList.add('bg-blue-900', 'text-white');
                } else {
                    langEn.classList.remove('text-white/70');
                    langEn.classList.add('text-gray-500');
                }
            }
            if (loginBtn) { loginBtn.classList.remove('text-white', 'border-white/70', 'hover:bg-white/10'); loginBtn.classList.add('text-gray-700', 'border-gray-300', 'hover:bg-gray-50'); }
            if (registerBtn) { registerBtn.classList.remove('text-white', 'border-white', 'hover:bg-white/10'); registerBtn.classList.add('btn-primary'); }
            if (currencyBtn) { currencyBtn.classList.remove('text-white/70', 'hover:text-white'); currencyBtn.classList.add('text-gray-500', 'hover:text-gray-900'); }
            if (mobileBtn) { mobileBtn.classList.remove('text-white'); mobileBtn.classList.add('text-gray-700'); }
            if (mobileCart) { mobileCart.classList.remove('text-white'); mobileCart.classList.add('text-gray-600'); }
            if (shopBtn) { shopBtn.classList.remove('text-white/80', 'hover:text-white'); shopBtn.classList.add('text-gray-600', 'hover:text-gray-900'); }
        } else {
            navbar.classList.add('bg-transparent');
            navbar.classList.remove('bg-white', 'shadow-sm');
            logo.classList.add('text-white');
            logo.classList.remove('text-gray-900');
            icons.forEach(el => {
                el.classList.add('text-white', 'hover:text-gray-200');
                el.classList.remove('text-gray-600', 'hover:text-gray-900');
            });
            if (userBtn) { userBtn.classList.add('text-white', 'hover:text-gray-200'); userBtn.classList.remove('text-gray-600', 'hover:text-gray-900'); }
            if (searchInput) { searchInput.classList.add('text-white', 'placeholder-white/70', 'bg-white/20'); searchInput.classList.remove('text-gray-700', 'placeholder-gray-400', 'bg-gray-100'); }
            if (searchBtn) { searchBtn.classList.add('text-white/70', 'hover:text-white'); searchBtn.classList.remove('text-gray-400', 'hover:text-blue-800'); }
            if (langSwitcher) { langSwitcher.classList.add('border-white/40'); langSwitcher.classList.remove('border-gray-200'); }
            if (langId) {
                if (langId.classList.contains('bg-blue-900')) {
                    langId.classList.remove('bg-blue-900', 'text-white');
                    langId.classList.add('bg-white/30', 'text-white');
                } else {
                    langId.classList.remove('text-gray-500');
                    langId.classList.add('text-white/70');
                }
            }
            if (langEn) {
                if (langEn.classList.contains('bg-blue-900')) {
                    langEn.classList.remove('bg-blue-900', 'text-white');
                    langEn.classList.add('bg-white/30', 'text-white');
                } else {
                    langEn.classList.remove('text-gray-500');
                    langEn.classList.add('text-white/70');
                }
            }
            if (loginBtn) { loginBtn.classList.add('text-white', 'border-white/70', 'hover:bg-white/10'); loginBtn.classList.remove('text-gray-700', 'border-gray-300', 'hover:bg-gray-50'); }
            if (registerBtn) { registerBtn.classList.add('text-white', 'border-white', 'hover:bg-white/10'); registerBtn.classList.remove('btn-primary'); }
            if (currencyBtn) { currencyBtn.classList.remove('text-gray-500', 'hover:text-gray-900'); currencyBtn.classList.add('text-white/70', 'hover:text-white'); }
            if (mobileBtn) { mobileBtn.classList.remove('text-gray-700'); mobileBtn.classList.add('text-white'); }
            if (mobileCart) { mobileCart.classList.remove('text-gray-600'); mobileCart.classList.add('text-white'); }
            if (shopBtn) { shopBtn.classList.remove('text-gray-600', 'hover:text-gray-900'); shopBtn.classList.add('text-white/80', 'hover:text-white'); }
        }
    }

    window.addEventListener('scroll', updateNavbar);
    updateNavbar();
</script>
 @endif
</script>

    {{-- Currency Script --}}
    <script>
// Fetch rate dari API sekali, simpan di memory
let exchangeRates = { USD: 0.000064, MYR: 0.000296, IDR: 1 };
let ratesLoaded = false;

async function loadRates() {
    if (ratesLoaded) return;
    try {
        const res = await fetch('https://open.er-api.com/v6/latest/IDR');
        const data = await res.json();
        if (data.rates) {
            exchangeRates = {
                USD: data.rates.USD || 0.000064,
                MYR: data.rates.MYR || 0.000296,
                IDR: 1
            };
            ratesLoaded = true;
        }
    } catch(e) {
        console.warn('Exchange rate API gagal, pakai fallback rate.');
    }
}

function convertFromIdr(amountIdr, currency) {
    if (currency === 'IDR') return amountIdr;
    return amountIdr * (exchangeRates[currency] || 1);
}

function formatCurrency(amount, currency) {
    if (currency === 'USD') return '$ ' + amount.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    if (currency === 'MYR') return 'RM ' + amount.toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    return 'Rp ' + amount.toLocaleString('id-ID');
}

function setCurrency(currency) {
    localStorage.setItem('basari_currency', currency);
    const label = document.getElementById('currencyLabel');
    if (label) label.textContent = currency;

    // Sync ke Laravel session
    fetch('/currency/set', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ currency })
    });

    updateAllPrices();
}

async function updateAllPrices() {
    // Skip kalau di halaman checkout — dihandle sendiri
    if (window.checkoutPage) {
        const note = document.getElementById('currencyNote');
        if (note) note.classList.toggle('hidden', (localStorage.getItem('basari_currency') || 'IDR') === 'IDR');
        return;
    }

    await loadRates();

    const currency = localStorage.getItem('basari_currency') || 'IDR';
    const label = document.getElementById('currencyLabel');
    if (label) label.textContent = currency;

    document.querySelectorAll('[data-price-idr]').forEach(el => {
        const idr = parseFloat(el.dataset.priceIdr) || 0;
        const converted = convertFromIdr(idr, currency);
        el.textContent = formatCurrency(converted, currency);
    });

    // Show/hide currency note
    const note = document.getElementById('currencyNote');
    if (note) note.classList.toggle('hidden', currency === 'IDR');
}

document.addEventListener('DOMContentLoaded', async function() {
    const saved = localStorage.getItem('basari_currency') || 'IDR';
    const label = document.getElementById('currencyLabel');
    if (label) label.textContent = saved;

    // Sync ke session saat halaman dibuka
    if (saved !== 'IDR') {
        fetch('/currency/set', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            body: JSON.stringify({ currency: saved })
        });
    }

    await updateAllPrices();
});
</script>
{{-- Mobile Menu Script --}}
<script>
function openMobileMenu() {
    document.getElementById('mobileDrawer').classList.remove('hidden');
    const curr = localStorage.getItem('basari_currency') || 'IDR';
    ['IDR', 'USD', 'MYR'].forEach(c => {
        const btn = document.getElementById('mobileCurr' + c);
        if (!btn) return;
        if (c === curr) {
            btn.classList.add('border-blue-700', 'text-blue-700', 'bg-blue-50');
            btn.classList.remove('border-gray-200', 'text-gray-600');
        } else {
            btn.classList.remove('border-blue-700', 'text-blue-700', 'bg-blue-50');
            btn.classList.add('border-gray-200', 'text-gray-600');
        }
    });
}
function toggleShopMenu() {
    const menu  = document.getElementById('shopMenu');
    const arrow = document.getElementById('shopArrow');
    menu.classList.toggle('hidden');
    arrow.classList.toggle('rotate-180');
}

function closeMobileMenu() {
    document.getElementById('mobileDrawer').classList.add('hidden');
}

document.getElementById('mobileMenuBtn')?.addEventListener('click', openMobileMenu);
</script>
</body>
</html>