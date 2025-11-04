import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/presentation/bloc/news_list/news_list_state.dart';
import 'package:news_app/features/news/presentation/widgets/news_list_item.dart';
import 'package:news_app/features/news/presentation/widgets/loading_widget.dart';
import 'package:news_app/features/news/presentation/widgets/error_widget.dart';

class NewsListContent extends StatelessWidget {
  final NewsListState state;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;

  const NewsListContent({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onRefresh,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (state is NewsListLoading) {
      return const LoadingWidget();
    } else if (state is NewsListError) {
      return CustomErrorWidget(
        message: (state as NewsListError).message,
        onRetry: onRetry,
      );
    } else if (state is NewsListSuccess) {
      final successState = state as NewsListSuccess;
      if (successState.articles.isEmpty) {
        return const CustomErrorWidget(
          message: 'No news found',
          onRetry: null,
        );
      }
      return RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView.builder(
          controller: scrollController,
          itemCount: successState.articles.length,
          itemBuilder: (context, index) {
            final article = successState.articles[index];
            return NewsListItem(
              isFavoritePage: false,
              article: article,
              onTap: () {
                context.push('/detail', extra: article);
              },
            );
          },
        ),
      );
    } else {
      return const LoadingWidget();
    }
  }
}
