import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/media.dart';

class ArticleEntity extends Equatable {
  final int aId;
  final String aSection;
  final String aTitle;
  final String aAbstract;
  final String aByline;
  final String aUrl;
  final DateTime aUpdatedAt;
  final DateTime aPublishedDate;
  final List<MediaEntity> aMultimedia;
  const ArticleEntity({
    this.aId = 0,
    required this.aSection,
    required this.aTitle,
    required this.aAbstract,
    required this.aByline,
    required this.aUrl,
    required this.aUpdatedAt,
    required this.aPublishedDate,
    required this.aMultimedia,
  });

  MediaEntity smallImgUrl() {
    try {
      return aMultimedia.reduce(
        (a, b) => (a.mHeight * a.mWidth < b.mHeight * b.mWidth) ? a : b,
      );
    } catch (e) {
      return const MediaEntity(mUrl: '');
    }
  }

  MediaEntity largImgUrl() {
    try {
      return aMultimedia.reduce(
        (a, b) => (a.mHeight * a.mWidth > b.mHeight * b.mWidth) ? a : b,
      );
    } catch (e) {
      return const MediaEntity(mUrl: '');
    }
  }

  @override
  List<Object?> get props {
    return [
      aTitle,
      aAbstract,
      aByline,
      aUrl,
      aMultimedia,
    ];
  }
}
