import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/failures/news_failure.dart';
import 'news_list_event.dart';
import 'news_list_state.dart';

/// BLoC for managing news list state
class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final GetTopHeadlines getTopHeadlines;

  NewsListBloc({required this.getTopHeadlines}) : super(NewsListInitial()) {
    on<FetchTopHeadlines>(_onFetchTopHeadlines);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onFetchTopHeadlines(
    FetchTopHeadlines event,
    Emitter<NewsListState> emit,
  ) async {
    try {
      emit(NewsListLoading());
      
      final articles = await getTopHeadlines(
        country: event.country,
        category: event.category,
        query: event.query,
      );

      emit(NewsListSuccess(articles: articles));
    } on NewsFailure catch (e) {
      emit(NewsListError(e.message));
    } catch (e) {
      emit(const NewsListError('An unexpected error occurred'));
    }
  }

  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsListState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NewsListSuccess) {
        emit(NewsListSuccess(articles: currentState.articles));
      }

      final articles = await getTopHeadlines(
        country: event.country,
        category: event.category,
        query: event.query,
      );

      emit(NewsListSuccess(articles: articles));
    } on NewsFailure catch (e) {
      emit(NewsListError(e.message));
    } catch (e) {
      emit(const NewsListError('An unexpected error occurred'));
    }
  }
}