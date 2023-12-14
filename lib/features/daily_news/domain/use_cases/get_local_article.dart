import 'package:news_app/core/use_cases/use_cases.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class GetLocalArticleUseCase extends UseCases<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;
  GetLocalArticleUseCase(this._articleRepository);

  @override
  List<ArticleEntity> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
