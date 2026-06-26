<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AdminLoginController;
use App\Http\Controllers\Auth\UserLoginController;
use App\Http\Controllers\Auth\UserRegisterController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\Admin\DashboardController;
use Illuminate\Foundation\Auth\EmailVerificationRequest;

// Webhook Biteship — letakkan di paling atas sebelum route group lainnya
Route::post('/webhook/biteship', [\App\Http\Controllers\ShippingController::class, 'webhook'])
     ->name('webhook.biteship')
     ->withoutMiddleware([\App\Http\Middleware\VerifyCsrfToken::class]);

// ───── Frontend Auth ─────
Route::get('/login', [UserLoginController::class, 'showLogin'])->name('login');
Route::post('/login', [UserLoginController::class, 'login']);
Route::post('/logout', [UserLoginController::class, 'logout'])->name('logout');
Route::get('/register', [UserRegisterController::class, 'showRegister'])->name('register');
Route::post('/register', [UserRegisterController::class, 'register']);
Route::post('/chat/start-order', [\App\Http\Controllers\ChatController::class, 'startFromOrder'])->name('chat.start-order');

// Email Verification
Route::get('/email/verify', function () {
    return view('frontend.auth.verify-email');
})->middleware('auth.user')->name('verification.notice');

Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();
    return redirect()->route('home')->with('success', 'Email berhasil diverifikasi!');
})->middleware(['auth.user', 'signed'])->name('verification.verify');

Route::post('/email/verification-notification', function (\Illuminate\Http\Request $request) {
    $request->user()->sendEmailVerificationNotification();
    return back()->with('success', 'Link verifikasi sudah dikirim ke email kamu.');
})->middleware(['auth.user', 'throttle:6,1'])->name('verification.send');

// ───── Frontend Public ─────
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/search', [ProductController::class, 'search'])->name('products.search');
Route::get('/products', [ProductController::class, 'all'])->name('products.all');
Route::get('/products/{slug}', [ProductController::class, 'show'])->name('products.show');
Route::get('/category/{slug}', [ProductController::class, 'category'])->name('products.category');
Route::get('/tentang-kami', fn() => view('frontend.tentang'))->name('tentang');
Route::get('/kontak', fn() => view('frontend.kontak'))->name('kontak');

// Lacak Pesanan
Route::get('/lacak-pesanan', [\App\Http\Controllers\TrackingPageController::class, 'index'])->name('tracking.page');
Route::post('/lacak-pesanan', [\App\Http\Controllers\TrackingPageController::class, 'track'])->name('tracking.search');
Route::get('/shipping-information', fn() => view('frontend.info.shipping'))->name('info.shipping');
Route::get('/payment-method', fn() => view('frontend.info.payment'))->name('info.payment');
Route::get('/return-exchange', fn() => view('frontend.info.return'))->name('info.return');
Route::get('/faq', fn() => view('frontend.info.faq'))->name('info.faq');
Route::get('/how-to-order', fn() => view('frontend.info.how-to-order'))->name('info.how-to-order');

Route::get('/language/{lang}', [\App\Http\Controllers\LanguageController::class, 'switch'])->name('language.switch');

Route::get('/shipping/search-location', [\App\Http\Controllers\ShippingController::class, 'searchLocation'])->name('shipping.search');
Route::post('/shipping/rates', [\App\Http\Controllers\ShippingController::class, 'getRates'])->name('shipping.rates');
Route::get('/shipping/tracking/{id}', [\App\Http\Controllers\ShippingController::class, 'tracking'])->name('shipping.tracking');

Route::get('/tracking/{trackingId}', [\App\Http\Controllers\ShippingController::class, 'trackOrder'])->name('shipping.track');

// Webhook iPaymu
// Route::post('/payment/notify', [\App\Http\Controllers\PaymentController::class, 'notify'])
//      ->name('payment.notify')
//      ->withoutMiddleware([\App\Http\Middleware\VerifyCsrfToken::class]);

// Webhook Midtrans
Route::post('/midtrans/notification', [\App\Http\Controllers\MidtransController::class, 'notification'])
     ->name('midtrans.notification')
     ->withoutMiddleware([\App\Http\Middleware\VerifyCsrfToken::class]);


// Simulasi pembayaran (development only)
if (app()->environment('local')) {
    Route::get('/dev/simulate-payment/{invoice}', function($invoice) {
        $order = \App\Models\Order::where('invoice_number', $invoice)->firstOrFail();
        if ($order->status !== 'pending') {
            return 'Order sudah diproses: ' . $order->status;
        }
        $order->update(['status' => 'paid', 'paid_at' => now()]);
        \App\Helpers\NotificationHelper::toUser(
            $order->user_id,
            'Pembayaran Dikonfirmasi',
            "Pembayaran pesanan {$order->invoice_number} telah dikonfirmasi.",
            route('orders.show', $order->id)
        );
        \App\Helpers\NotificationHelper::toAdmin(
            'Pembayaran Diterima',
            "Pembayaran pesanan {$order->invoice_number} dari {$order->shipping_name} telah berhasil.",
            route('admin.orders.show', $order->id)
        );
        return redirect()->route('orders.show', $order->id)
                         ->with('success', 'Simulasi pembayaran berhasil!');
    })->name('dev.simulate.payment');
}

// ───── Frontend Protected ─────
Route::middleware('auth.user')->group(function () {
    // Keranjang
    Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
    Route::post('/cart/add', [CartController::class, 'add'])->name('cart.add');
    Route::patch('/cart/{id}', [CartController::class, 'update'])->name('cart.update');
    Route::delete('/cart/{id}', [CartController::class, 'remove'])->name('cart.remove');

    // Chat
    Route::get('/chat', [\App\Http\Controllers\ChatController::class, 'index'])->name('chat.index');
    Route::get('/chat/{id}', [\App\Http\Controllers\ChatController::class, 'show'])->name('chat.show');
    Route::post('/chat/start', [\App\Http\Controllers\ChatController::class, 'start'])->name('chat.start');
    Route::post('/chat/{id}/send', [\App\Http\Controllers\ChatController::class, 'send'])->name('chat.send');

    Route::get('/checkout', [OrderController::class, 'checkout'])->name('checkout.index');
    Route::post('/checkout', [OrderController::class, 'store'])->name('checkout.store');

    // Pesanan
    Route::get('/orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('/orders/{id}', [OrderController::class, 'show'])->name('orders.show');
    Route::patch('/orders/{id}/cancel', [OrderController::class, 'cancel'])->name('orders.cancel');

    // Profil
    Route::get('/profile', [\App\Http\Controllers\ProfileController::class, 'index'])->name('profile.index');
    Route::patch('/profile', [\App\Http\Controllers\ProfileController::class, 'update'])->name('profile.update');
    Route::patch('/profile/password', [\App\Http\Controllers\ProfileController::class, 'updatePassword'])->name('profile.password');

    // Notifikasi customer
    Route::get('/notifications/{id}/read', [\App\Http\Controllers\NotificationController::class, 'markRead'])->name('notifications.read');
    Route::post('/notifications/read-all', [\App\Http\Controllers\NotificationController::class, 'markAllRead'])->name('notifications.readAll');
    Route::delete('/notifications/{id}', [\App\Http\Controllers\NotificationController::class, 'delete'])->name('notifications.delete');
    Route::delete('/notifications', [\App\Http\Controllers\NotificationController::class, 'deleteAll'])->name('notifications.deleteAll');

    // // Payment iPaymu
    // Route::get('/payment/{id}', [\App\Http\Controllers\PaymentController::class, 'pay'])->name('payment.pay');

    // Midtrans
    Route::get('/payment/{id}', [\App\Http\Controllers\MidtransController::class, 'pay'])->name('payment.pay');

    // PayPal — internasional
    Route::get('/payment/paypal/{id}', [\App\Http\Controllers\PayPalController::class, 'pay'])->name('paypal.pay');
    Route::get('/payment/paypal/{id}/success', [\App\Http\Controllers\PayPalController::class, 'success'])->name('paypal.success');
    Route::get('/payment/paypal/{id}/cancel', [\App\Http\Controllers\PayPalController::class, 'cancel'])->name('paypal.cancel');
    
    
    Route::post('/currency/set', function(\Illuminate\Http\Request $request) {
    $request->validate(['currency' => 'required|in:IDR,USD,MYR']);
    session(['basari_currency' => $request->currency]);
    return response()->json(['success' => true]);
})->name('currency.set');

    // Review
    Route::post('/reviews', [\App\Http\Controllers\ReviewController::class, 'store'])->name('reviews.store');
    
});

// ───── Admin ─────
Route::prefix('admin')->name('admin.')->group(function () {
    Route::get('/login', [AdminLoginController::class, 'showLogin'])->name('login');
    Route::post('/login', [AdminLoginController::class, 'login'])->name('login.post');
    Route::post('/logout', [AdminLoginController::class, 'logout'])->name('logout');

    Route::middleware('admin')->group(function () {
        Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
        

        // Users
        Route::get('/users', [\App\Http\Controllers\Admin\UserController::class, 'index'])->name('users.index');
        Route::get('/users/{user}', [\App\Http\Controllers\Admin\UserController::class, 'show'])->name('users.show');

        Route::delete('/users/{user}', [\App\Http\Controllers\Admin\UserController::class, 'destroy'])->name('users.destroy');

        // Produk
        Route::resource('products', \App\Http\Controllers\Admin\ProductController::class);

        // Chat
        Route::get('/chat', [\App\Http\Controllers\Admin\ChatController::class, 'index'])->name('chat.index');
        Route::get('/chat/{id}', [\App\Http\Controllers\Admin\ChatController::class, 'show'])->name('chat.show');
        Route::post('/chat/{id}/send', [\App\Http\Controllers\Admin\ChatController::class, 'send'])->name('chat.send');
        Route::delete('/chat/{id}', [\App\Http\Controllers\Admin\ChatController::class, 'destroy'])->name('chat.destroy');
        Route::post('/chat/start-order', [\App\Http\Controllers\Admin\ChatController::class, 'startFromOrder'])->name('chat.start-order');
        Route::post('/chat/start-user', [\App\Http\Controllers\Admin\ChatController::class, 'startWithUser'])->name('chat.start-user');

        // Kategori
        Route::get('/categories', [\App\Http\Controllers\Admin\CategoryController::class, 'index'])->name('categories.index');
        Route::post('/categories', [\App\Http\Controllers\Admin\CategoryController::class, 'store'])->name('categories.store');
        Route::patch('/categories/{category}', [\App\Http\Controllers\Admin\CategoryController::class, 'update'])->name('categories.update');
        Route::delete('/categories/{category}', [\App\Http\Controllers\Admin\CategoryController::class, 'destroy'])->name('categories.destroy');

        // Banner
        Route::get('/banners', [\App\Http\Controllers\Admin\BannerController::class, 'index'])->name('banners.index');
        Route::post('/banners', [\App\Http\Controllers\Admin\BannerController::class, 'store'])->name('banners.store');
        Route::delete('/banners/{banner}', [\App\Http\Controllers\Admin\BannerController::class, 'destroy'])->name('banners.destroy');
        Route::post('/banners/hero-video', [\App\Http\Controllers\Admin\BannerController::class, 'updateHeroVideo'])->name('banners.hero-video');
        Route::patch('/banners/{banner}', [\App\Http\Controllers\Admin\BannerController::class, 'update'])->name('banners.update');

        // Pesanan
        Route::get('/orders', [\App\Http\Controllers\Admin\OrderController::class, 'index'])->name('orders.index');
        Route::get('/orders/{order}', [\App\Http\Controllers\Admin\OrderController::class, 'show'])->name('orders.show');
        Route::delete('/orders/{order}', [\App\Http\Controllers\Admin\OrderController::class, 'destroy'])->name('orders.destroy');
        Route::patch('/orders/{order}/status', [\App\Http\Controllers\Admin\OrderController::class, 'updateStatus'])->name('orders.status');
        Route::patch('/orders/{order}/resi', [\App\Http\Controllers\Admin\OrderController::class, 'updateResi'])->name('orders.resi');
        Route::post('/orders/{order}/biteship', [\App\Http\Controllers\ShippingController::class, 'createOrder'])->name('orders.biteship');
        Route::post('/orders/{order}/sync-tracking', [\App\Http\Controllers\ShippingController::class, 'syncTracking'])->name('orders.sync-tracking');
        Route::get('/orders/{biteshipOrderId}/print-label', [\App\Http\Controllers\ShippingController::class, 'printLabel'])->name('orders.print-label');
        Route::post('/orders/{order}/intl-shipping', [\App\Http\Controllers\Admin\OrderController::class, 'confirmIntlShipping'])->name('orders.intl-shipping');
        Route::post('/orders/{order}/intl-resi', [\App\Http\Controllers\Admin\OrderController::class, 'inputIntlResi'])->name('orders.intl-resi');

        // Notifikasi admin
        Route::get('/notifications/{id}/read', [\App\Http\Controllers\Admin\NotificationController::class, 'markRead'])->name('notifications.read');
        Route::post('/notifications/read-all', [\App\Http\Controllers\Admin\NotificationController::class, 'markAllRead'])->name('notifications.readAll');
        Route::delete('/notifications/{id}', [\App\Http\Controllers\Admin\NotificationController::class, 'delete'])->name('notifications.delete');
        Route::delete('/notifications', [\App\Http\Controllers\Admin\NotificationController::class, 'deleteAll'])->name('notifications.deleteAll');

        // Dashboard data
        Route::get('/dashboard/traffic', [\App\Http\Controllers\Admin\DashboardController::class, 'trafficData'])->name('dashboard.traffic');
        Route::get('/dashboard/revenue', [\App\Http\Controllers\Admin\DashboardController::class, 'revenueData'])->name('dashboard.revenue');

        // Review
        Route::get('/reviews', [\App\Http\Controllers\Admin\ReviewController::class, 'index'])->name('reviews.index');
        Route::post('/reviews/{review}/reply', [\App\Http\Controllers\Admin\ReviewController::class, 'reply'])->name('reviews.reply');
        Route::delete('/reviews/{review}', [\App\Http\Controllers\Admin\ReviewController::class, 'destroy'])->name('reviews.destroy');

        // Analisis Keuangan
        Route::get('/finance', [\App\Http\Controllers\Admin\FinanceController::class, 'index'])->name('finance.index');
        Route::get('/finance/chart', [\App\Http\Controllers\Admin\FinanceController::class, 'chartData'])->name('finance.chart');
        Route::get('/finance/export', [\App\Http\Controllers\Admin\FinanceController::class, 'export'])->name('finance.export');

         // Settings
        Route::get('/settings', [\App\Http\Controllers\Admin\SettingsController::class, 'index'])->name('settings.index');
        Route::post('/settings/password', [\App\Http\Controllers\Admin\SettingsController::class, 'updatePassword'])->name('settings.password');
    });
});