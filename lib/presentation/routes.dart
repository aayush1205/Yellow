import 'package:flutter/material.dart';
// import 'package:movieapp/presentation/journeys/loading/loading_screen.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';

import '../common/constants/route_constants.dart';
import 'journeys/favorite/favorite_screen.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: setting.arguments as MovieDetailArguments,
            ),
        RouteList.initial: (context) => FavoriteScreen(),
      };
}
