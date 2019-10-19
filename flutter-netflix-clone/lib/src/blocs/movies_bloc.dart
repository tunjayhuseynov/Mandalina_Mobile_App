part of netflix;

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<List<ItemModel>>();
  final _movieFetcher = PublishSubject<Result>();
  final _movieSearch = PublishSubject<List<Result>>();
  final _suggestedFetcher = PublishSubject<Result>();
  final _genresFetcher = PublishSubject<List<GenreResult>>();
  final _sendLike = PublishSubject<int>();

  Observable<List<ItemModel>> get allMovies => _moviesFetcher.stream;
  Observable<Result> get oneMovie => _movieFetcher.stream;
  Observable<Result> get suggestedMovie => _suggestedFetcher.stream;
  Observable<List<GenreResult>> get genres => _genresFetcher.stream;
  Observable<List<Result>> get search => _movieSearch.stream;
  Observable<int> get likeCommited => _sendLike.stream;

  fetchAllMovies() async {
    
    List<ItemModel> items = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(items);
  }

  fetchOneMovie(int id) async {
    Result item = await _repository.fetchMovie(id);
    _movieFetcher.sink.add(item);
  }

  fetchSuggestedMovie() async{
    Result item = await _repository.fetchSuggestedMovie();
    _suggestedFetcher.sink.add(item);
  }

  fetchSearch(String key) async{
    List<Result> item = await _repository.fetchSearch(key);
    _movieSearch.sink.add(item);
  }

    fetchGenres() async{
    List<GenreResult> item = await _repository.fetchGenres();
    _genresFetcher.sink.add(item);
  }

  sendLike(int id) async{
    int item =  await _repository.sendLike(id);
    _sendLike.sink.add(item);
  }

  dispose() {
    _sendLike.close();
    _moviesFetcher.close();
    _movieFetcher.close();
    _suggestedFetcher.close();
    _genresFetcher.close();
    _movieSearch.close();
  }
}

final bloc = MoviesBloc();
