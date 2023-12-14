import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getArticles(String section);
  List<ArticleEntity> getSavedArticles();
  bool saveLocalArticle(ArticleEntity article);
  bool removeLocalArticle(ArticleEntity article);
  ArticleEntity? checkIsArticleInArchiveUseCase(String title);
  Future<bool> removeSetionArticlesFromCache(String section);
}
