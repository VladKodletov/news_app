// lib/features/news/data/repositories/news_repository_impl.dart
import 'package:news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Implementation of NewsRepository
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  }) async {
    try {
      final response = await remoteDataSource.getTopHeadlines(
        country: country,
        category: category,
        query: query,
      );

      // Convert models to entities
      final articles = response.articles
              ?.map((model) => model.toEntity())
              .where((article) => article.isValid)
              .toList() ??
          [];

      // Mark favorites
      return await _markFavorites(articles);
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw NetworkFailure('Failed to fetch news: $e');
    }
  }

  @override
  Future<void> addToFavorites(Article article) async {
    try {
      await localDataSource.saveFavoriteArticle(article);
    } on CacheFailure {
      rethrow;
    } catch (e) {
      throw CacheFailure('Failed to add to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(Article article) async {
    try {
      await localDataSource.removeFavoriteArticle(article);
    } on CacheFailure {
      rethrow;
    } catch (e) {
      throw CacheFailure('Failed to remove from favorites: $e');
    }
  }

  @override
  Future<List<Article>> getFavorites() async {
    try {
      return await localDataSource.getFavoriteArticles();
    } on CacheFailure {
      rethrow;
    } catch (e) {
      throw CacheFailure('Failed to get favorites: $e');
    }
  }

  /// Helper method to mark articles as favorite based on local storage
  Future<List<Article>> _markFavorites(List<Article> articles) async {
    try {
      final List<Article> updatedArticles = [];

      for (final article in articles) {
        final isFavorite = await localDataSource.isArticleFavorite(article.id);
        updatedArticles.add(article.copyWith(isFavorite: isFavorite));
      }

      return updatedArticles;
    } catch (e) {
      // If we can't get favorites, return articles without favorite marks
      return articles;
    }
  }
}
