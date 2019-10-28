<?php


Route::get('/EnterAP', 'Log@index');

Route::group(['prefix' => 'AdminPanelPinnme','middleware' => ['checkAdmin']], function () {
    Route::get('/', 'Dashboard@index');
    Route::get('/movielist', 'Dashboard@list');
    Route::get('/addition', 'Dashboard@AdditionPage');
    Route::post('/movieadding', 'Dashboard@MovieAdding');
    Route::post('/update', 'Dashboard@updating');
    Route::get('/edit/{id}', 'Dashboard@Edit');
    Route::get('/view/{id}', 'Dashboard@View');
    Route::get('/delete/{id}', 'Dashboard@Delete');
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