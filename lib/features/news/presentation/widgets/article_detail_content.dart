import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleDetailContent extends StatelessWidget {
  final Article article;

  const ArticleDetailContent({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.source,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                DateFormatter.formatDetailedDate(article.publishedAt),
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (article.imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.article,
                      size: 64,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            article.content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
