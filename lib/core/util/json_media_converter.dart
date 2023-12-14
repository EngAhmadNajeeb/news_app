import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/features/daily_news/data/models/media.dart';
import 'package:objectbox/objectbox.dart';

class JsonMediaConverter
    extends JsonConverter<ToMany<MediaModel>, List<dynamic>?> {
  const JsonMediaConverter();
  @override
  ToMany<MediaModel> fromJson(List? json) {
    List<MediaModel> mediaList = json
            ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [];
    ToMany<MediaModel> multimedia = ToMany<MediaModel>();
    for (var element in mediaList) {
      multimedia.add(element);
    }
    return multimedia;
  }

  @override
  List<Map<String, dynamic>> toJson(ToMany<MediaModel> object) {
    return object.map((x) => x.toJson()).toList();
  }
}
