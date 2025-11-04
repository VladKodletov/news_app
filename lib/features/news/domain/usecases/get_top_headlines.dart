import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Use case for getting top headlines news
class GetTopHeadlines {
  final NewsRepository repository;

  const GetTopHeadlines(this.repository);

  Future<List<Article>> call({
    String? country,
    String? category,
    String? query,
  }) async {
    return await repository.getTopHeadlines(
      country: country,
      category: category,
      query: query,
    );
  }
}