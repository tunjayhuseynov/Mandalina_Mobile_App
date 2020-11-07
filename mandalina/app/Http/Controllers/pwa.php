<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

use Minishlink\WebPush\WebPush;
use Minishlink\WebPush\Subscription;

class pwa extends Controller
{
    public static $publicKey = "BCPvEAXQZEv1ONndaYOg6_SKfn_b3xgfSHQyN-iinf2Fa6c6g7iRyTi69_EdpTydZoudEzVYq2-vZHRXuC1KZGA";
    private static $privateKey = "h_y17Dn2eWB86KJ8fOWaEfHjMBEw3vvSMlTpENPSH7Q"; 

    public function subscribe(Request $request)
    {
        $endpoint = $request->input("endpoint");
        $p256dh = $request->input("keys")["p256dh"];
        $auth = $request->input("keys")["auth"];
        $contentEncoding = $request->input("contentEncoding");

        if(DB::table('pushmembers')->where("endpoint", $endpoint)->first() === null){
            DB::table('pushmembers')->insert([
                'endpoint' => $endpoint,
                'p256dh' => $p256dh,
                'auth' => $auth,
                'contentEncoding' => $contentEncoding,
                'createdDate' => date("Y-m-d h:i:s")]); 
        }

        return response()->json(['success' => 'success'], 200);
    }

    public static function sendNotification(?string $title = null, ?string $body = null, ?string $image = null, ?string $url = null )
    {
        $auth = [
            'VAPID' => [
                'subject' => 'mailto: <tuncayhuseynov@gmail.com>', // can be a mailto: or your website address
                'publicKey' => self::$publicKey, // (recommended) uncompressed public key P-256 encoded in Base64-URL
                'privateKey' => self::$privateKey, // (recommended) in fact the secret multiplier of the private key encoded in Base64-URL
            ],
        ];
    
        $webPush = new WebPush($auth);

        $members = DB::table('pushmembers')->get();

        if(isset($title)){
            $rawJson = array(
                "title" => $title,
                "body" => $body,
                "icon" => 'assets/ico192.png',
                "badge" => 'assets/icoAlpha.png',
                "image" => $image,
                "url" => $url
            );
        }else{
            $rawJson = array(
                "title" => "Biz Sizi Özledik :(",
                "body" => "Hadi Filmdizimob`a ziyaret et!",
                "icon" => 'assets/ico192.png',
                "badge" => 'assets/icoAlpha.png',
                'image' => 'assets/Filmdizimob-logo-push.png',
                'url' => "https://filmdizimob.com"
            );
        }

        foreach ($members as $member) {
            $notification = [
                'subscription' => Subscription::create([
                    "endpoint" => $member->endpoint,
                    "keys" => [
                        'p256dh' =>  $member->p256dh,
                        'auth' => $member->auth
                    ],
                    'contentEncoding' => $member->contentEncoding
                ]),
                'payload' => json_encode($rawJson, true),
                ];
    
            
            $webPush->sendOneNotification(
                $notification['subscription'],
                $notification['payload'],
            );
        }

    }
}
