part of netflix;

class ShowsList extends StatelessWidget {
  final ScrollController controller = ScrollController();
  final String title;
  final List<Result> items;
  final Function onTap;
  final Function goToGenre;

  ShowsList({
    this.title,
    this.items,
    this.onTap,
    this.goToGenre,
  });

  

  List<Widget> renderItems() {
    return items.map((item) {
      return InkWell(
        onTap: () => onTap(item, 99),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          width: 120.0,
          height: 140.0,
          child: Image.network(item.image, fit: BoxFit.cover),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(1, 0, 0, 5),
            child: GestureDetector(
              onTap: ()=> goToGenre(title),
              child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
          ),
            ),
          ),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: renderItems(),
            ),
          )
        ],
      ),
    );
  }
}
