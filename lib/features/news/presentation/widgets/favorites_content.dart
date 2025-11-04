// lib/features/news/presentation/widgets/favorites_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_event.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_state.dart';
import 'package:news_app/features/news/presentation/widgets/news_list_item.dart';
import 'package:news_app/features/news/presentation/widgets/loading_widget.dart';
import 'package:news_app/features/news/presentation/widgets/error_widget.dart';

class FavoritesContent extends StatelessWidget {
  final FavoritesState state;

  const FavoritesContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is FavoritesLoading) {
      return const LoadingWidget();
    } else if (state is FavoritesError) {
      return CustomErrorWidget(
        message: (state as FavoritesError).message,
        onRetry: () {
          context.read<FavoritesBloc>().add(const LoadFavorites());
        },
      );
    } else if (state is FavoritesEmpty) {
      return const CustomErrorWidget(
        message: 'No favorite articles yet',
        onRetry: null,
      );
    } else if (state is FavoritesSuccess) {
      final successState = state as FavoritesSuccess;
      return RefreshIndicator(
        onRefresh: () async {
          context.read<FavoritesBloc>().add(const RefreshFavorites());
        },
        child: ListView.builder(
          itemCount: successState.articles.length,
          itemBuilder: (context, index) {
            final article = successState.articles[index];
            return NewsListItem(
              article: article,
              onTap: () {
                // TODO: Navigate to detail page
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