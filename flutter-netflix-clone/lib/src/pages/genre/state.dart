part of netflix;

class GenreState extends State<Genre> {
  StreamController _streamController;
  ScrollController _scrollController;
  int movieAmount = 0;
  List<Result> movieList = new List();
  @override
  void initState() {
    _streamController = new StreamController();
    _scrollController = new ScrollController();
    fetchMovie(0, 15).then((res) async {
      _streamController.add(res);
      movieList.addAll(res);
      movieAmount = res[0].movieAmountByGenre;
      return res;
    });

    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
       fetchMovie(movieList.length , movieList.length + 15).then((res) async {
      _streamController.add(res);
      movieList.addAll(res);
      return null;
    });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.item.replaceAll("_", " ")),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      child: movieList.length != 0?GridView.builder(
                        controller: _scrollController,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 5),
                itemCount: movieList.length,
                itemBuilder: (BuildContext context, int index) {

                    return InkWell(
                    onTap: () => goToDetail(movieList[index], 99),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 4, 3, 4),
                      width: 120.0,
                      height: 140.0,
                      child: Image.network(pichost + movieList[index].image,
                          fit: BoxFit.cover),
                    ),
                  );
                }
              ): Center(child: new Text("Maalesef bu türde henüz film/dizi yok", style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              );
            }
          else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(child: CircularProgressIndicator(),);
          },
        ));
  }

  Future fetchMovie(int start, int end) async {
    final response =
        await Client().get("$pichost/api/${widget.item.toLowerCase()}/$start/$end");
    if (response.statusCode == 200) {
            String body  = response.body;
      if(!response.body.endsWith(']')){
        body += ']';
      }
      List<Result> _results = List.from(json.decode(body))
          .map(
            (r) => Result.fromJson(r),
          )
          .toList();

      return _results;
    }
  }
}
