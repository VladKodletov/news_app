import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Use case for toggling article favorite status
class ToggleFavorite {
  final NewsRepository repository;

  const ToggleFavorite(this.repository);

  Future<void> call(Article article) async {
    if (article.isFavorite) {
      await repository.removeFromFavorites(article);
    } else {
      await repository.addToFavorites(article);
    }
  }
}