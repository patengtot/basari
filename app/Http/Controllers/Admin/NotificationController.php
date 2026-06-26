<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Notification;

class NotificationController extends Controller
{
    public function markRead($id)
    {
        $notif = Notification::where('type', 'admin')->findOrFail($id);
        $notif->update(['is_read' => true]);

        return redirect($notif->url ?? route('admin.orders.index'));
    }

    public function markAllRead()
    {
        Notification::where('type', 'admin')->where('is_read', false)->update(['is_read' => true]);
        return back()->with('success', 'Semua notifikasi ditandai sudah dibaca.');
    }
    public function delete($id)
    {
    Notification::where('type', 'admin')->findOrFail($id)->delete();
    return back();
    }

    public function deleteAll()
    {
    Notification::where('type', 'admin')->delete();
    return back()->with('success', 'Semua notifikasi berhasil dihapus.');
    }
}