import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/constants/constants.dart';
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
      final params = <String, String>{
        'apiKey': apiKey,
        'country': country ?? 'us',
        if (category != null && category.isNotEmpty) 'category': category,
        if (query != null && query.isNotEmpty) 'q': query,
      };

      final uri = Uri.https(
          AppConstants.newsApiBaseUrl, AppConstants.newsApiPath, params);
      final response = await client.get(uri);

      // Handle different status codes
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final newsResponse = NewsResponseModel.fromJson(jsonResponse);

        final validArticles = newsResponse.articles
                ?.where((article) =>
                    article.title != null && article.title!.isNotEmpty)
                .toList() ??
            [];

        return NewsResponseModel(
          status: newsResponse.status,
          totalResults: validArticles.length,
          articles: validArticles,
        );
      } else if (response.statusCode == 400) {
        throw const ServerFailure(
            'The request was unacceptable, often due to a missing or misconfigured parameter');
      } else if (response.statusCode == 401) {
        throw const ServerFailure('Invalid API key');
      } else if (response.statusCode == 429) {
        throw const ServerFailure('Too many requests - rate limit exceeded');
      } else if (response.statusCode >= 500) {
        throw ServerFailure('Server error: ${response.statusCode}');
      } else {
        throw ServerFailure('Failed to load news: ${response.statusCode}');
      }
    } on http.ClientException catch (_) {
      throw const NetworkFailure(AppConstants.networkErrorMessage);
    } on FormatException catch (_) {
      throw const ServerFailure(AppConstants.networkErrorMessage);
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw const ServerFailure(AppConstants.unexpectedErrorMessage);
    }
  }
}
