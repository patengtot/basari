<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Http\Request;

class ChatController extends Controller
{
    public function index()
{
    $conversations = Conversation::with(['user', 'product', 'latestMessage'])
                                 ->orderByDesc('last_message_at')
                                 ->get();

    $users = \App\Models\User::orderBy('name')->get();

    return view('admin.chat.index', compact('conversations', 'users'));
}

public function startWithUser(Request $request)
{
    $request->validate(['user_id' => 'required|exists:users,id']);

    // Cari conversation yang sudah ada untuk user ini
    $conversation = Conversation::where('user_id', $request->user_id)
                                ->latest()
                                ->first();

    if (!$conversation) {
        $conversation = Conversation::create([
            'user_id'         => $request->user_id,
            'product_id'      => null,
            'order_id'        => null,
            'last_message_at' => now(),
        ]);
    }

    return redirect()->route('admin.chat.show', $conversation->id);
}

    public function show($id)
    {
        $conversation = Conversation::with(['user', 'product', 'messages'])->findOrFail($id);

        // Tandai pesan user sebagai sudah dibaca
        $conversation->messages()
                     ->where('sender', 'user')
                     ->where('is_read', false)
                     ->update(['is_read' => true]);

        return view('admin.chat.show', compact('conversation'));
    }

    public function send(Request $request, $id)
{
    $request->validate(['body' => 'required|string|max:1000']);

    $conversation = Conversation::with('user')->findOrFail($id);

    Message::create([
        'conversation_id' => $conversation->id,
        'body'            => $request->body,
        'sender'          => 'admin',
        'is_read'         => false,
    ]);

    $conversation->update(['last_message_at' => now()]);

    // Notifikasi ke user
    \App\Helpers\NotificationHelper::toUser(
        $conversation->user_id,
        __('app.msg_from_admin'),
        $request->body,
        route('chat.show', $conversation->id)
    );

    return back();
}
    public function destroy($id)
{
    $conversation = Conversation::findOrFail($id);
    $conversation->messages()->delete();
    $conversation->delete();

    return back()->with('success', 'Percakapan berhasil dihapus.');
}
public function startFromOrder(Request $request)
{
    $request->validate([
        'order_id' => 'required|exists:orders,id',
        'user_id'  => 'required|exists:users,id',
    ]);

    // Cari conversation yang sudah ada untuk user ini (apapun order/produknya)
    $conversation = \App\Models\Conversation::where('user_id', $request->user_id)
                                            ->latest()
                                            ->first();

    if (!$conversation) {
        $conversation = \App\Models\Conversation::create([
            'user_id'         => $request->user_id,
            'product_id'      => null,
            'order_id'        => $request->order_id,
            'last_message_at' => now(),
        ]);
    }

    return redirect()->route('admin.chat.show', $conversation->id);
}
}