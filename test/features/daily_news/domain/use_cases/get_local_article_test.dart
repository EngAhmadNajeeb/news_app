import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_local_article.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late GetLocalArticleUseCase usecase;
  late MockArticleRepository mockArticleRepository;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetLocalArticleUseCase(mockArticleRepository);
  });
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
  test(
    'should get articles from database locally',
    () async {
      when(() => mockArticleRepository.getSavedArticles())
          .thenAnswer((_) => articles);
      final result = usecase();

      expect(result, articles);
      verify(() => mockArticleRepository.getSavedArticles());
      verifyNoMoreInteractions(mockArticleRepository);
    },
  );
}
