part of netflix;

class Genre extends StatefulWidget {
  Genre({Key key, this.item, this.type}) : super(key: key);
  final String item;
  final String type;


  @override
  GenreState createState() => GenreState();
}