part of netflix;
final String host = 'https://filmdizimob.com';
final String pichost = 'https://filmdizimob.com';
class MovieApiProvider {

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
      tvShow = json.decode(response.body);
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
    print(id);
    final response = await client.get('$host/api/like/$id');
    print(response.statusCode);
    if(response.statusCode == 200){
      return 1;
    }else{
      throw Exception("Failed to send Like");
    }
  }

}
