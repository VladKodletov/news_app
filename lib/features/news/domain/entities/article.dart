import 'package:equatable/equatable.dart';

/// Article entity representing a news article
class Article extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final DateTime publishedAt;
  final String? imageUrl;
  final String source;
  final bool isFavorite;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.publishedAt,
    this.imageUrl,
    required this.source,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        content,
        publishedAt,
        imageUrl,
        source,
        isFavorite,
      ];

  /// Creates a copy of the article with updated fields
  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    DateTime? publishedAt,
    String? imageUrl,
    String? source,
    bool? isFavorite,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      publishedAt: publishedAt ?? this.publishedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      source: source ?? this.source,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}