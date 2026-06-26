<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
    public function markRead($id)
    {
        $notif = Notification::where('user_id', Auth::id())->findOrFail($id);
        $notif->update(['is_read' => true]);

        return redirect($notif->url ?? route('orders.index'));
    }

    public function markAllRead()
    {
        Notification::where('user_id', Auth::id())->where('is_read', false)->update(['is_read' => true]);
        return back()->with('success', 'Semua notifikasi ditandai sudah dibaca.');
    }
    public function delete($id)
    {
    Notification::where('user_id', Auth::id())->findOrFail($id)->delete();
    return back();
    }

    public function deleteAll()
    {
    Notification::where('user_id', Auth::id())->delete();
    return back()->with('success', 'Semua notifikasi berhasil dihapus.');
    }
}
