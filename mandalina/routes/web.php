<?php



Route::get('/api/movies/main','Movies@MainMovies');
Route::get('/api/{genre}/{start}/{end}','Movies@MoviesByOneGenre');
Route::get('/api/movie/{id}','Movies@MovieById');
Route::get('/api/suggestedMovie','Movies@Suggested');
Route::get('/api/genres','Movies@fetchgenres');
Route::get('/api/search/{movie}', 'Movies@search');
Route::get('/api/like/{id}', 'Movies@like');