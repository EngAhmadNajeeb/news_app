import 'package:news_app/core/use_cases/use_cases.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class SaveLocalArticleUseCase extends UseCases<bool, ArticleEntity> {
  final ArticleRepository _articleRepository;
  SaveLocalArticleUseCase(this._articleRepository);

  @override
  bool call({ArticleEntity? params}) {
    return _articleRepository.saveLocalArticle(params!);
  }
}
