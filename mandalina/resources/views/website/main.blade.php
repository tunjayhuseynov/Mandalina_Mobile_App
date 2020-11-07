<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="author" content="PinnMe">
    <meta name="application-name" content="FilmDiziMob">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta name="csrf-token" content="{{ csrf_token() }}">
<link rel="shortcut icon" href="{{URL::asset('assets/ico.ico')}}" />
    <title>Filmdizimob.Com - Yeni Nesil Film Sitesi</title>
    <link rel="stylesheet" href="https://unpkg.com/placeholder-loading/dist/css/placeholder-loading.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
    rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">

    <link type="text/css" rel="stylesheet" href="{{URL::asset('assets/css/moby.min.css')}}"/>

    <link rel="stylesheet" href="{{URL::asset('assets/css/bootstrap.css')}}">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script async src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
    </script>
    <script async src="{{URL::asset('assets/js/bootstrap.js')}}">
    </script>
    <link href="https://fonts.googleapis.com/css?family=Hind:400,500,700|Ramabhadra" rel="stylesheet">
    <link rel="stylesheet" href="{{asset('assets/css/style.css')}}">
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.3.0/socket.io.js"></script>
<script src="https://vjs.zencdn.net/7.6.6/video.js"></script>
<body style="overflow-x: hidden">
    <div id="app">
        <div>
             <router-view />
        </div>
    </div>
    <script>
        if ('scrollRestoration' in history) { history.scrollRestoration = 'manual'; }
    </script>
    <script src="{{URL::asset('assets/js/moby.min.js')}}"></script>
    <script src="{{URL::asset('/js/manifest.js')}}"></script>
<script src="{{URL::asset('/js/vendor.js')}}"></script>
<script src="{{URL::asset('/js/app.js')}}"></script>
    <script>
        let socket = io("https://nodejs.filmdizimob.com");
        socket.emit("user")
      </script>
    <script src="https://use.fontawesome.com/17cb93764d.js"></script>

</body>

</html>