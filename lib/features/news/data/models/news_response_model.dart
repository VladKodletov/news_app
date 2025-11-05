import 'package:json_annotation/json_annotation.dart';
import 'article_model.dart';

part 'news_response_model.g.dart';

@JsonSerializable()
class NewsResponseModel {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  NewsResponseModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => 
      _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}