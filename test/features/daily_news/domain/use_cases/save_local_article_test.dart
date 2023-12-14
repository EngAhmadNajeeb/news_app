import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/save_local_article.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late SaveLocalArticleUseCase usecase;
  late MockArticleRepository mockArticleRepository;
  late ArticleEntity article1;
  late ArticleEntity article2;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = SaveLocalArticleUseCase(mockArticleRepository);
    article1 = ArticleEntity(
      aId: 0,
      aSection: 'Section',
      aTitle: 'Title',
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
      aTitle: 'Title',
      aAbstract: 'Abstract',
      aByline: 'Byline',
      aUrl: 'Url',
      aUpdatedAt: DateTime.now(),
      aPublishedDate: DateTime.now(),
      aMultimedia: const [],
    );
  });
  group('Saving article to the archive', () {
    test('Should return true when saving the article successfully.', () {
      when(() => mockArticleRepository.saveLocalArticle(article1))
          .thenAnswer((_) => true);
      final successResult = usecase(params: article1);

      expect(successResult, true);
      verify(() => mockArticleRepository.saveLocalArticle(article1));
      verifyNoMoreInteractions(mockArticleRepository);
    });

    test('Should return false when saving the article fails', () {
      when(() => mockArticleRepository.saveLocalArticle(article2))
          .thenAnswer((_) => false);
      final failedResult = usecase(params: article2);

      expect(failedResult, false);
      verify(() => mockArticleRepository.saveLocalArticle(article2));
      verifyNoMoreInteractions(mockArticleRepository);
    });
  });
}
