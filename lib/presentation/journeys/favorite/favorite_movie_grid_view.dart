import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';
import '../../journeys/search_movie/custom_search_movie_delegate.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../domain/entities/movie_entity.dart';
import 'favorite_movie_card_widget.dart';
import '../../blocs/search_movie/search_movie_cubit.dart';

class FavoriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;

  const FavoriteMovieGridView({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          return FavoriteMovieCardWidget(
            movie: movies[index],
          );
        },
      ),
    );
  }
}
