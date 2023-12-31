import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/core/util/general_function.dart';
import 'package:news_app/core/util/json_media_converter.dart';
import 'package:news_app/features/daily_news/data/models/media.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:objectbox/objectbox.dart';

part 'article.g.dart';

@JsonSerializable(converters: [JsonMediaConverter()])
@Entity()
// ignore: must_be_immutable
class ArticleModel extends ArticleEntity {
  @JsonKey(includeFromJson: false)
  int id;
  final String section;
  final String title;
  final String abstract;
  final String byline;
  final String url;
  @JsonKey(name: 'updated_date')
  final DateTime? updatedDate;
  @JsonKey(name: 'published_date')
  final DateTime? publishedDate;
  @Backlink()
  @JsonMediaConverter()
  ToMany<MediaModel> multimedia = ToMany<MediaModel>();
  ArticleModel({
    this.id = 0,
    this.section = '',
    this.title = '',
    this.abstract = '',
    this.byline = '',
    this.url = '',
    this.updatedDate,
    this.publishedDate,
    required this.multimedia,
  }) : super(
          aId: id,
          aSection: section,
          aTitle: title,
          aAbstract: abstract,
          aByline: byline,
          aUrl: url,
          aUpdatedAt: updatedDate ?? DateTime.now(),
          aPublishedDate: publishedDate ?? DateTime.now(),
          aMultimedia: GenFunc.fromToManyToListMediaEntities(multimedia),
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
