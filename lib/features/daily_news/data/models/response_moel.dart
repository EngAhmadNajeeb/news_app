import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
part 'response_moel.g.dart';

@JsonSerializable()
class ResponseModel {
  String status;
  String section;
  @JsonKey(name: 'last_updated')
  String lastUpdated;
  @JsonKey(name: 'num_results')
  int numResults;
  List<ArticleModel> results;
  ResponseModel({
    this.status = '',
    this.section = '',
    this.lastUpdated = '',
    this.numResults = 0,
    this.results = const [],
  });
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
