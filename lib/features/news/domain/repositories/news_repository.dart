import 'package:news_app/features/news/domain/entities/article.dart';

/// Abstract repository for news operations
abstract class NewsRepository {
  /// Fetches top headlines with optional country, category and search query
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  });

  /// Adds article to favorites
  /// Throws NewsFailure on error
  Future<void> addToFavorites(Article article);

  /// Removes article from favorites
  Future<void> removeFromFavorites(Article article);

  /// Gets all favorite articles
  Future<List<Article>> getFavorites();
}