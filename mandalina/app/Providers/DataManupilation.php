<?php 

namespace App\Providers;

use Illuminate\Support\Facades\DB;

class DataManupilation {


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

?>