<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\Message;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ChatController extends Controller
{
    public function index()
    {
        $conversations = Conversation::with(['product', 'latestMessage'])
                                     ->where('user_id', Auth::id())
                                     ->orderByDesc('last_message_at')
                                     ->get();

        return view('frontend.chat.index', compact('conversations'));
    }

    public function show($id)
    {
        $conversation = Conversation::with(['product', 'messages'])
                                    ->where('user_id', Auth::id())
                                    ->findOrFail($id);

        // Tandai pesan admin sebagai sudah dibaca
        $conversation->messages()
                     ->where('sender', 'admin')
                     ->where('is_read', false)
                     ->update(['is_read' => true]);

        return view('frontend.chat.show', compact('conversation'));
    }

    public function start(Request $request)
{
    $request->validate([
        'product_id' => 'required|exists:products,id',
    ]);

    // Cari conversation yang sudah ada untuk user ini
    $conversation = Conversation::where('user_id', Auth::id())
                                ->latest()
                                ->first();

    if (!$conversation) {
        $conversation = Conversation::create([
            'user_id'         => Auth::id(),
            'product_id'      => $request->product_id,
            'last_message_at' => now(),
        ]);
    }

    return redirect()->route('chat.show', $conversation->id);
}

    public function send(Request $request, $id)
    {
        $request->validate(['body' => 'required|string|max:1000']);

        $conversation = Conversation::where('user_id', Auth::id())->findOrFail($id);

        Message::create([
            'conversation_id' => $conversation->id,
            'body'            => $request->body,
            'sender'          => 'user',
            'is_read'         => false,
        ]);

        $conversation->update(['last_message_at' => now()]);

        return back();
    }
    public function startFromOrder(Request $request)
{
    $request->validate([
        'order_id' => 'required|exists:orders,id',
    ]);

    $order = \App\Models\Order::where('user_id', Auth::id())->findOrFail($request->order_id);

    // Cari conversation yang sudah ada untuk user ini
    $conversation = Conversation::where('user_id', Auth::id())
                                ->latest()
                                ->first();

    if (!$conversation) {
        $conversation = Conversation::create([
            'user_id'         => Auth::id(),
            'product_id'      => null,
            'order_id'        => $order->id,
            'last_message_at' => now(),
        ]);
    }

    return redirect()->route('chat.show', $conversation->id);
}
}