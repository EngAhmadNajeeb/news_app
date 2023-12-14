import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getArticles(String section);
}
