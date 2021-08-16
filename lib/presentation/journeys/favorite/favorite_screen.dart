import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/tables/movie_table.dart';
import '../../../common/constants/size_constants.dart';
import '../../themes/theme_color.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../di/get_it.dart';
import '../../blocs/favorite/favorite_cubit.dart';
import 'favorite_movie_grid_view.dart';
import '../../journeys/search_movie/custom_search_movie_delegate.dart';
import '../../blocs/search_movie/search_movie_cubit.dart';
import '../../../presentation/create_movie_dialog.dart';
import '../../../presentation/widgets/movie_app_bar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteCubit _favoriteBloc;
  late SearchMovieCubit searchMovieCubit;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getItInstance<FavoriteCubit>();
    _favoriteBloc.loadFavoriteMovie();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
  }

  @override
  void dispose() {
    _favoriteBloc.close();
    super.dispose();
    searchMovieCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => searchMovieCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Watched Movies",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            BlocBuilder<SearchMovieCubit, SearchMovieState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        BlocProvider.of<SearchMovieCubit>(context),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: AppColor.vulcan,
                    size: Sizes.dimen_12.h,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CreateMovieDialog(
                  onClickedDone: addTransaction,
                ),
              ),
              icon: Icon(
                Icons.add,
                color: AppColor.vulcan,
                size: Sizes.dimen_12.h,
              ),
            ),
          ],
        ),
        body: BlocProvider.value(
          value: _favoriteBloc,
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteMoviesLoaded) {
                if (state.movies.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "No Favourite Movies",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }
                return FavoriteMovieGridView(
                  movies: state.movies,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

Future addTransaction(int id, String title, String posterPath) async {
  MovieTable movie = MovieTable(id: id, title: title, posterPath: posterPath);
  MovieLocalDataSource dataSource = MovieLocalDataSourceImpl();
  dataSource.saveMovie(movie);
}
