import 'package:news_app/core/use_cases/use_cases.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class RemoveSetionArticlesFromCacheUseCase
    extends UseCases<Future<bool>, String> {
  final ArticleRepository _articleRepository;
  RemoveSetionArticlesFromCacheUseCase(this._articleRepository);

  @override
  Future<bool> call({String? params}) async {
    return await _articleRepository.removeSetionArticlesFromCache(params ?? '');
  }
}
