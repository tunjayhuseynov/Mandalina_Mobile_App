<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Providers\DataManupilation;

class Movies extends Controller
{
    public function MainMovies(Request $request)
    {
        $start = 0;
        $end = 10; 
        $result = '[';
        $allGenres = DB::table('genres')->get();
        $lastUploaded = DataManupilation::LastUploaded($start,$end);
        $getLastUploaded = json_encode($lastUploaded, true);
        $result .= '{"title": "En son eklenenler", "items": '.$getLastUploaded.'},';
        foreach ($allGenres as $key => $value) {
            $data = DataManupilation::GenreMovies($value->name, $start , $end);
            if(empty($data) != 1){
                $rawdata = json_encode($data, true);
                $decode = '{"title": "'.$value->name.'", "items": '.$rawdata.'}';
                $result .= $decode;
                $result .= ",";
                
            }
        }
        $result = substr($result ,0, -1);
        $result .= ']';

         return response()->json(json_decode($result, true), 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
    }

    public function MoviesByOneGenre(Request $request)
    {
        $genre = $request->route("genre");
        $start = $request->route("start");
        $end = $request->route("end");

        if($genre == "en_son_eklenenler"){
            $lastUploaded = DataManupilation::LastUploaded($start,$end);
            $getLastUploaded = json_encode($lastUploaded, true);
            return response()->json(json_decode($getLastUploaded, true), 200); 
        }else{
            $data = DataManupilation::GenreMovies($genre, $start, $end);
            $rawdata = json_encode($data, true);
            $decode = $rawdata;
            return response()->json(json_decode($decode, true), 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE); 
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
        $suggested = DB::table('suggestedmovies')->first();

        $data = DataManupilation::MovieIdAlgorithm($suggested->movieID);

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }


    public function MovieById(Request $request)
    {
        $data = DataManupilation::MovieIdAlgorithm($request->route("id"));

        return response()->json($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

    public function fetchgenres(Request $request)
    {
        $data = DB::table('genres')->get();

        return response()->json($data, 200);
    }

    public function search(Request $request)
    {
        $db = DB::table('movies')->where("name", "LIKE", '%'.$request->route("movie").'%')->take(15)->get();

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

        return response()->json($data, 200);
    }
}
