// lib/core/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/pages/main_layout.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';
import 'package:news_app/features/news/presentation/pages/news_list_page.dart';
import 'package:news_app/features/news/presentation/pages/favorites_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    routes: [
      // Главный маршрут с BottomNavigationBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // Ветка новостей
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'news',
                builder: (context, state) => const NewsListPage(),
                routes: [
                  // Детальная страница внутри ветки новостей
                  GoRoute(
                    path: 'detail',
                    name: 'news_detail',
                    builder: (context, state) {
                      final article = state.extra as Article;
                      return NewsDetailPage(article: article);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Ветка избранного
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                name: 'favorites',
                builder: (context, state) => const FavoritesPage(),
                routes: [
                  // Детальная страница внутри ветки избранного
                  GoRoute(
                    path: 'detail',
                    name: 'favorites_detail',
                    builder: (context, state) {
                      final article = state.extra as Article;
                      return NewsDetailPage(article: article);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}