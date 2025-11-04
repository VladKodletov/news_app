import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_state.dart';

class DetailFavoriteButton extends StatelessWidget {
  const DetailFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailBloc, NewsDetailState>(
      builder: (context, state) {
        if (state is NewsDetailSuccess) {
          IconButton(
            icon: Icon(
              state.article.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: state.article.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              context.read<NewsDetailBloc>().add(const ToggleFavoriteEvent());
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
