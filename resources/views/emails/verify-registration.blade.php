<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; color: #374151; font-size: 14px; margin: 0; padding: 0; background: #f9fafb; }
        .container { max-width: 560px; margin: 30px auto; background: #fff; border-radius: 12px; overflow: hidden; border: 1px solid #e5e7eb; }
        .header { background: #1e3a5f; padding: 28px 32px; text-align: center; }
        .header h1 { color: #fff; margin: 0; font-size: 22px; letter-spacing: 0.2em; }
        .body { padding: 32px; }
        .btn { display: inline-block; margin: 24px 0; background: #1e3a5f; color: #fff; text-decoration: none; padding: 14px 32px; border-radius: 8px; font-size: 14px; font-weight: bold; }
        .footer { padding: 16px 32px; text-align: center; font-size: 11px; color: #9ca3af; border-top: 1px solid #f3f4f6; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>BASARI.ID</h1>
    </div>
    <div class="body">
        <p>Halo <strong>{{ $name }}</strong>,</p>
        <p>Terima kasih sudah mendaftar di Basari.id. Klik tombol di bawah untuk memverifikasi email kamu dan mengaktifkan akun.</p>
        <div style="text-align: center;">
            <a href="{{ $verificationUrl }}" class="btn">Verifikasi Email Saya</a>
        </div>
        <p style="color: #6b7280; font-size: 12px;">Link ini berlaku selama <strong>60 menit</strong>. Jika kamu tidak merasa mendaftar, abaikan email ini.</p>
        <p style="color: #6b7280; font-size: 12px;">Atau copy link berikut ke browser:<br>
        <span style="color: #1e40af; word-break: break-all;">{{ $verificationUrl }}</span></p>
    </div>
    <div class="footer">Basari.id — Email otomatis, jangan dibalas langsung.</div>
</div>
</body>
</html>