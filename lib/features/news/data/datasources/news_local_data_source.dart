// lib/features/news/data/datasources/news_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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

  /// Checks if article is in favorites
  Future<bool> isArticleFavorite(String articleId);
}

/// Implementation using shared_preferences
class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static const String _favoritesKey = 'favorite_articles';
  final SharedPreferences prefs;

  NewsLocalDataSourceImpl({required this.prefs});

  @override
  Future<List<Article>> getFavoriteArticles() async {
    try {
      final jsonString = prefs.getString(_favoritesKey) ?? '[]';
      final List<dynamic> jsonList = json.decode(jsonString);
      
      return jsonList.map<Article>((json) {
        return Article(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          content: json['content'] as String,
          publishedAt: DateTime.parse(json['publishedAt'] as String),
          imageUrl: json['imageUrl'] as String?,
          source: json['source'] as String,
          isFavorite: true, // All articles from favorites are favorite by definition
        );
      }).toList();
    } catch (e) {
      throw CacheFailure('Failed to load favorites: $e');
    }
  }

  @override
  Future<void> removeFavoriteArticle(Article article) async {
    try {
      final favorites = await getFavoriteArticles();
      final updatedFavorites = favorites.where((fav) => fav.id != article.id).toList();
      await _saveFavorites(updatedFavorites);
    } catch (e) {
      throw CacheFailure('Failed to remove favorite: $e');
    }
  }

  @override
  Future<void> saveFavoriteArticle(Article article) async {
    try {
      final favorites = await getFavoriteArticles();
      
      // Check if article already exists in favorites
      if (favorites.any((fav) => fav.id == article.id)) {
        return; // Already in favorites, no need to add again
      }
      
      final updatedFavorites = [...favorites, article];
      await _saveFavorites(updatedFavorites);
    } catch (e) {
      throw CacheFailure('Failed to save favorite: $e');
    }
  }

  @override
  Future<bool> isArticleFavorite(String articleId) async {
    try {
      final favorites = await getFavoriteArticles();
      return favorites.any((article) => article.id == articleId);
    } catch (e) {
      throw CacheFailure('Failed to check favorite status: $e');
    }
  }

  /// Helper method to save favorites list to shared preferences
  Future<void> _saveFavorites(List<Article> favorites) async {
    try {
      final jsonList = favorites.map((article) {
        return {
          'id': article.id,
          'title': article.title,
          'description': article.description,
          'content': article.content,
          'publishedAt': article.publishedAt.toIso8601String(),
          'imageUrl': article.imageUrl,
          'source': article.source,
        };
      }).toList();

      final jsonString = json.encode(jsonList);
      await prefs.setString(_favoritesKey, jsonString);
    } catch (e) {
      throw CacheFailure('Failed to save favorites: $e');
    }
  }
}