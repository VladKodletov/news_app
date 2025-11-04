import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// States for NewsListBloc
abstract class NewsListState extends Equatable {
  const NewsListState();

  @override
  List<Object> get props => [];
}

/// Initial state
class NewsListInitial extends NewsListState {}

/// Loading state
class NewsListLoading extends NewsListState {}

/// Success state with articles
class NewsListSuccess extends NewsListState {
  final List<Article> articles;
  final bool hasReachedMax;

  const NewsListSuccess({
    required this.articles,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [articles, hasReachedMax];
}

/// Error state
class NewsListError extends NewsListState {
  final String message;

  const NewsListError(this.message);

  @override
  List<Object> get props => [message];
}