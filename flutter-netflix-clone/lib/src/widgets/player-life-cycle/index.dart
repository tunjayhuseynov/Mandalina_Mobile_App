part of netflix;

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller, bool isLoaded);

class PlayerLifeCycle extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoWidgetBuilder childBuilder;

  PlayerLifeCycle(this.controller, this.childBuilder, {Key key})
      : super(key: key);

  @override
  PlayerLifeCycleState createState() => PlayerLifeCycleState();
}
