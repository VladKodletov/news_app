import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Use case for getting favorite articles
class GetFavorites {
  final NewsRepository repository;

  const GetFavorites(this.repository);

  Future<List<Article>> call() async {
    return await repository.getFavorites();
  }
}