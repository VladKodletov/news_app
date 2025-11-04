import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_detail/news_detail_state.dart';
import 'package:news_app/features/news/presentation/widgets/article_detail_content.dart';
import 'package:news_app/features/news/presentation/widgets/detail_favorite_button.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    context.read<NewsDetailBloc>().add(LoadArticleDetail(article));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            size: 40,
          ),
          onPressed: () => context.pop(),
        ),
        actions: const [
          DetailFavoriteButton(
            height: 41,
          ),
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
    );
  }
}
