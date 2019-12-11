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
            margin: EdgeInsets.fromLTRB(10.5, 0, 0, 0),
            width: 120.0,
            height: 160.0,
            child: //Image.network(pichost + item.image, fit: BoxFit.cover),
                //FadeInImage.memoryNetwork(fadeInDuration: Duration(milliseconds: 100),image: MovieApiProvider.pichost + item.image, fit: BoxFit.cover, placeholder: kTransparentImage,)
                /*FadeInImage.assetNetwork(
              fadeInDuration: Duration(milliseconds: 100),
              image: MovieApiProvider.pichost + item.image,
              fit: BoxFit.cover,
              placeholder: "assets/images/loader.gif",
            )*/
                FadeInImage(
              image: CachedNetworkImageProvider(
                  MovieApiProvider.pichost + item.image),
              fadeInDuration: Duration(milliseconds: 100),
              placeholder: AssetImage("assets/images/loader.gif"),
              fit: BoxFit.cover,
            )),
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
            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
            child:
                /*GestureDetector(
              onTap: () => goToGenre(title, items.last.movieType),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),*/
                RaisedButton.icon(
              color: Colors.transparent,
              onPressed: () => goToGenre(title, items.last.movieType),
              label: Text(
                title.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
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
