<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class EpisodeCrud extends Controller
{
    public function add(Request $request)
    {   
        
        return view("episodeCRUD/add");
    }

    public function postAdd(Request $request)
    {
        $id = $request->route('id');
        $name = $request->input('name');
        $season = $request->input('season');
        $number = $request->input('number');
        $duration = $request->input('duration');
        $description = $request->input('description');

        if($request->hasFile('video')){
            if($request->file("video")->isValid()){
                $video = $request->file("video");
                $videoname = time() . '.' . $video->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("series/videos/".$id."/".$videoname, file_get_contents($video));
            }
        }

        if($request->hasFile("cover")){
            if($request->file("cover")->isValid()){
                $cover = $request->file("cover");
                $covername = time() . '.' . $cover->getClientOriginalExtension();
                Storage::disk('public_uploads')->put("series/covers/".$id."/".$covername, file_get_contents($cover));
            }
        }

        $id =  DB::table('episode')->insertGetId(
            ['name' => $name , 'url' => "series/videos/".$id."/".$videoname, 'season' => $season, 'number' => $number,
            'summary' => $description, "movieID" => $id, 'isDeleted' => FALSE, 'addedDate' => date("Y-m-d h:i:s"),
            'image' => "series/covers/".$id."/".$covername, 'airtime' => $duration]
        );


        return redirect()->back()->with("message", "Saved!");
    }
}
