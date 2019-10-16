part of netflix;

class Video extends StatefulWidget {
  final String title;
  final String link;
  Video({Key key, this.title, this.link}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}
