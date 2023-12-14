import 'package:news_app/core/use_cases/use_cases.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class CheckIsArticleInArchiveUseCase extends UseCases<ArticleEntity?, String> {
  final ArticleRepository _articleRepository;
  CheckIsArticleInArchiveUseCase(this._articleRepository);

  @override
  ArticleEntity? call({String? params}) {
    return _articleRepository.checkIsArticleInArchiveUseCase(params ?? '');
  }
}
