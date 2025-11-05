import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  final SourceModel? source;

  ArticleModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => 
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Article toEntity() {
    return Article(
      id: url ?? '', 
      title: title ?? 'No title',
      description: description ?? 'No description',
      content: content ?? 'No content available',
      publishedAt: publishedAt ?? DateTime.now(),
      imageUrl: urlToImage,
      source: source?.name ?? 'Unknown source',
      isFavorite: false,
    );
  }
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String? name;

  SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => 
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}