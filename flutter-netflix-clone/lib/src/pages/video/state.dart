part of netflix;

class VideoState extends State<Video> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;
  String link;
  bool isScreenExpended = false;
  @override
  void initState() {
    Wakelock.enable();
    link = widget.link;
    controlVisible = false;
    isScreenExpended = false;
    vcontroller = VideoPlayerController.network(MovieApiProvider.pichost + link);

    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
    autoHide();

  }

  callbackScreenSize() {
    setState(() {
      isScreenExpended = !isScreenExpended;
    });
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
            margin: isScreenExpended
                ? EdgeInsets.fromLTRB(0, 15, 0, 15)
                : EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: PlayerLifeCycle(vcontroller, (BuildContext context,
                VideoPlayerController controller, bool isLoaded) {
              if (isLoaded) {
                return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(vcontroller),
                );
              } else {
                return Center(
                    child: DesignWidget._bar());
              }
            }),
          ),
          GestureDetector(
            child: PlayerControl(
              vcontroller,
              callbackScreenSize,
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
