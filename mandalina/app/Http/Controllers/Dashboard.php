<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Providers\DataManupilation;
use Storage;

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

    public function AdditionPage(Request $request)
    {
        $genres = DB::table('genres')->get();
        $types = DB::table('movietypes')->get();
        $data = array($genres, $types);

        return view('add')->with('data',$data);
    }

    public function MovieAdding(Request $request)
    {
        $name = $request->input("name");
        $year = $request->input("year");
        $genres = $request->input("genres");
        $cast = $request->input("cast");
        $description = $request->input("description");
        $limit = $request->input("limit");
        $cover = $request->file("cover");
        $type = $request->input("type");

        if($request->hasFile("video")){
            if($request->file("video")->isValid()){
                $video = $request->file("video");
                $duration = $request->input("duration");

                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$videoname, file_get_contents($video));
            }
        }
        $covername = time() . '.' . $cover->getClientOriginalExtension();
        Storage::disk('public_uploads')->put("covers/".$covername, file_get_contents($cover));
        
        $id =  DB::table('movies')->insertGetId(
            ['name' => $name , 'image' => '/covers/'.$covername , 'year' => $year, 'description' => trim($description),
            'movieType' => $type, 'addedDate' => date("Y-m-d h:i:s"), 'rate' => $limit, 'length' => isset($duration)==1?$duration:0,
            'movieLink' => isset($video)==1?'/movies/'.$videoname:'', 'isDeleted' => FALSE]
        );


        foreach ($genres as $key => $value) {
            DB::table('moviegenres')->insert([
                'movieID' => $id,
                'genreID' => $value
            ]);
        }
        
        foreach ($cast as $key => $value) {
            DB::table('moviecasts')->insert([
                'name' => $value,
                'movieID' => $id
            ]);
        }

        return redirect()->back()->with("message", "Saved!");
    }

    public function Edit(Request $request)
    {
        $id = $request->route("id");

        $movie = DataManupilation::MovieIdAlgorithm($id);

        $genres = DB::table('genres')->get();
        $types = DB::table('movietypes')->get();
        $data = array($genres, $types, $movie, $request->root());

        return view('edit')->with('data', $data);
    }

    public function updating(Request $request)
    {
        $movieid = $request->input("movieid");
        $name = $request->input("name");
        $year = $request->input("year");
        $genres = $request->input("genres");
        $cast = $request->input("cast");
        $description = $request->input("description");
        $limit = $request->input("limit");
        $type = $request->input("type");
        $oldcover = $request->input("oldcover");
        $oldvideo = $request->input("oldvideo");
        $oldlimit = $request->input("oldlimit");
        $duration = $request->input("duration");
        
        if($request->hasFile("video")){
            if($request->file("video")->isValid()){
                $video = $request->file("video");


                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$videoname, file_get_contents($video));
            }
        }

        if($request->hasFile("cover")){
            if($request->file("cover")->isValid()){
                $cover = $request->file("cover");
                $covername = time() . '.' . $cover->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("covers/".$covername, file_get_contents($cover));
            }
        }

        DB::table('movies')
        ->where('id', $movieid)
        ->update(
            ['name' => $name , 'image' => isset($cover)==1?'/covers/'.$covername:$oldcover , 'year' => $year, 'description' => trim($description),
            'movieType' => $type, 'addedDate' => date("Y-m-d h:i:s"), 'rate' => $limit, 'length' => $oldlimit!=$duration?$duration:$oldlimit,
            'movieLink' => isset($video)==1?'/movies/'.$videoname:$oldvideo, 'isDeleted' => FALSE]
        );
        

        DB::table('moviegenres')->where("movieID", $movieid)->delete();
        DB::table('moviecasts')->where("movieID", $movieid)->delete();

        foreach ($genres as $key => $value) {
            DB::table('moviegenres')
            ->insert([
                'movieID' => $movieid,
                'genreID' => $value
            ]);
        }
        
        foreach ($cast as $key => $value) {
            DB::table('moviecasts')->insert([
                'name' => $value,
                'movieID' => $movieid
            ]);
        }

        return redirect()->back()->with("message", "Update Saved!");
        
    }

    public function Delete(Request $request)
    {
        $id = $request->route("id");

        DB::table('movies')->where('id', $id)
        ->update(['isDeleted'=> TRUE]);

        return redirect()->back()->with("message", "Successfully Deleted!");   
    }

    public function View(Request $request)
    {
        $id = $request->route("id");

        $movie = DataManupilation::MovieIdAlgorithm($id);

        $genres = DB::table('genres')->get();
        $types = DB::table('movietypes')->get();
        $data = array($genres, $types, $movie, $request->root());

        return view('view')->with('data', $data);
    }
}
