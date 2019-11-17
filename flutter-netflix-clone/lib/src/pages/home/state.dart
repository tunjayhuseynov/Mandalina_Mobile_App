part of netflix;

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    controller = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: TabBar(
        labelStyle: TextStyle(fontSize: 10.0),
        indicatorWeight: 0.1,
        controller: controller,
        tabs: <Widget>[
          Container( height: 55,child: Tab(text: 'Film', icon: Icon(Icons.movie_filter, size: 18,)),),
          Container( height: 55,child: Tab(text: 'Dizi', icon: Icon(Icons.format_list_numbered, size: 18,)),),
          Container( height: 55,child: Tab(text: 'Arama', icon: Icon(Icons.search, size: 18,)),),
        ],
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Summary(1),
          Summary(2),
          Search(),
        ],
      ),
    );
  }
}
