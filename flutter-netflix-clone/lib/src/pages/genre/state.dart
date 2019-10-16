part of netflix;

class GenreState extends State<Genre> {
  StreamController _streamController;
  ScrollController _scrollController;
  final String host = 'http://188.227.209.89:90';
  int listLength = 0;
  int movieAmount = 0;
  @override
  void initState() {
    _streamController = new StreamController();
    _scrollController = new ScrollController();
    fetchMovie(0, 15).then((res) async {
      _streamController.add(res);
      movieAmount = res[0].movieAmountByGenre;
      return res;
    });

    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
       fetchMovie(0, listLength+15).then((res) async {
      _streamController.add(res);
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
                      child: GridView.builder(
                        controller: _scrollController,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 5),
                itemCount: snapshot.data.length+1,
                itemBuilder: (BuildContext context, int index) {
                  listLength = snapshot.data.length;
                  if(index == snapshot.data.length){
                    if(movieAmount == index){
                      return Center(child: Text("Liste Bitti", style: TextStyle(color: Colors.white),),);
                    }
                    else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }else{
                    return InkWell(
                    onTap: () => goToDetail(snapshot.data[index], 99),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 4, 3, 4),
                      width: 120.0,
                      height: 140.0,
                      child: Image.network(snapshot.data[index].image,
                          fit: BoxFit.cover),
                    ),
                  );
                  }
                },
              ),
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
        await Client().get("$host/api/${widget.item.toLowerCase()}/$start/$end");
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
