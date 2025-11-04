import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';

/// Abstract local data source for favorite news storage
abstract class NewsLocalDataSource {
  /// Saves article to favorites
  Future<void> saveFavoriteArticle(Article article);

  /// Removes article from favorites
  Future<void> removeFavoriteArticle(Article article);

  /// Gets all favorite articles
  Future<List<Article>> getFavoriteArticles();
}

/// Implementation using shared_preferences (or any other local storage)
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  // TODO: Inject shared_preferences or other storage
  // final SharedPreferences prefs;

  // NewsLocalDataSourceImpl({required this.prefs});

  @override
  Future<List<Article>> getFavoriteArticles() async {
    try {
      // TODO: Implement actual local storage logic
      // Example with shared_preferences:
      // final jsonString = prefs.getString('favorite_articles') ?? '[]';
      // final List<dynamic> jsonList = json.decode(jsonString);
      // return jsonList.map((json) => ArticleModel.fromJson(json).toEntity()).toList();

      await Future.delayed(const Duration(milliseconds: 200));
      
      // Mock data for demonstration
      return [
        Article(
          id: 'favorite_1',
          title: 'Favorite News 1',
          description: 'This is a favorite news',
          content: 'Full content of favorite news',
          publishedAt: DateTime.now().subtract(const Duration(days: 1)),
          imageUrl: 'https://picsum.photos/200',
          source: 'Favorite Source',
          isFavorite: true,
        ),
      ];
    } catch (e) {
      throw CacheFailure('Failed to load favorites: $e');
    }
  }

  @override
  Future<void> removeFavoriteArticle(Article article) async {
    try {
      // TODO: Implement actual removal logic
      // Example:
      // final favorites = await getFavoriteArticles();
      // favorites.removeWhere((fav) => fav.id == article.id);
      // await _saveFavorites(favorites);

      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      throw CacheFailure('Failed to remove favorite: $e');
    }
  }

  @override
  Future<void> saveFavoriteArticle(Article article) async {
    try {
      // TODO: Implement actual save logic
      // Example:
      // final favorites = await getFavoriteArticles();
      // favorites.add(article);
      // await _saveFavorites(favorites);

      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      throw CacheFailure('Failed to save favorite: $e');
    }
  }
}