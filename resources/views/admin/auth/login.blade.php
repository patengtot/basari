<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Admin — Basari</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-100 font-sans min-h-screen flex items-center justify-center">

<div class="bg-white rounded-2xl border border-gray-100 shadow-sm p-8 w-full max-w-md">

    <div class="text-center mb-8">
        <p class="text-2xl font-bold text-blue-900">Basari</p>
        <p class="text-gray-500 text-sm mt-1">Admin Panel</p>
    </div>

    @if($errors->any())
    <div class="bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg mb-6">
        {{ $errors->first() }}
    </div>
    @endif

    <form method="POST" action="{{ route('admin.login.post') }}" class="space-y-4">
        @csrf

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input type="email" name="email" value="{{ old('email') }}"
                   class="input-field" placeholder="admin@basari.com" required autofocus>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <input type="password" name="password"
                   class="input-field" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-primary w-full text-center mt-2">
            Masuk sebagai Admin
        </button>
    </form>

</div>

</body>
</html>
