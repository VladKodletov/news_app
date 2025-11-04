import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// States for FavoritesBloc
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

/// Initial state
class FavoritesInitial extends FavoritesState {}

/// Loading state
class FavoritesLoading extends FavoritesState {}

/// Success state with favorite articles
class FavoritesSuccess extends FavoritesState {
  final List<Article> articles;

  const FavoritesSuccess(this.articles);

  @override
  List<Object> get props => [articles];
}

/// Empty state (no favorites)
class FavoritesEmpty extends FavoritesState {}

/// Error state
class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}