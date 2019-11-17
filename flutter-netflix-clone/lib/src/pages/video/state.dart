part of netflix;

class VideoState extends State<Video> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;
  String link;
  @override
  void initState() {
    Wakelock.enable();
    link = widget.link;
    controlVisible = false;
    vcontroller = VideoPlayerController.network(pichost + link);
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //statusBarColor: Colors.black,
    //));
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
    autoHide();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    Wakelock.disable();
    vcontroller?.dispose();
    timer?.cancel();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = .75;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            //margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
            child: PlayerLifeCycle(vcontroller, (BuildContext context,
                VideoPlayerController controller, bool isLoaded) {
              if (isLoaded) {
                return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(vcontroller),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(219, 0, 0, 1.0)),
                ));
              }
            }),
          ),
          GestureDetector(
            child: PlayerControl(
              vcontroller,
              visible: controlVisible,
              title: widget.title,
            ),
            onTap: handlerGesture,
          ),
        ],
      ),
    );
  }
}
