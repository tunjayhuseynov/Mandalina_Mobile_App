part of netflix;

class PlayerControl extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;
  final bool visible;
  final Function() callback;

  PlayerControl(this.controller, this.callback, {this.visible, this.title, Key key}) : super(key: key);

  @override
  PlayerControlState createState() => PlayerControlState();
}
