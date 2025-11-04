import 'package:news_app/features/news/domain/entities/article.dart';

part 'article_model.g.dart';

/// Article model for JSON serialization/deserialization
@JsonSerializable()
class ArticleModel {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String content;
  final SourceModel source;

  ArticleModel({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  /// Converts model to entity
  Article toEntity() {
    return Article(
      id: url, // Using URL as unique ID since NewsAPI doesn't provide ID
      title: title,
      description: description,
      content: content,
      publishedAt: publishedAt,
      imageUrl: urlToImage,
      source: source.name,
      isFavorite: false, // Default value, will be set by repository
    );
  }
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String name;

  SourceModel({
    this.id,
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}