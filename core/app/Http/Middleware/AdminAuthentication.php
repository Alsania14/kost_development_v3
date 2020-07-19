<?php

namespace App\Http\Middleware;

use Illuminate\Support\Facades\Auth;

use Closure;

class AdminAuthentication
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {   
        if(Auth::check())
        {   
            if(Auth::user()->role == 'admin')
            {
                return $next($request);
            }
            else
            {
                return redirect('/login')->with(['system' => 'denied']);
            }
        }
        else
        {
            return redirect('/login')->with(['system' => 'denied']);
        }
    }
}
