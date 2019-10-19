part of netflix;

class GenreResult {
  String _genreName;

  GenreResult.fromJson(Map<String, dynamic> parsedJson) {
    _genreName = parsedJson['name'];
  }

  String get genreName => _genreName;

}
