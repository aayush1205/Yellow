import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/movie_local_data_source.dart';
import '../data/data_sources/movie_remote_data_source.dart';
import '../data/repositories/movie_repository_impl.dart';

import '../domain/repositories/movie_repository.dart';
import '../domain/usecases/check_if_movie_favorite.dart';
import '../domain/usecases/delete_favorite_movie.dart';
import '../domain/usecases/get_favorite_movies.dart';
import '../domain/usecases/get_movie_detail.dart';
import '../domain/usecases/save_movie.dart';
import '../domain/usecases/search_movies.dart';
import '../presentation/blocs/favorite/favorite_cubit.dart';
import '../presentation/blocs/loading/loading_cubit.dart';
import '../presentation/blocs/movie_detail/movie_detail_cubit.dart';
import '../presentation/blocs/search_movie/search_movie_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));

  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            getItInstance(),
            getItInstance(),
          ));

  getItInstance.registerFactory(
    () => MovieDetailCubit(
      loadingCubit: getItInstance(),
      getMovieDetail: getItInstance(),
      favoriteCubit: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieCubit(
      loadingCubit: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => FavoriteCubit(
        saveMovie: getItInstance(),
        checkIfFavoriteMovie: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
      ));
  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
}
