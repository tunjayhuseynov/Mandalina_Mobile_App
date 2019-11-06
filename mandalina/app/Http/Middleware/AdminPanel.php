<?php

namespace App\Http\Middleware;

use Closure;

class AdminPanel
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

        if($request->session()->get('admin', 0) == 1){

            return $next($request);
        }

        return redirect('herewegoagain/login');
    }
}
