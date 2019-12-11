part of netflix;

class SearchState extends State<Search> with SingleTickerProviderStateMixin {
  final genres = [];
  @override
  void initState() {
    bloc.fetchGenres();
    super.initState();
  }

  void goToGenre(String item, int type) {
    if (item.split(" ").length > 0) {
      item = item.replaceAll(" ", "_");
    }
    Application.router.navigateTo(
      context,
      '${Routes.genre}',
      transition: TransitionType.inFromRight,
      transitionDuration: const Duration(milliseconds: 200),
      object: {'item': item, 'type': type == 0 ? 'all' : 'movies'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Arama")),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(context: context)),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                width: MediaQuery.of(context).size.width-150,
                height: 50,
                child: Center(
                    child: Text(
                  "Arama Başlat",
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                )),
              ),
            ),
            StreamBuilder(
              stream: bloc.genres,
              builder: (context, AsyncSnapshot<List<GenreResult>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: () =>
                                  goToGenre(snapshot.data[index].genreName, 0),
                              child: Text(
                                snapshot.data[index].genreName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: DesignWidget._bar(),
                ));
              },
            ),
          ],
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  BuildContext context;
  CustomSearchDelegate({@required this.context});

  void goToDetail(Result item, int match) {
    Application.router.navigateTo(
      context,
      '${Routes.detail}',
      transition: TransitionType.inFromRight,
      transitionDuration: const Duration(milliseconds: 200),
      object: {'match': match, 'show': item},
    );
  }

  @override
  String get searchFieldLabel => 'Ara';

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      secondaryHeaderColor: Colors.white,
      primaryColor: Colors.black,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
      textTheme: Typography().white,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length == 0)
      return Container(
        color: Colors.black,
        child: Center(
          child: Text(
            "Arama için film/dizi ismi giriniz.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    bloc.fetchSearch(query);
    return Container(
      color: Colors.black,
      child: StreamBuilder(
        stream: bloc.search,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: snapshot.data.length != 0
                        ? GridView.builder(
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisSpacing: 5),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () =>
                                    goToDetail(snapshot.data[index], 99),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(3, 4, 3, 4),
                                  width: 120.0,
                                  height: 160.0,
                                  child: /*FadeInImage.assetNetwork(
                                    fadeInDuration: Duration(milliseconds: 100),
                                    image: MovieApiProvider.pichost +
                                        snapshot.data[index].image,
                                    fit: BoxFit.cover,
                                    placeholder: "assets/images/loader.gif",
                                  ),*/
                                  FadeInImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 100),
                                        image: CachedNetworkImageProvider(
                                            MovieApiProvider.pichost +
                                                snapshot.data[index].image),
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            "assets/images/loader.gif"),
                                      ),
                                ),
                              );
                            })
                        : Center(
                            child: new Text(
                            "Maalesef bu isimde henüz film/dizi yok",
                            style: TextStyle(color: Colors.white),
                          )),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: DesignWidget._bar(),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      bloc.fetchSearch(query);
      return Container(
        color: Colors.black,
        child: StreamBuilder(
          stream: bloc.search,
          builder: (context, AsyncSnapshot<List<Result>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      child: snapshot.data.length != 0
                          ? GridView.builder(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: 0.75),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () =>
                                      goToDetail(snapshot.data[index], 99),
                                  child: Container(
                                      //margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      width: 120.0,
                                      height: 160.0,
                                      child:
                                          /*FadeInImage.assetNetwork(
                                        fadeInDuration:
                                            Duration(milliseconds: 100),
                                        image: MovieApiProvider.pichost +
                                            snapshot.data[index].image,
                                        fit: BoxFit.cover,
                                        placeholder: "assets/images/loader.gif",
                                      )*/
                                          FadeInImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 100),
                                        image: CachedNetworkImageProvider(
                                            MovieApiProvider.pichost +
                                                snapshot.data[index].image),
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            "assets/images/loader.gif"),
                                      )),
                                );
                              })
                          : Center(
                              child: new Text(
                              "Maalesef bu isimde henüz film/dizi yok",
                              style: TextStyle(color: Colors.white),
                            )),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: DesignWidget._bar(),
            );
          },
        ),
      );
    } else {
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Arama için film/dizi ismi giriniz.",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
