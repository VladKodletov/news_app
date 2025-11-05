import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/usecases/get_favorites.dart';
import 'package:news_app/features/news/domain/usecases/toggle_favorite.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

/// BLoC for managing favorites state
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final ToggleFavorite toggleFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.toggleFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RefreshFavorites>(_onRefreshFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    await _loadFavorites(emit);
  }

  Future<void> _onRefreshFavorites(
    RefreshFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    await _loadFavorites(emit);
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is FavoritesSuccess) {
        final articleToRemove = currentState.articles
            .firstWhere((article) => article.id == event.articleId);
        
        final updatedArticles = currentState.articles
            .where((article) => article.id != event.articleId)
            .toList();
        
        if (updatedArticles.isEmpty) {
          emit(FavoritesEmpty());
        } else {
          emit(FavoritesSuccess(updatedArticles));
        }

        await toggleFavorite(articleToRemove);
      }
    } on NewsFailure catch (e) {
      await _loadFavorites(emit);
      emit(FavoritesError(e.message));
    } catch (e) {
      await _loadFavorites(emit);
      emit(const FavoritesError('An unexpected error occurred'));
    }
  }

  Future<void> _loadFavorites(Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      
      final articles = await getFavorites();
      
      if (articles.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesSuccess(articles));
      }
    } on NewsFailure catch (e) {
      emit(FavoritesError(e.message));
    } catch (e) {
      emit(const FavoritesError('An unexpected error occurred'));
    }
  }
}