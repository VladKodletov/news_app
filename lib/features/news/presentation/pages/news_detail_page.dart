import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_state.dart';
import 'package:news_app/features/news/presentation/widgets/article_detail_content.dart';
import 'package:news_app/features/news/presentation/widgets/favorite_button.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsDetailBloc(
        toggleFavorite: context.read(),
      )..add(LoadArticleDetail(article)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Detail'),
          actions: const [
            DetailFavoriteButton(),
          ],
        ),
        body: BlocBuilder<NewsDetailBloc, NewsDetailState>(
          builder: (context, state) {
            if (state is NewsDetailSuccess) {
              return ArticleDetailContent(article: state.article);
            } else if (state is NewsDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}