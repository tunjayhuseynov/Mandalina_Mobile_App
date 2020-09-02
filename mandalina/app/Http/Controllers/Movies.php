<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Providers\DataManupilation;

class Movies extends Controller
{
    private const Movie = 1;
    private const Serie = 2;

    public function MainMovies(Request $request)
    {
        $end = 18; 
        $start = null;
                
        $json = array();

        $lastUploaded = DataManupilation::LastUploaded(0,$end, self::Movie);
        $subJson = DataManupilation::getObjectJson("En son eklenenler", $lastUploaded); 

        array_push($json, $subJson);

        foreach (DB::table('genres')->get() as $key => $value) {
           
            $data = DataManupilation::GenreMovies($value->name, $start , $end, self::Movie);
            if(empty($data) != 1){

                $subGenreJson = DataManupilation::getObjectJson($value->name, $data);

                array_push($json, $subGenreJson);       
            }
        }

         return response()->json($json, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }
    
    public function MainSeries(Request $request)
    {
        $end = 18; 
        $start = null;
                
        $json = array();

        $lastUploaded = DataManupilation::LastUploaded(0,$end, self::Serie);
        $subJson = DataManupilation::getObjectJson("En son eklenenler", $lastUploaded); 

        array_push($json, $subJson);

        foreach (DB::table('genres')->get() as $key => $value) {
           
            $data = DataManupilation::GenreMovies($value->name, $start , $end, self::Serie);
            if(empty($data) != 1){

                $subGenreJson = DataManupilation::getObjectJson($value->name, $data);

                array_push($json, $subGenreJson);       
            }
        }

         return response()->json($json, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

    public function MoviesByOneGenre(Request $request)
    {
        $genre = $request->route("genre");
        $start = $request->route("start");
        $end = $request->route("end");
        
        $genre = str_replace("_"," ",$genre);

        if($genre == "en son eklenenler"){
            $lastUploaded = DataManupilation::LastUploaded($start,$end, self::Movie);
            return response()->json($lastUploaded, 200); 
        }else{
            $data = DataManupilation::GenreMovies($genre, $start, $end, self::Movie);
            return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
        }
    }
    
    public function AllByOneGenre(Request $request)
    {
        $genre = $request->route("genre");
        $start = $request->route("start");
        $end = $request->route("end");

        $genre = str_replace("_"," ",$genre);
        
        if($genre == "en son eklenenler"){
            $lastUploaded = DataManupilation::LastUploaded($start,$end, 0);
            return response()->json($lastUploaded, 200); 
        }else{
            $data = DataManupilation::GenreMovies($genre, $start, $end, 0);
            return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
        }
    }
    
    public function SeriesByOneGenre(Request $request)
    {
        $genre = $request->route("genre");
        $start = $request->route("start");
        $end = $request->route("end");
        
        $genre = str_replace("_"," ",$genre);

        if($genre == "en son eklenenler"){
            $lastUploaded = DataManupilation::LastUploaded($start,$end, self::Serie);
            return response()->json($lastUploaded, 200); 
        }else{
            $data = DataManupilation::GenreMovies($genre, $start, $end, self::Serie);
            return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
        }
    }

    public function like(Request $request)
    {
        $db = DB::table('likes')->where("movieID", (int)$request->route("id"))->count();
        if($db == 0)
            $insert = DB::table('likes')->insert(["movieID"=> (int)$request->route("id"), "like"=> 1]);
        else
            $update = DB::table('likes')->where("movieID", (int)$request->route("id"))->increment('like');

        return response()->json($db, 200);
    }

    public function Suggested(Request $request)
    {
        $suggested = DB::table('suggestedmovies')->find(1);

        $data = DataManupilation::MovieIdAlgorithm($suggested->movieID);

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

    public function SuggestedSeries(Request $request)
    {
        $suggested = DB::table('suggestedmovies')->find(2);

        $data = DataManupilation::MovieIdAlgorithm($suggested->movieID);

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }
    
    public function MovieById(Request $request)
    {
        $data = DataManupilation::MovieIdAlgorithm($request->route("id"));

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }
    public function SeriesById(Request $request)
    {
        return response()->json(DB::table('episodes')->find($request->route("id")), 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

    public function fetchgenres(Request $request)
    {
        $data = DB::table('genres')->orderBy('name', 'asc')->get();

        return response()->json($data, 200);
    }

    public function search(Request $request)
    {

       $db = DB::table('movies')->whereRaw('LOWER(`name`) LIKE ? AND movies.isDeleted = 0', '%'.strtolower($request->route("movie")).'%' )->take(15)->get();

       $tagname = DB::table('movies')->whereRaw('LOWER(`tagName`) LIKE ? AND movies.isDeleted = 0', '%'.strtolower($request->route("movie")).'%' )->take(15)->get();
       
       $actors = DB::table('movies')
       ->join('moviecasts', 'movies.id', '=', 'moviecasts.movieID')
       ->select('movies.*')
       ->whereRaw('LOWER(`moviecasts`.name) LIKE ?', '%'.strtolower($request->route("movie")).'%' )
       ->get();

       $db = $db->merge($tagname)->merge($actors);
       $db = $db->unique();
       $data = json_decode($db, true);

        foreach ($data as $key => $value) {

            $data[$key]["episodes"] = DB::table('episodes')->where("movieID", $data[$key]["id"])->get();
                
            $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
            ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
            ->get();
            $data[$key]["genres"] = $genres;
            $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
            $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();

        }

        return response()->json(array_values($data), 200);
    }

    public function all(Request $request)
    {
        return response()->json(array_values(DataManupilation::AllMovies()),200);
    }

    public function searchActors(Request $request, $name)
    {
        $data = DB::table('moviecasts')->whereRaw('LOWER(`moviecasts`.name) LIKE ?', '%'.strtolower($name).'%')
        ->get()
        ->unique('name');
        return response()->json(array_values($data->toArray()), 200);
    }
}
