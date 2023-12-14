import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_local_article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/remove_local_article.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:news_app/features/daily_news/presentation/providers/locla_articles_provider.dart';

class MockGetLocalArticleUseCase extends Mock
    implements GetLocalArticleUseCase {}

class MockRemoveLocalArticleUseCase extends Mock
    implements RemoveLocalArticleUseCase {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  // When the test ends, dispose the container.
  addTearDown(container.dispose);
  return container;
}

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
testOnInitializeingProvider(
  Listener listener,
  MockGetLocalArticleUseCase mockGetLocalArticleUseCase,
  AsyncLoading loading,
  AsyncData data,
) {
  verifyInOrder([
    // transition from null to loading state
    () => listener(null, loading),
    // // transition from loading state to data
    () => listener(loading, data),
  ]);

  verify(() => mockGetLocalArticleUseCase()).called(1);
  verifyNoMoreInteractions(listener);
  verifyNoMoreInteractions(mockGetLocalArticleUseCase);
}

void main() {
  late MockGetLocalArticleUseCase mockGetLocalArticleUseCase;
  late MockRemoveLocalArticleUseCase mockRemoveLocalArticleUseCase;
  late ProviderContainer container;
  late Listener listener;
  var data = AsyncData<List<ArticleEntity>>(articles);
  const loading = AsyncLoading<List<ArticleEntity>>();

  setUp(() {
    mockGetLocalArticleUseCase = MockGetLocalArticleUseCase();
    mockRemoveLocalArticleUseCase = MockRemoveLocalArticleUseCase();
    listener = Listener<AsyncValue>();
    container = createContainer(overrides: [
      getLocalArticleUseCaseProvider.overrideWith((ref) {
        return mockGetLocalArticleUseCase;
      }),
      removeLocalArticleUseCaseProvider.overrideWith((ref) {
        return mockRemoveLocalArticleUseCase;
      }),
    ]);
    // listen to the provider and call [listener] whenever its value changes
    when(() => mockGetLocalArticleUseCase.call()).thenAnswer((_) => articles);
    container.listen(
      localArticlesNotifierProvider,
      listener,
      fireImmediately: true,
    );
  });
  group('database articles tests', () {
    test(
      'should get articles from the database locally after initializing the provider',
      () {
        testOnInitializeingProvider(
            listener, mockGetLocalArticleUseCase, loading, data);
      },
    );
    test('should get a list when searching', () {
      testOnInitializeingProvider(
          listener, mockGetLocalArticleUseCase, loading, data);
      final controller = container.read(localArticlesNotifierProvider.notifier);
      // get all articles when empty search
      controller.searchFilter('');
      expect(controller.state.value, articles);
      // get an empty list when not found results
      controller.searchFilter('###');
      expect(controller.state.value, []);
      // get a list when found results
      controller.searchFilter('title');
      expect(controller.state.value, articles);
    });
  });
}
