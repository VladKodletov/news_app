import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/usecases/toggle_favorite.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';
import 'news_detail_event.dart';
import 'news_detail_state.dart';

/// BLoC for managing news detail state
class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final ToggleFavorite toggleFavorite;

  NewsDetailBloc({required this.toggleFavorite}) : super(NewsDetailInitial()) {
    on<LoadArticleDetail>(_onLoadArticleDetail);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadArticleDetail(
    LoadArticleDetail event,
    Emitter<NewsDetailState> emit,
  ) async {
    emit(NewsDetailSuccess(event.article));
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<NewsDetailState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NewsDetailSuccess) {
        final currentArticle = currentState.article;
        
        // Optimistically update UI
        final updatedArticle = currentArticle.copyWith(
          isFavorite: !currentArticle.isFavorite,
        );
        emit(NewsDetailSuccess(updatedArticle));

        // Perform actual toggle operation
        await toggleFavorite(currentArticle);
      }
    } on NewsFailure catch (e) {
      // Revert optimistic update on error
      final currentState = state;
      if (currentState is NewsDetailSuccess) {
        final revertedArticle = currentState.article.copyWith(
          isFavorite: !currentState.article.isFavorite,
        );
        emit(NewsDetailSuccess(revertedArticle));
      }
      emit(NewsDetailError(e.message));
    } catch (e) {
      // Revert optimistic update on error
      final currentState = state;
      if (currentState is NewsDetailSuccess) {
        final revertedArticle = currentState.article.copyWith(
          isFavorite: !currentState.article.isFavorite,
        );
        emit(NewsDetailSuccess(revertedArticle));
      }
      emit(const NewsDetailError('An unexpected error occurred'));
    }
  }
}