<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class Movies extends Controller
{
    public function MainMovies(Request $request)
    {
        $start = 0;
        $end = 10; 
        $result = '[';
        $allGenres = DB::table('genres')->get();
        $lastUploaded = Movies::LastUploaded($start,$end);
        $getLastUploaded = json_encode($lastUploaded, true);
        $result .= '{"title": "En son eklenenler", "items": '.$getLastUploaded.'},';
        foreach ($allGenres as $key => $value) {
            $data = Movies::GenreMovies($value->name, $start , $end);
            if(empty($data) != 1){
                $rawdata = json_encode($data, true);
                $decode = '{"title": "'.$value->name.'", "items": '.$rawdata.'}';
                $result .= $decode;
                $result .= ",";
                
            }
        }
        $result = substr($result ,0, -1);
        $result .= ']';

        error_log($result);
         return response()->json(json_decode($result, true), 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
    }

    public function MoviesByOneGenre(Request $request)
    {
        $genre = $request->route("genre");
        $start = $request->route("start");
        $end = $request->route("end");

        if($genre == "en_son_eklenenler"){
            $lastUploaded = Movies::LastUploaded($start,$end);
            $getLastUploaded = json_encode($lastUploaded, true);
            return response()->json(json_decode($getLastUploaded, true), 200); 
        }else{
            $data = Movies::GenreMovies($genre, $start, $end);
            $rawdata = json_encode($data, true);
            $decode = $rawdata;
            return response()->json(json_decode($decode, true), 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
        }



    }

    public function Suggested(Request $request)
    {
        $suggested = DB::table('suggestedmovies')->first();

        $data = Movies::MovieIdAlgorithm($suggested->movieID);

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }


    public function MovieById(Request $request)
    {
        $data = Movies::MovieIdAlgorithm($request->route("id"));

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }


    public static function MovieIdAlgorithm($id)
    {   
        $db = DB::table('movies')->where("id", $id)->get();

        if(count($db) == 0)
            return response()->json(json_decode('{"response": "404"}', true), 200);
        
        $data = json_decode($db, true);

        $data[0]["episodes"] = DB::table('episodes')->where("movieID", $data[0]["id"])->get();
                
        $genres = DB::table('moviegenres')->where("movieID", $data[0]['id'])
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->get();
        $data[0]["genres"] = $genres;

        $data[0]["casts"] = DB::table('moviecasts')->where("movieID", $data[0]["id"])->get();
        
        $data[0]["kind"] = DB::table('movietypes')->where("id", $data[0]["movieType"])->pluck("name")->first();

        return $data[0];
    }

    public static function GenreMovies($genre, int $start, int $end)
    {
        $db = DB::table('moviegenres')
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->join('movies', 'movies.id', '=', 'moviegenres.movieID')
        ->select('movies.*')
        ->orderBy("addedDate", "desc")
        ->where("genres.name", $genre)
        ->skip($start)
        ->take($end)
        ->get();

        $dbCount = DB::table('moviegenres')
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->join('movies', 'movies.id', '=', 'moviegenres.movieID')
        ->select('movies.*')
        ->where("genres.name", $genre)
        ->count();


        $data = json_decode($db, true);
        foreach ($data as $key => $entry) {
               $data[$key]["episodes"] = DB::table('episodes')->where("movieID", $data[$key]["id"])->get();
               
               $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
               ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
               ->get();
               $data[$key]["genres"] = $genres;
               $data[$key]["movieAmountByGenre"] = $dbCount;
               $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
               
               $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();
               
       }
       return $data;
    }

    public static function LastUploaded(int $start, int $end)
    {
        $db = DB::table('movies')
        ->orderBy("addedDate", "desc")
        ->skip($start)
        ->take($end)
        ->get();

        $dbCount = DB::table('movies')
        ->count();


        $data = json_decode($db, true);
        foreach ($data as $key => $entry) {
               $data[$key]["episodes"] = DB::table('episodes')->where("movieID", $data[$key]["id"])->get();
               
               $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
               ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
               ->get();
               $data[$key]["genres"] = $genres;
               $data[$key]["movieAmount"] = $dbCount;
               $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
               
               $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();
               
       }
       return $data;
    }
}
