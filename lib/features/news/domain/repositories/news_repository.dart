import 'package:news_app/features/news/domain/entities/article.dart';

/// Abstract repository for news operations
abstract class NewsRepository {
  /// Fetches top headlines with optional country, category and search query
  /// Returns list of articles or throws NewsFailure on error
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  });

  /// Adds article to favorites
  /// Throws NewsFailure on error
  Future<void> addToFavorites(Article article);

  /// Removes article from favorites
  /// Throws NewsFailure on error
  Future<void> removeFromFavorites(Article article);

  /// Gets all favorite articles
  /// Returns list of articles or throws NewsFailure on error
  Future<List<Article>> getFavorites();
}