<?php



Route::get('/api/movies/main','Movies@MainMovies');
Route::get('/api/{genre}/{start}/{end}','Movies@MoviesByOneGenre');
Route::get('/api/movie/{id}','Movies@MovieById');
Route::get('/api/suggestedMovie','Movies@Suggested');
