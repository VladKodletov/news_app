import 'package:equatable/equatable.dart';

/// Events for FavoritesBloc
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

/// Event to load favorite articles
class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

/// Event to refresh favorites
class RefreshFavorites extends FavoritesEvent {
  const RefreshFavorites();
}

/// Event to remove article from favorites
class RemoveFromFavorites extends FavoritesEvent {
  final String articleId;

  const RemoveFromFavorites(this.articleId);

  @override
  List<Object> get props => [articleId];
}