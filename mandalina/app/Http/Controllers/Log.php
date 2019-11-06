<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Log extends Controller
{
    public function index(Request $request)
    {
        return view("login");
    }

    public function process(Request $request)
    {
        $username = $request->input("username");
        $password = $request->input("password");
        if(DB::table('admins')->where("username", $username)->exists()){

            $db = DB::table('admins')->where("username", $username)->first();

            if($db->password == $password){

                $request->session()->put('admin', 1);
                $request->session()->put('name', $db->name);
                $request->session()->put('url', $db->image);

                return redirect('/AdminPanelPinnme');;
            }
        }

        return redirect()->back()->with("message", "Wrong credentials!");

    }

    public function out(Request $request)
    {
        $request->session()->forget('admin');

        return redirect('herewegoagain/login');
    }

    
}
