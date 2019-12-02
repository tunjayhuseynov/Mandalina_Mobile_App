library netflix;

// Dart Imports
import 'dart:async';
import 'dart:convert';
import 'dart:io';
// Flutter imports
import 'package:http/http.dart' show Client;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Plugins import...
import 'package:fluro/fluro.dart';
import 'package:video_player/video_player.dart';

// Router
part 'src/helpers/config/constants.dart';
part 'src/helpers/config/application.dart';
part 'src/helpers/config/routes.dart';
part 'src/helpers/config/route_handlers.dart';

// Models
part 'src/models/episode.dart';
part 'src/models/result.dart';
part 'src/models/item_model.dart';
part 'src/models/genre_result.dart';

// Blocs
part 'src/blocs/movies_bloc.dart';

// Resources
part 'src/resources/movie_api_provider.dart';
part 'src/resources/repository.dart';
part 'src/pages/video/index.dart';
part 'src/pages/video/state.dart';
part 'src/pages/home/index.dart';
part 'src/pages/home/state.dart';
part 'src/pages/summary/index.dart';
part 'src/pages/summary/state.dart';
part 'src/pages/detail/index.dart';
part 'src/pages/detail/state.dart';
part 'src/pages/search/state.dart';
part 'src/pages/search/index.dart';
part 'src/pages/genre/index.dart';
part 'src/pages/genre/state.dart';

// Widgets
part 'src/widgets/tvshow-list/index.dart';
part 'src/widgets/player-life-cycle/index.dart';
part 'src/widgets/player-life-cycle/state.dart';
part 'src/widgets/player-controls/index.dart';
part 'src/widgets/player-controls/state.dart';

class Netflix extends StatelessWidget {
  Netflix({Key key}) : super(key: key) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    bloc.fetchSuggestedMovie();
    bloc.fetchSuggestedSeries();
  }

  load() async {
    var file = await DefaultCacheManager().getFilePath();
    var folder = File(file);
    print(folder.lengthSync());
    print(file);
  }

  @override
  Widget build(BuildContext context) {
    load();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.black,
      ),
      onGenerateRoute: Application.router.generator,
      home: Home(),
    );
  }
}
