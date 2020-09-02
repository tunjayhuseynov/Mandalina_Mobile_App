<?php 

namespace App\Providers;

use Illuminate\Support\Facades\DB;


class DataManupilation {
    
    const Movie = 1;
    const Serie = 2;

    public static function MovieIdAlgorithm($id)
    {   
        $db = DB::table('movies')->where("id", $id)->first();

        if(is_null($db))
            return response()->json(json_decode('{"response": "404"}', true), 200);
        
        $data = json_decode(json_encode($db,true), true);

        $data["episodes"] = DB::table('episodes')->where([["movieID", $data["id"]],["isDeleted", 0]])
        ->orderBy("season", "ASC")
        ->orderBy("number", "ASC")
        ->get();
                
        $genres = DB::table('moviegenres')->where("movieID", $data['id'])
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->get();
        $data["genres"] = $genres;
        $data["casts"] = DB::table('moviecasts')->where("movieID", $data["id"])->get();
        $data["kind"] = DB::table('movietypes')->where("id", $data["movieType"])->pluck("name")->first();
        return $data;
    }

    public static function GenreMovies($genre, $start, int $end, int $type)
    {
        $db = DB::table('moviegenres')
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->join('movies', 'movies.id', '=', 'moviegenres.movieID')
        ->select('movies.*')
        ->orderBy("addedDate", "desc")
        ->where([
            ["genres.name", $genre],
            ["movies.isDeleted", 0],
            ["movieType", $type]
        ])
        ->skip(!is_null($start)?$start:rand(0,DataManupilation::getCountByMovieGenre($type,$genre)-$end))
        ->take($end)
        ->get();

        
        $data = json_decode($db, true);
        foreach ($data as $key => $entry) {
               $data[$key]["movieAmountByGenre"] = DataManupilation::getCountByMovieGenre($type,$genre);
               $data[$key]["description"] = ""; // set Description Null
               /*$data[$key]["episodes"] = DB::table('episodes')->where([["movieID", $data[$key]["id"]],["isDeleted", 0]])
               ->orderBy("season", "ASC")
               ->orderBy("number", "ASC")
               ->get();
               
               $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
               ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
               ->get();
               $data[$key]["genres"] = $genres;
               
               $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
               
               $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();
               
        */}
       return $data;
    }

    public static function AllMovies()
    {
        $db = DB::table('moviegenres')
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->join('movies', 'movies.id', '=', 'moviegenres.movieID')
        ->select('movies.*')
        ->where("movies.isDeleted", 0)
        ->get()
        ->unique('id');


        $data = json_decode($db, true);
        foreach ($data as $key => $entry) {
               $data[$key]["episodes"] = DB::table('episodes')->where([["movieID", $data[$key]["id"]],["isDeleted", 0]])
               ->orderBy("season", "ASC")
               ->orderBy("number", "ASC")
               ->get();
               
               $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
               ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
               ->get();
               $data[$key]["genres"] = $genres;
               $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
               
               $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();
               
       }
       return $data;
    }

    public static function LastUploaded(int $start, int $end, int $type)
    {

        $db = DB::table('movies')
        ->orderBy("id", "desc")
        ->where([["movies.isDeleted", 0], ["movies.movieType", $type]])
        ->skip($start)
        ->take($end)
        ->get();

        
        $dbCount = DB::table('movies')->where([["movies.isDeleted", 0], ["movies.movieType", $type]])
        ->count();


        $data = json_decode($db, true);
        foreach ($data as $key => $entry) {
               $data[$key]["description"] = ""; // set Description Null
               /*$data[$key]["episodes"] = DB::table('episodes')->where([["movieID", $data[$key]["id"]], ["episodes.isDeleted", 0]])
               ->orderBy("season", "ASC")
               ->orderBy("number", "ASC")
               ->get();
               
               $data[$key]["seasonNumber"] = DB::table('episodes')->where([["movieID", $data[$key]["id"]],["isDeleted", 0]])->max('season');
               
               $genres = DB::table('moviegenres')->where("movieID", $data[$key]['id'])
               ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
               ->get();
               $data[$key]["genres"] = $genres;
               $data[$key]["movieAmountByGenre"] = $dbCount;
               $data[$key]["casts"] = DB::table('moviecasts')->where("movieID", $data[$key]["id"])->get();
               
               $data[$key]["kind"] = DB::table('movietypes')->where("id", $data[$key]["movieType"])->pluck("name")->first();
               
        */}
       return $data;
    }

    public static function MovieByType(int $type)
    {
        $data = DB::table('movies')->where([['movieType', $type],["movies.isDeleted", 0]])->get();

        return $data;
    }

    private static function getCountByMovieGenre(int $type, $genre){
        return DB::table('moviegenres')
        ->join('genres', 'genres.id', '=', 'moviegenres.genreID')
        ->join('movies', 'movies.id', '=', 'moviegenres.movieID')
        ->select('movies.*')
        ->where([['movies.movieType', $type],["genres.name", $genre],["movies.isDeleted", 0],])
        ->get()
        ->unique()
        ->count();
    }

    public static function getObjectJson($title , $object){
        return array("title" => $title, "items" => $object);
    }

}

?>
