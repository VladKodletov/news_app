import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/image_placeholder.dart';

class ArticleImage extends StatelessWidget {
  final Article article;

  const ArticleImage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    if (article.imageUrl != null) {
      return Image.network(
        article.imageUrl!,
        // width: 60,
        height: double.infinity,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return const ImagePlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    }
    return const ImagePlaceholder();
  }
}
