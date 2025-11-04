// lib/features/news/data/datasources/news_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/features/news/data/models/news_response_model.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';

/// Abstract remote data source for news API
abstract class NewsRemoteDataSource {
  /// Fetches top headlines from NewsAPI
  Future<NewsResponseModel> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  });
}

/// Implementation of NewsRemoteDataSource
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final String apiKey;
  final http.Client client;

  NewsRemoteDataSourceImpl({
    required this.apiKey,
    required this.client,
  });

  @override
  Future<NewsResponseModel> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  }) async {
    try {
      // Build query parameters according to NewsAPI documentation
      final params = <String, String>{
        'apiKey': apiKey,
        if (country != null && country.isNotEmpty) 'country': country,
        if (category != null && category.isNotEmpty) 'category': category,
        if (query != null && query.isNotEmpty) 'q': query,
        'pageSize': '20', // Limit results to 20 articles
      };

      // Make actual HTTP request
      final uri = Uri.https('newsapi.org', '/v2/top-headlines', params);
      final response = await client.get(uri);

      // Handle different status codes
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return NewsResponseModel.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw const ServerFailure('Invalid API key');
      } else if (response.statusCode == 429) {
        throw const ServerFailure('Too many requests - rate limit exceeded');
      } else if (response.statusCode >= 500) {
        throw ServerFailure('Server error: ${response.statusCode}');
      } else {
        throw ServerFailure('Failed to load news: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: $e');
    } on FormatException catch (e) {
      throw ServerFailure('Invalid response format: $e');
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }
}