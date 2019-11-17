part of netflix;

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<List<ItemModel>> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<List<Result>> fetchSearch(String key) => moviesApiProvider.fetchSearch(key);
  Future<Result> fetchMovie(int id) => moviesApiProvider.fetchOne(id);
  Future<Result> fetchSuggestedMovie() => moviesApiProvider.fetchSuggested();
  Future<Result> fetchSuggestedSeries() => moviesApiProvider.fetchSeriesSuggested();
  Future<List<GenreResult>> fetchGenres() => moviesApiProvider.fetchGenres();
  Future<int> sendLike(int id) => moviesApiProvider.sendLike(id);
  Future<List<ItemModel>> fetchAllSeries() => moviesApiProvider.fetchSeriesList();

}
