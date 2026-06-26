<?php

namespace App\Http\Middleware;

use App\Models\PageVisit;
use Closure;
use Illuminate\Http\Request;

class TrackVisitor
{
    public function handle(Request $request, Closure $next)
    {
        // Hanya track GET request, skip asset dan admin
        if ($request->isMethod('GET') 
            && !$request->is('admin/*') 
            && !$request->is('*.css')
            && !$request->is('*.js')
            && !$request->is('*.png')
            && !$request->is('*.jpg')
        ) {
            PageVisit::create([
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
                'page'       => $request->path(),
                'user_id'    => auth()->id(),
            ]);
        }

        return $next($request);
    }
}