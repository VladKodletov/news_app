// lib/features/news/presentation/bloc/news_detail/news_detail_event.dart
import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// Events for NewsDetailBloc
abstract class NewsDetailEvent extends Equatable {
  const NewsDetailEvent();

  @override
  List<Object> get props => [];
}

/// Event to load article details
class LoadArticleDetail extends NewsDetailEvent {
  final Article article;

  const LoadArticleDetail(this.article);

  @override
  List<Object> get props => [article];
}

/// Event to toggle favorite status - ИЗМЕНЕНО ИМЯ
class ToggleFavoriteEvent extends NewsDetailEvent {
  const ToggleFavoriteEvent();

  @override
  List<Object> get props => [];
}