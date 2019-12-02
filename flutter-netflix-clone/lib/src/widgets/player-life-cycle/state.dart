part of netflix;

class PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController get controller => widget.controller;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() { 
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize().then((data){
      setState(() {
        isLoaded = true;
      });
    });
    controller.setLooping(false);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller, isLoaded);
  }
}
