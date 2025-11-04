import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/usecases/toggle_favorite.dart';
import 'package:news_app/features/news/domain/usecases/get_favorites.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';

final GetIt sl = GetIt.instance;

class InjectionContainer {
  static Future<void> init() async {
    await _setupExternalDependencies();
    _setupDataSources();
    _setupRepositories();
    _setupUseCases();
    _setupBlocs();
  }

  static Future<void> _setupExternalDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<http.Client>(() => http.Client());

    const newsApiKey = '89478c634d8a4eb9a579c0a42ee9dda1';
    sl.registerLazySingleton<String>(() => newsApiKey,
        instanceName: 'newsApiKey');
  }

  static void _setupDataSources() {
    sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(
        apiKey: sl<String>(instanceName: 'newsApiKey'),
        client: sl<http.Client>(),
      ),
    );

    sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(prefs: sl<SharedPreferences>()),
    );
  }

  static void _setupRepositories() {
    sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(
        remoteDataSource: sl<NewsRemoteDataSource>(),
        localDataSource: sl<NewsLocalDataSource>(),
      ),
    );
  }

  static void _setupUseCases() {
    sl.registerLazySingleton(() => GetTopHeadlines(sl<NewsRepository>()));
    sl.registerLazySingleton(() => ToggleFavorite(sl<NewsRepository>()));
    sl.registerLazySingleton(() => GetFavorites(sl<NewsRepository>()));
  }

  static void _setupBlocs() {
    sl.registerLazySingleton(
      () => NewsListBloc(getTopHeadlines: sl<GetTopHeadlines>()),
    );
    sl.registerLazySingleton(
      () => NewsDetailBloc(toggleFavorite: sl<ToggleFavorite>()),
    );
    sl.registerLazySingleton(
      () => FavoritesBloc(
        getFavorites: sl<GetFavorites>(),
        toggleFavorite: sl<ToggleFavorite>(),
      ),
    );
  }
}
