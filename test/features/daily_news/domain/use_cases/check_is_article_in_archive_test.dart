import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/check_is_article_in_archive.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

List<ArticleEntity> articles = [
  ArticleEntity(
    aSection: 'Section',
    aTitle: 'Title',
    aAbstract: 'Abstract',
    aByline: 'Byline',
    aUrl: 'Url',
    aUpdatedAt: DateTime.now(),
    aPublishedDate: DateTime.now(),
    aMultimedia: const [],
  )
];
void main() {
  late CheckIsArticleInArchiveUseCase usecase;
  late MockArticleRepository mockArticleRepository;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = CheckIsArticleInArchiveUseCase(mockArticleRepository);
  });
  group('check is article in archive', () {
    test('Should return the article when found specific article in the database', () {
      when(() => mockArticleRepository.checkIsArticleInArchiveUseCase(
          articles.first.aTitle)).thenAnswer((_) => articles.first);

      final successResult = usecase(params: articles.first.aTitle);

      expect(successResult, articles.first);
      verify(() => mockArticleRepository
          .checkIsArticleInArchiveUseCase(articles.first.aTitle));
      verifyNoMoreInteractions(mockArticleRepository);
    });

    test('Should return null when specific article not found in the database', () {
      when(() => mockArticleRepository.checkIsArticleInArchiveUseCase(
          'title not in')).thenAnswer((_) => null);

      final failedResult = usecase(params: 'title not in');

      expect(failedResult, null);
      verify(() =>
          mockArticleRepository.checkIsArticleInArchiveUseCase('title not in'));
      verifyNoMoreInteractions(mockArticleRepository);
    });
  });
}
