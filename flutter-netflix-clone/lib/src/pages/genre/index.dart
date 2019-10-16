part of netflix;

class Genre extends StatefulWidget {
  Genre({Key key, this.item}) : super(key: key);
  final String item;


  @override
  GenreState createState() => GenreState();
}