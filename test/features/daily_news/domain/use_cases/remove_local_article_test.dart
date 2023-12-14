import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/remove_local_article.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late RemoveLocalArticleUseCase usecase;
  late MockArticleRepository mockArticleRepository;
  late ArticleEntity article1;
  late ArticleEntity article2;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = RemoveLocalArticleUseCase(mockArticleRepository);
    article1 = ArticleEntity(
      aId: 1,
      aSection: 'Section',
      aTitle: 'Title1',
      aAbstract: 'Abstract',
      aByline: 'Byline',
      aUrl: 'Url',
      aUpdatedAt: DateTime.now(),
      aPublishedDate: DateTime.now(),
      aMultimedia: const [],
    );
    article2 = ArticleEntity(
      aId: -1,
      aSection: 'Section',
      aTitle: 'Title2',
      aAbstract: 'Abstract',
      aByline: 'Byline',
      aUrl: 'Url',
      aUpdatedAt: DateTime.now(),
      aPublishedDate: DateTime.now(),
      aMultimedia: const [],
    );
  });
  group('remove the article from the archive', () {
    test('Should return true when remove the article successfully.', () {
      when(() => mockArticleRepository.removeLocalArticle(article1))
          .thenAnswer((_) => true);
      final successResult = usecase(params: article1);

      expect(successResult, true);
      verify(() => mockArticleRepository.removeLocalArticle(article1));
      verifyNoMoreInteractions(mockArticleRepository);
    });

    test('Should return false when remove the article fails', () {
      when(() => mockArticleRepository.removeLocalArticle(article2))
          .thenAnswer((_) => false);
      final failedResult = usecase(params: article2);

      expect(failedResult, false);
      verify(() => mockArticleRepository.removeLocalArticle(article2));
      verifyNoMoreInteractions(mockArticleRepository);
    });
  });
}
