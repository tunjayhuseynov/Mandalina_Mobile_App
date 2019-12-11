part of netflix;

class TvShowState extends State<TvShow> {
  bool isLiked = false;
  int whichSeason = 0;
  @override
  void initState() {
    super.initState();
  }

  void showMovie(String name, String link) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]).then((e) {
      Application.router.navigateTo(
        context,
        Routes.video,
        object: {'title': '$name', 'link': '$link'},
        transition: TransitionType.inFromBottom,
        transitionDuration: const Duration(milliseconds: 200),
      );
    });
  }

  void like(int id) {
    bloc.sendLike(id);
    setState(() {
      isLiked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> seasonList = new List();
    Size screenSize = MediaQuery.of(context).size;
    List<Episode> seasonEpisodes =
        widget.item.episodes.where((w) => w.season == whichSeason + 1).toList();
    for (var i = 0; i < widget.item.seasonNumber; i++) {
      seasonList.add(DropdownMenuItem(
        value: i,
        child: SizedBox(
          width: 150,
          child:
              Text((i + 1).toString() + ". Sezon", textAlign: TextAlign.center),
        ),
      ));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            primary: true,
            expandedHeight: 430 + (widget.item.description.length<200?widget.item.description.length * 0.01:widget.item.description.length*0.21),
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                        width: screenSize.width,
                        height: 220,
                        child:
                            /*FadeInImage.memoryNetwork(
                        fadeInDuration: Duration(milliseconds: 100),
                        image: MovieApiProvider.pichost + widget.item.image,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                      ),*/
                            FadeInImage(
                          fadeInDuration: Duration(milliseconds: 100),
                          image: CachedNetworkImageProvider(
                              MovieApiProvider.pichost + widget.item.image),
                          fit: BoxFit.cover,
                          placeholder: AssetImage("assets/images/loader.gif"),
                        )),
                    Container(
                      width: screenSize.width,
                      height: 220,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              stops: [0.1, 0.4, 1.0],
                              colors: [
                                Colors.black54,
                                Colors.transparent,
                                Colors.black
                              ],
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 64.0,
                                  width: 64.0,
                                  child: OutlineButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () => showMovie(widget.item.name,
                                        widget.item.movieLink),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(32.0),
                                      ),
                                    ),
                                    child: Container(
                                      height: 64.0,
                                      width: 64.0,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.3),
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 48.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.item.name,
                                      maxLines: 3,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                      top: 220,
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 50.0),
                        width: screenSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Çıkış Tarihi: " + widget.item.date,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              'Içerik Yaşı: ${widget.item.rate}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              widget.item.seasonNumber > 0
                                  ? '${widget.item.seasonNumber} Sezon'
                                  : widget.item.movieLength > 0
                                      ? "Uzunluk: ${widget.item.movieLength}dk"
                                      : "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: Text(
                                  widget.item.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 15,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.3),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Oyuncular: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: widget.item.cast.join(', ')),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  isLiked == false
                                      ? FlatButton(
                                          textColor: Colors.white70,
                                          onPressed: () => like(widget.item.id),
                                          child: Container(
                                            height: 50.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.thumb_up,
                                                  size: 24.0,
                                                ),
                                                Text(
                                                  'Beğen',
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : FlatButton(
                                          textColor: Colors.blueAccent,
                                          onPressed: () => print("Done"),
                                          child: Container(
                                            height: 50.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.thumb_up,
                                                  size: 24.0,
                                                ),
                                                Text(
                                                  'Beğen',
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  FlatButton(
                                    textColor: Colors.white70,
                                    onPressed: () => print('Compartir'),
                                    child: Container(
                                      height: 50.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            Icons.share,
                                            size: 20.0,
                                          ),
                                          Text(
                                            'Paylaş',
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.0, bottom: 7),
                              child: Container(
                                child: Text(
                                  seasonEpisodes.length != 0 ? 'Bölümler' : "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            seasonList.length > 0
                                ? Container(
                                    width: 120,
                                    height: 40,
                                    color: Colors.white38,
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      isDense: true,
                                      iconEnabledColor: Colors.white,
                                      value: seasonList[whichSeason].value,
                                      items: seasonList,
                                      onChanged: (selected) {
                                        setState(() {
                                          whichSeason = selected;
                                        });
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          width: 130.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(MovieApiProvider.pichost +
                                  seasonEpisodes[index].image),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              height: 32.0,
                              width: 32.0,
                              child: OutlineButton(
                                padding: EdgeInsets.all(0.0),
                                onPressed: () => showMovie(
                                    seasonEpisodes[index].name,
                                    seasonEpisodes[index].url),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                ),
                                child: Container(
                                  height: 32.0,
                                  width: 32.0,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.3),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${index + 1}. ${seasonEpisodes[index].name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                ),
                              ),
                              Text(
                                '${seasonEpisodes[index].duration}m',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(255, 255, 255, 0.3),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  seasonEpisodes[index].summary,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              childCount: seasonEpisodes.length,
            ),
          )
        ],
      ),
    );
  }
}
