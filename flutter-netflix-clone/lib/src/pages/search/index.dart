part of netflix;

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SearchState createState() => SearchState();
}