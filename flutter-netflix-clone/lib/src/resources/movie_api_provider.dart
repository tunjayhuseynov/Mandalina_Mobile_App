part of netflix;

class MovieApiProvider {
  final String host = 'http://188.227.209.89:90';
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
    Future<Result> fetchSuggested() async {
    final response = await client.get('$host/api/suggestedMovie');
    if (response.statusCode == 200) {
      tvShow = json.decode(response.body);
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
