<?php

Route::get('/', function () {
    return View("website/main");
});

Route::get('/herewegoagain/login', 'Log@index');
Route::post('/herewegoagain/process', 'Log@process');
Route::get('/herewegoagain/out', 'Log@out');


Route::group(['prefix' => 'AdminPanelPinnme','middleware' => ['checkAdmin']], function () {
    Route::get('/', 'Dashboard@index');
    Route::get('/movielist', 'Dashboard@list');
    Route::get('/addition', 'Dashboard@AdditionPage');
    Route::post('/Movieadding/', 'Dashboard@MovieAdding');
    Route::post('/update', 'Dashboard@updating');
    Route::get('/edit/{id}', 'Dashboard@Edit');
    Route::get('/changeSuggestion', 'Dashboard@Suggestion');
    Route::post('/postSuggestion', 'Dashboard@changeSuggestion');
    Route::get('/view/{id}', 'Dashboard@View');
    Route::get('/delete/{id}', 'Dashboard@Delete');
    Route::get('/episodes', 'Dashboard@episodes');
    Route::get('/fetchepisodes/{id}', 'Dashboard@FetchEpisodes');
    Route::get('/addEpisode/{id}', 'EpisodeCrud@add');
    Route::post('/postEpisode/{id}', 'EpisodeCrud@postAdd');
    Route::post('/editEpisode/{id}', 'EpisodeCrud@postEdit');
    Route::get('/episodeview/{id}', 'EpisodeCrud@view');
    Route::get('/episodeDelete/{id}', 'EpisodeCrud@delete');
    Route::get('/episodeEdit/{id}', 'EpisodeCrud@edit');
});

Route::get('/player', function (Request $request) {
    return redirect('/'.$request->path());
});

Route::get('/{any}', function(Request $request){
    return View("website/main");
})->where('any', '.*');