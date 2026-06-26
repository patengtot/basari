<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    public function index(Request $request)
{
    $rating = $request->get('rating');

    $reviews = Review::with(['user', 'product', 'order'])
        ->when($rating, fn($q) => $q->where('rating', $rating))
        ->latest()
        ->paginate(10);

    $counts = Review::selectRaw('rating, COUNT(*) as total')
        ->groupBy('rating')
        ->pluck('total', 'rating');

    return view('admin.reviews.index', compact('reviews', 'counts', 'rating'));
}

    public function reply(Request $request, Review $review)
    {
        $request->validate([
            'admin_reply' => 'required|string|max:1000',
        ]);

        $review->update([
            'admin_reply'      => $request->admin_reply,
            'admin_replied_at' => now(),
        ]);

        return back()->with('success', 'Balasan berhasil disimpan.');
    }

    public function destroy(Review $review)
    {
        $review->delete();
        return back()->with('success', 'Review berhasil dihapus.');
    }
}