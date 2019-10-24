<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Providers\DataManupilation;

class Dashboard extends Controller
{
    public function index(Request $request)
    {
        return view('dashboard');
    }

    public function list(Request $request)
    {   
        $data = DataManupilation::AllMovies();

        
        
        return view('movieList')->with('data',$data);
    }
}
