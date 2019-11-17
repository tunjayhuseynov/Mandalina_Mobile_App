part of netflix;

class Summary extends StatefulWidget {
  final String title;
  final int type;
  Summary(this.type, {Key key, this.title}) : super(key: key);


  @override
  SummaryState createState() => SummaryState();
}