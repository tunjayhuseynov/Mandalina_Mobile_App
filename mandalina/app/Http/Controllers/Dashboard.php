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

    public function episodes(Request $request)
    {
        $movies = DataManupilation::MovieByType(DataManupilation::Series);
        $data = array($movies,  $request->root());
        return view('episodes')->with("data", $data);
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

    public function FetchEpisodes(Request $request)
    {
        $id = $request->route('id');

        $data = DB::table('episodes')->where([["movieID", $id],["isDeleted", 0]])
        ->orderBy("season", "ASC")
        ->orderBy("number", "ASC")
        ->get();

        return response()->json($data, 200);
    }


    public function MovieAdding(Request $request)
    {
        
        $name = $request->input("name");
        $year = $request->input("year");
        $tag = $request->input("tag");
        $genres = $request->input("genres");
        $cast = $request->input("cast");
        $description = $request->input("description");
        $limit = $request->input("limit");
        $coverUrl = $request->input("cover");
        $type = $request->input("type");
        
        $trailer = $request->input("trailer");
        $movie = $request->input("movie");
        $enmovie = $request->input("enmovie");
        $duration = $request->input("duration");
        $poster = $request->input("poster");
        $imdb = $request->input('imdb');

        $contents = file_get_contents($coverUrl);
        $covername = substr($coverUrl, strrpos($coverUrl, '/') + 1);

        $posterContents = file_get_contents($poster);
        $posterCovername = substr($poster, strrpos($poster, '/') + 1);

       /* if($request->hasFile("video")){
            if($request->file("video")->isValid()){
                $video = $request->file("video");
                $duration = $request->input("duration");

                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$name."/".$videoname, file_get_contents($video));
            }
        }*/

       /* if($request->hasFile("trailer")){
            if($request->file("trailer")->isValid()){
                $trailer = $request->file("trailer");

                $trailername = time() . '.' . $trailer->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$name."/".$trailername, file_get_contents($trailer));
            }
        }*/

        //$covername = time() . '.' . $cover->getClientOriginalExtension();
        
        $id =  DB::table('movies')->insertGetId(
            [
            'name' => $name , 
            'image' => '/covers/'.preg_replace("/[^a-zA-Z0-9\']/", "", $name).'/'.$covername,
            'poster' => '/covers/'.preg_replace("/[^a-zA-Z0-9\']/", "", $name).'/'.$posterCovername,
            'year' => $year, 
            'description' => trim($description),
            'movieType' => $type, 
            'addedDate' => date("Y-m-d h:i:s"), 
            'rate' => $limit, 
            'length' => isset($duration)==1?$duration:0,
            'movieLink' => $movie, 
            'isDeleted' => FALSE, 
            'tagName' => $tag, 
            "trailerLink" => $trailer,
            'englishLink' => $enmovie,
            'imdb' => $imdb
            ]
        );
        
        Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$covername, $contents);
        Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$posterCovername, $posterContents);

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

    public function Test(Request $request){
            if($request->hasFile("test")){
            if($request->file("test")->isValid()){
                $video = $request->file("test");

                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/test/".$videoname, file_get_contents($video));
            }
        }
            return redirect()->back()->with("message", "Saved!");
       }

    public function updating(Request $request)
    {
        $movieid = $request->input("movieid");
        $tag = $request->input("tag");
        $name = $request->input("name");
        $year = $request->input("year");
        $genres = $request->input("genres");
        $cast = $request->input("cast");
        $description = $request->input("description");
        $limit = $request->input("limit");
        $type = $request->input("type");
        $oldcover = $request->input("oldcover");
        $oldposter = $request->input("oldposter");
        $oldlimit = $request->input("oldlimit");
        $duration = $request->input("duration");

        $trailer = $request->input("trailer");
        $poster = $request->input("poster");
        $movie = $request->input("movie");
        $enmovie = $request->input("enmovie");
        $coverUrl = $request->input('cover');
        $imdb = $request->input('imdb');

        if($coverUrl != null ){
            $contents = file_get_contents($coverUrl);
            $covername = substr($coverUrl, strrpos($coverUrl, '/') + 1);    
            Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$covername, $contents);
        }
        if($poster != null ){
            $posterContents = file_get_contents($poster);
            $posterCovername = substr($poster, strrpos($poster, '/') + 1);    
            Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$posterCovername, $posterContents);
        }
      /*  
        if($request->hasFile("video")){
            if($request->file("video")->isValid()){
                $video = $request->file("video");
                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$name."/".$videoname, file_get_contents($video));
            }
        }

        if($request->hasFile("trailer")){
            if($request->file("trailer")->isValid()){
                $trailer = $request->file("trailer");

                $trailername = time() . '.' . $trailer->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("movies/".$name."/".$trailername, file_get_contents($trailer));
            }
        }*/
        /*
        if($request->hasFile("cover")){
            if($request->file("cover")->isValid()){
                $cover = $request->file("cover");
                $covername = time() . '.' . $cover->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("covers/".$name."/".$covername, file_get_contents($cover));
            }
        }*/

        DB::table('movies')
        ->where('id', $movieid)
        ->update(
            [
            'name' => $name , 
            'image' => $coverUrl!=null?'/covers/'.preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$covername:$oldcover , 
            'year' => $year, 
            'description' => trim($description),
            'movieType' => $type, 
            'rate' => $limit, 
            'length' => $oldlimit!=$duration?$duration:$oldlimit,
            'movieLink' => $movie, 
            'englishLink' => $enmovie,
            'poster' => $poster!=null?'/covers/'.preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$posterCovername:$oldposter,
            'isDeleted' => FALSE, 
            'tagName' => $tag,
            'trailerLink' => $trailer,
            'imdb' => $imdb,
            ]
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
    
    public function Suggestion(Request $request)
    {
        $selected = DB::table('suggestedmovies')->find(1);
        $arr = array($selected, DB::table('movies')->where([["isDeleted", 0], ["movieType",1]])->get());
        return view('suggestion')->with("movies", $arr);
    }

    public function changeSuggestion(Request $request)
    {
        $id = $request->input("selection");
        DB::table('suggestedmovies')->where("id", 1)->update(["movieID"=> $id]);
        return redirect()->back()->with("message", "Update Saved!");
    }



}
