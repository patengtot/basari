<?php

namespace App\Helpers;

use App\Models\Notification;

class NotificationHelper
{
    // Kirim notifikasi ke customer
    public static function toUser($userId, $title, $message, $url = null)
    {
        Notification::create([
            'type'    => 'user',
            'user_id' => $userId,
            'title'   => $title,
            'message' => $message,
            'url'     => $url,
            'is_read' => false,
        ]);
    }

    // Kirim notifikasi ke admin
    public static function toAdmin($title, $message, $url = null)
    {
        Notification::create([
            'type'    => 'admin',
            'user_id' => null,
            'title'   => $title,
            'message' => $message,
            'url'     => $url,
            'is_read' => false,
        ]);
    }
}