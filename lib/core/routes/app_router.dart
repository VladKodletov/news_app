// lib/core/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/pages/news_list_page.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';
import 'package:news_app/features/news/presentation/pages/favorites_page.dart';

/// App router configuration
class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'news_list',
        builder: (context, state) => const NewsListPage(),
        routes: [
          GoRoute(
            path: 'detail',
            name: 'news_detail',
            builder: (context, state) {
              final article = state.extra as Article;
              return NewsDetailPage(article: article);
            },
          ),
          GoRoute(
            path: 'favorites',
            name: 'favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
        ],
      ),
    ],
  );
}