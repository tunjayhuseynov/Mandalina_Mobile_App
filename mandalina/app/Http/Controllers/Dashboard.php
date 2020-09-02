<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Providers\DataManupilation;
use Storage;
use Illuminate\Support\Facades\Redirect;

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
        $movies = DataManupilation::MovieByType(DataManupilation::Serie);
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
        $subtitle = $request->input("subtitle");
        $enSubtitle = $request->input("enSubtitle");
        $duration = $request->input("duration");
        $poster = $request->input("poster");
        $imdb = $request->input('imdb');
        

        $contents = file_get_contents($coverUrl);
        $covername = substr($coverUrl, strrpos($coverUrl, '/') + 1);

        $posterContents = file_get_contents($poster);
        $posterCovername = substr($poster, strrpos($poster, '/') + 1);


        if($subtitle != null && str_contains($subtitle, "https://uptobox.com/")){
            $array = preg_split('/\//',$subtitle);
            $url = "https://uptobox.com/api/link?token=690844a0fb2459a1433697be102e16617ojhx&file_code=".end($array);
            $return = file_get_contents($url);
            $vttFile = file_get_contents(json_decode($return, true)["data"]["dlLink"]);
            $subtitle = "/subtitles/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".end($array).".vtt";
            Storage::disk('public_uploads')->put($subtitle, $vttFile);
        }

        if($enSubtitle != null && str_contains($enSubtitle, "https://uptobox.com/")){
            $array = preg_split('/\//',$enSubtitle);
            $url = "https://uptobox.com/api/link?token=690844a0fb2459a1433697be102e16617ojhx&file_code=".end($array);
            $return = file_get_contents($url);
            $vttFile = file_get_contents(json_decode($return, true)["data"]["dlLink"]);
            $enSubtitle = "/subtitles/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".end($array).".vtt";
            Storage::disk('public_uploads')->put($enSubtitle, $vttFile);
        }

        
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
            'subtitleLink' => $subtitle,
            'enSubtitleLink' => $enSubtitle,
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
        $subtitle = $request->input("subtitle");
        $enSubtitle = $request->input("enSubtitle");

        if($coverUrl != null ){
            $contents = file_get_contents($coverUrl);
            $covername = substr($coverUrl, strrpos($coverUrl, '/') + 1);    
            Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$covername, $contents);
        }
        if($subtitle != null && str_contains($subtitle, "https://uptobox.com/")){
            $array = preg_split('/\//',$subtitle);
            $url = "https://uptobox.com/api/link?token=690844a0fb2459a1433697be102e16617ojhx&file_code=".end($array);
            $return = file_get_contents($url);
            $vttFile = file_get_contents(json_decode($return, true)["data"]["dlLink"]);
            $subtitle = "/subtitles/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".end($array).".vtt";
            Storage::disk('public_uploads')->put($subtitle, $vttFile);
        }
        if($enSubtitle != null && str_contains($enSubtitle, "https://uptobox.com/")){
            $array = preg_split('/\//',$enSubtitle);
            $url = "https://uptobox.com/api/link?token=690844a0fb2459a1433697be102e16617ojhx&file_code=".end($array);
            $return = file_get_contents($url);
            $vttFile = file_get_contents(json_decode($return, true)["data"]["dlLink"]);
            $enSubtitle = "/subtitles/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".end($array).".vtt";
            Storage::disk('public_uploads')->put($enSubtitle, $vttFile);
        }
        if($poster != null ){
            $posterContents = file_get_contents($poster);
            $posterCovername = substr($poster, strrpos($poster, '/') + 1);    
            Storage::disk('public_uploads')->put("covers/".preg_replace("/[^a-zA-Z0-9\']/", "", $name)."/".$posterCovername, $posterContents);
        }

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
            'subtitleLink' => $subtitle,
            'enSubtitleLink' => $enSubtitle,
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

    public function getLink($movie)
    {
        $url = "https://uptobox.com/api/link?token=690844a0fb2459a1433697be102e16617ojhx&file_code=".$movie;
        $return = file_get_contents($url);
        $movie = json_decode($return, true)["data"]["dlLink"];

        return $movie;
    }

    public function movieBox(Request $request, $link)
    {
        $prevPath = $_SERVER['HTTP_REFERER'] ?? null;
        error_log($prevPath);
        if ($prevPath != null && $request->session()->has('srox') && $request->session()->get('srox', '0') == "5591980") {
            return Redirect::to($this->getLink($link));
        }
        return "Restricted. API system is coming. You can access it by becoming our member in the future!";
    }

}
