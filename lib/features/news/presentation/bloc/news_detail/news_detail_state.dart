import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// States for NewsDetailBloc
abstract class NewsDetailState extends Equatable {
  const NewsDetailState();

  @override
  List<Object> get props => [];
}

/// Initial state
class NewsDetailInitial extends NewsDetailState {}

/// Loading state
class NewsDetailLoading extends NewsDetailState {}

/// Success state with article
class NewsDetailSuccess extends NewsDetailState {
  final Article article;

  const NewsDetailSuccess(this.article);

  @override
  List<Object> get props => [article];
}

/// Error state
class NewsDetailError extends NewsDetailState {
  final String message;

  const NewsDetailError(this.message);

  @override
  List<Object> get props => [message];
}