import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/data/models/media.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/entities/media.dart';
import 'package:objectbox/objectbox.dart';
import 'package:url_launcher/url_launcher.dart';

class GenFunc {
  static Future<void> launchUrl1(String url) async {
    Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  static List<MediaEntity> fromToManyToListMediaEntities(
      ToMany<MediaModel> media) {
    List<MediaEntity> multimedia = [];
    for (var element in media) {
      multimedia.add(element);
    }
    return multimedia;
  }

  static MediaModel mediaEntityToModel(MediaEntity entity) {
    return MediaModel(
      id: entity.mId,
      type: entity.mType,
      height: entity.mHeight,
      width: entity.mWidth,
      url: entity.mUrl,
    );
  }

  static ArticleModel articleEntityToModel(ArticleEntity entity) {
    return ArticleModel(
      id: entity.aId,
      title: entity.aTitle,
      abstract: entity.aAbstract,
      byline: entity.aByline,
      url: entity.aUrl,
      updatedDate: entity.aUpdatedAt,
      publishedDate: entity.aPublishedDate,
      multimedia: ToMany<MediaModel>(),
    );
  }
}
