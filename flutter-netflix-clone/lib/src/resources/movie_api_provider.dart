part of netflix;

class MovieApiProvider {
static final String host = 'https://filmdizimob.com';
static final String pichost = 'https://filmdizimob.com';
  Client client = Client();

  Future<List<ItemModel>> fetchMovieList() async {
    final response = await client.get('$host/api/movies/main');
    if (response.statusCode == 200) {
      String body  = response.body;
      if(!response.body.endsWith(']')){
        body += ']';
      }
      return List.from(json.decode(body))
          .map((m) => ItemModel.fromJson(m))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

    Future<List<ItemModel>> fetchSeriesList() async {
    final response = await client.get('$host/api/series/main');
    if (response.statusCode == 200) {
      String body  = response.body;
      if(!response.body.endsWith(']')){
        body += ']';
      }
      return List.from(json.decode(body))
          .map((m) => ItemModel.fromJson(m))
          .toList();
    } 
    else {
      throw Exception('Failed to load post');
    }
  }

  Future<Result> fetchOne(int id) async {
    final response = await client.get('$host/api/show/$id');
    if (response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<List<Result>> fetchSearch(String key) async {
    final response = await client.get('$host/api/search/$key');
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
      .map((m)=> Result.fromJson(m))
      .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

    Future<Result> fetchSuggested() async {
    final response = await client.get('$host/api/suggestedMovie');
    if (response.statusCode == 200) {
      JsonApi.tvShow = json.decode(response.body);
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

      Future<Result> fetchSeriesSuggested() async {
    final response = await client.get('$host/api/suggestedSeries');
    if (response.statusCode == 200) {
      JsonApi.seriesShow = json.decode(response.body);
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  
  Future<List<GenreResult>> fetchGenres() async {
    final response = await client.get('$host/api/genres');
    if (response.statusCode == 200) {
      String body  = response.body;
      if(!response.body.endsWith(']')){
        body += ']';
      }
      return List.from(json.decode(body))
          .map((m) => GenreResult.fromJson(m))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<int> sendLike(int id) async{
    final response = await client.get('$host/api/like/$id');
    if(response.statusCode == 200){
      return 1;
    }else{
      throw Exception("Failed to send Like");
    }
  }

}
