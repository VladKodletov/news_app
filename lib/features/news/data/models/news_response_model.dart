import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

part 'news_response_model.g.dart';
/// Response model for NewsAPI top headlines
@JsonSerializable()
class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}