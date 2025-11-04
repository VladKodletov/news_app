import 'package:equatable/equatable.dart';

/// Events for NewsListBloc
abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch top headlines
class FetchTopHeadlines extends NewsListEvent {
  final String? country;
  final String? category;
  final String? query;

  const FetchTopHeadlines({
    this.country,
    this.category,
    this.query,
  });

  @override
  List<Object> get props => [country ?? '', category ?? '', query ?? ''];
}

/// Event to refresh news (pull-to-refresh)
class RefreshNews extends NewsListEvent {
  final String? country;
  final String? category;
  final String? query;

  const RefreshNews({
    this.country,
    this.category,
    this.query,
  });

  @override
  List<Object> get props => [country ?? '', category ?? '', query ?? ''];
}