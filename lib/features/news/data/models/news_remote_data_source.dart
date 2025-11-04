import 'package:news_app/features/news/data/models/article_model.dart';
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

  NewsRemoteDataSourceImpl({required this.apiKey});

  @override
  Future<NewsResponseModel> getTopHeadlines({
    String? country,
    String? category,
    String? query,
  }) async {
    try {
      // Build query parameters
      final params = <String, dynamic>{
        'apiKey': apiKey,
        if (country != null) 'country': country,
        if (category != null) 'category': category,
        if (query != null && query.isNotEmpty) 'q': query,
      };

      // TODO: Implement actual HTTP request
      // This is a placeholder - you would use http/dio package here
      // Example:
      // final response = await http.get(
      //   Uri.https('newsapi.org', '/v2/top-headlines', params),
      // );
      //
      // if (response.statusCode == 200) {
      //   return NewsResponseModel.fromJson(
      //     json.decode(response.body),
      //   );
      // } else {
      //   throw ServerFailure('Failed to load news: ${response.statusCode}');
      // }

      // Mock response for now
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Simulate error for demonstration
      if (query == 'error') {
        throw const ServerFailure('Simulated server error');
      }

      // Return mock data
      return NewsResponseModel(
        status: 'ok',
        totalResults: 2,
        articles: [
          ArticleModel(
            title: 'Sample News 1',
            description: 'This is a sample news description',
            url: 'https://example.com/1',
            urlToImage: 'https://picsum.photos/200',
            publishedAt: DateTime.now(),
            content: 'Full content of sample news 1',
            source: SourceModel(name: 'Sample Source 1'),
          ),
          ArticleModel(
            title: 'Sample News 2',
            description: 'This is another sample news description',
            url: 'https://example.com/2',
            urlToImage: null,
            publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
            content: 'Full content of sample news 2',
            source: SourceModel(name: 'Sample Source 2'),
          ),
        ],
      );
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw ServerFailure('Network error: $e');
    }
  }
}