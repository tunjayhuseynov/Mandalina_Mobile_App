<?php

use Illuminate\Http\Request;


Route::group(['middleware' => ['validApi']], function () {
    Route::get('/movies/main','Movies@MainMovies');
    Route::get('/series/main','Movies@MainSeries');
    Route::get('/movies/{genre}/{start}/{end}','Movies@MoviesByOneGenre');
    Route::get('/series/{genre}/{start}/{end}','Movies@SeriesByOneGenre');
    Route::get('/all/{genre}/{start}/{end}','Movies@AllByOneGenre');
    Route::get('/movie/{id}','Movies@MovieById');
    Route::get('/serie/{id}','Movies@SeriesById'); //new
    Route::get('/suggestedMovie','Movies@Suggested');
    Route::get('/suggestedSeries','Movies@SuggestedSeries');
    Route::get('/genres','Movies@fetchgenres');
    Route::get('/search/{movie}', 'Movies@search');
    Route::get('/like/{id}', 'Movies@like');
    Route::get('/all', "Movies@all"); //new
});

