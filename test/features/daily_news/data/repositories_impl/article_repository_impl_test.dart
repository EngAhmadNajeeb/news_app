import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/database_service.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/articles_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/data/models/media.dart';
import 'package:news_app/features/daily_news/data/models/response_moel.dart';
import 'package:news_app/features/daily_news/data/repositories_impl/article_repository_impl.dart';
import 'package:objectbox/objectbox.dart';

class MockArticleApiService extends Mock implements ArticleApiService {}

class MockDatabaseService extends Mock implements DatabaseService {}

class MockChachedDatasource extends Mock implements ChachedDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

String section = 'home';
ToMany<MediaModel> media = ToMany<MediaModel>(items: []);
bool onlyFromInternet = true;
List<ArticleModel> articles = [
  ArticleModel(multimedia: media),
];
final responseModel = ResponseModel(
  results: articles,
  status: 'success',
  numResults: 1,
  section: section,
);
void main() {
  late ArticleRepositoryImpl repo;
  late MockArticleApiService mockArticleApiService;
  late MockDatabaseService mockDatabaseService;
  late MockChachedDatasource mockChachedDatasource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockArticleApiService = MockArticleApiService();
    mockDatabaseService = MockDatabaseService();
    mockChachedDatasource = MockChachedDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repo = ArticleRepositoryImpl(mockArticleApiService, mockDatabaseService,
        mockChachedDatasource, mockNetworkInfo);
  });

  group('Remote data source', () {
    group('Cached section articles is not empty', () {
      test('should get the articles from cache when cache is not empty',
          () async {
        when(() => mockChachedDatasource.getSectionArticles(section))
            .thenAnswer((_) => articles);

        final result = await repo.getArticles(section);

        expect(result, articles);
        verify(() => mockChachedDatasource.getSectionArticles(section))
            .called(1);
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockDatabaseService);
        verifyZeroInteractions(mockNetworkInfo);
      });
    });
    group('Cached section articles is empty', () {
      group('divice is online', () {
        test(
            'should get the articles from internet and save result in cache when call the remote data source is successfuly',
            () async {
          when(() => mockChachedDatasource.getSectionArticles(section))
              .thenAnswer((_) => []);
          when(() => mockArticleApiService.getNewsArticles(section, kApiKey))
              .thenAnswer((_) async => responseModel);
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          final result = await repo.getArticles(section);

          expect(result, articles);
          verify(() => mockArticleApiService.getNewsArticles(section, kApiKey))
              .called(1);
          verify(() =>
                  mockChachedDatasource.cachSectionArticles(section, articles))
              .called(1);
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockArticleApiService);
          verifyZeroInteractions(mockDatabaseService);
        });
      });
      group('divice is offline', () {
        test(
            'should get Cached Article for specific section when list is not empty',
            () async {
          when(() => mockChachedDatasource.getSectionArticles(section))
              .thenAnswer((_) => articles);
          final result = await Future.delayed(
            const Duration(milliseconds: 20),
            () => repo.getArticles(section),
          );

          expect(result, articles);
          verify(() => mockChachedDatasource.getSectionArticles(section))
              .called(1);
          verifyZeroInteractions(mockArticleApiService);
          verifyZeroInteractions(mockNetworkInfo);
          verifyZeroInteractions(mockDatabaseService);
        });
        test(
            'should get exception Internet connection error when list is empty or ',
            () async {
          when(() => mockChachedDatasource.getSectionArticles(section))
              .thenAnswer((_) => []);
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);

          expect(
            () async => await repo.getArticles(section),
            throwsA(isA<NoInternetExceptiona>()),
          );
          verifyZeroInteractions(mockArticleApiService);
          verifyZeroInteractions(mockDatabaseService);
        });
      });
    });
  });
  group('local database', () {
    test('should get saved article in database', () {
      when(() => mockDatabaseService.getArticles()).thenAnswer((_) => articles);
      final result = repo.getSavedArticles();

      expect(result, articles);
      verify(() => repo.getSavedArticles());
      verifyZeroInteractions(mockArticleApiService);
      verifyZeroInteractions(mockChachedDatasource);
      verifyZeroInteractions(mockNetworkInfo);
    });
    group('check is article in archive', () {
      test(
          'Should return the article when found specific article in the database',
          () {
        when(() => mockDatabaseService.checkIsArticleInArchive(
            articles.first.title)).thenAnswer((_) => articles.first);
        final result =
            repo.checkIsArticleInArchiveUseCase(articles.first.title);

        expect(result, articles.first);
        verify(() => repo.checkIsArticleInArchiveUseCase(articles.first.title));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
      test('Should return null when specific article not found in the database',
          () {
        when(() => mockDatabaseService.checkIsArticleInArchive(
            articles.first.title)).thenAnswer((_) => null);
        final result =
            repo.checkIsArticleInArchiveUseCase(articles.first.title);

        expect(result, null);
        verify(() => repo.checkIsArticleInArchiveUseCase(articles.first.title));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
    });
    group('Saving article to the archive', () {
      test('Should return true when saving the article successfully.', () {
        when(() => mockDatabaseService.saveLocalArticle(articles.first))
            .thenAnswer((_) => true);
        final result = repo.saveLocalArticle(articles.first);

        expect(result, true);
        verify(() => repo.saveLocalArticle(articles.first));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
      test('Should return false when saving the article fails', () {
        when(() => mockDatabaseService.saveLocalArticle(articles.first))
            .thenAnswer((_) => false);
        final result = repo.saveLocalArticle(articles.first);

        expect(result, false);
        verify(() => repo.saveLocalArticle(articles.first));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
    });
    group('Remove the article from the archive', () {
      test('Should return true when remove the article successfully.', () {
        when(() => mockDatabaseService.removeLocalArticle(articles.first))
            .thenAnswer((_) => true);
        final result = repo.removeLocalArticle(articles.first);

        expect(result, true);
        verify(() => repo.removeLocalArticle(articles.first));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
      test('Should return false when remove the article fails', () {
        when(() => mockDatabaseService.removeLocalArticle(articles.first))
            .thenAnswer((_) => false);
        final result = repo.removeLocalArticle(articles.first);

        expect(result, false);
        verify(() => repo.removeLocalArticle(articles.first));
        verifyZeroInteractions(mockArticleApiService);
        verifyZeroInteractions(mockChachedDatasource);
        verifyZeroInteractions(mockNetworkInfo);
      });
    });
  });
}
