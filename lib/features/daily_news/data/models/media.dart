import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/daily_news/domain/entities/media.dart';
part 'media.g.dart';

@JsonSerializable(includeIfNull: false)
// ignore: must_be_immutable
class MediaModel extends MediaEntity {
  @JsonKey(includeFromJson: false)
  int id;
  final String type;
  final int height;
  final int width;
  final String url;
  MediaModel({
    this.id = 0,
    this.type = '',
    this.height = 0,
    this.width = 0,
    this.url = '',
  }) : super(mId: id, mType: type, mHeight: height, mWidth: width, mUrl: url);

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
