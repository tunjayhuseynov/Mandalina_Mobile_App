<?php


Route::group(['middleware' => ['checkAdmin']], function () {
    Route::get('/', 'Dashboard@index');
    Route::get('/movielist', 'Dashboard@list');
});

Route::group(['prefix' => 'api', 'middleware' => ['validApi']], function () {
    Route::get('/movies/main','Movies@MainMovies');
    Route::get('/{genre}/{start}/{end}','Movies@MoviesByOneGenre');
    Route::get('/movie/{id}','Movies@MovieById');
    Route::get('/suggestedMovie','Movies@Suggested');
    Route::get('/genres','Movies@fetchgenres');
    Route::get('/search/{movie}', 'Movies@search');
    Route::get('/like/{id}', 'Movies@like');
});