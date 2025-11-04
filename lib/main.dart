// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection_container.dart';
import 'package:news_app/core/routes/app_router.dart';
import 'package:news_app/features/news/domain/usecases/get_favorites.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/usecases/toggle_favorite.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_bloc.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await InjectionContainer.init();
  
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
      BlocProvider<NewsListBloc>(
          create: (context) => sl<NewsListBloc>(),
        ),
        BlocProvider<NewsDetailBloc>(
          create: (context) => sl<NewsDetailBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => sl<FavoritesBloc>(),
        ),
      ],
      child: 
      MaterialApp.router(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}