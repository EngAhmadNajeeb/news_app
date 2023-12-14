import 'package:news_app/core/use_cases/use_cases.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class GetArticleUseCase extends UseCases<Future<List<ArticleEntity>>, String> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({String? params}) async {
    return await _articleRepository.getArticles(params ?? '');
  }
}
