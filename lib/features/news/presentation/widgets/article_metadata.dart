import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleMetadata extends StatelessWidget {
  final Article article;

  const ArticleMetadata({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormatter.formatRelativeTime(article.publishedAt),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          article.source,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        if (article.isFavorite)
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 16,
          ),
      ],
    );
  }
}
