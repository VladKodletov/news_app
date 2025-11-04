import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_asets.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article_image.dart';
import 'package:news_app/features/news/presentation/widgets/article_metadata.dart';

class NewsListItem extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final bool isFavoritePage;

  const NewsListItem({
    super.key,
    required this.article,
    required this.onTap,
    required this.isFavoritePage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: ArticleImage(article: article),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              article.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (isFavoritePage)
                            SvgPicture.asset(
                              AppAssets.checkFavoriteIconActive,
                              height: 24,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          article.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ArticleMetadata(article: article),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
