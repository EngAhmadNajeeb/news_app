import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/entities/media.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_article.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late GetArticleUseCase usecase;
  late MockArticleRepository mockArticleRepository;
  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetArticleUseCase(mockArticleRepository);
  });
  String section = 'home';
  List<ArticleEntity> articles = [
    ArticleEntity(
      aSection: 'Section',
      aTitle: 'Title',
      aAbstract: 'Abstract',
      aByline: 'Byline',
      aUrl: 'Url',
      aUpdatedAt: DateTime.now(),
      aPublishedDate: DateTime.now(),
      aMultimedia: const [MediaEntity()],
    )
  ];
  test(
    'should get articles from remote data source for speccific section',
    () async {
      when(() => mockArticleRepository.getArticles('home'))
          .thenAnswer((_) async => articles);
      final result = await usecase(params: section);

      expect(result, articles);
      verify(() => mockArticleRepository.getArticles('home'));
      verifyNoMoreInteractions(mockArticleRepository);
    },
  );
}
