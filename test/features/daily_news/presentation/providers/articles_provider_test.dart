import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/use_cases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/providers/articles_provider.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:news_app/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetArticleUseCase extends Mock implements GetArticleUseCase {}

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
    aMultimedia: const [],
  )
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({'SelectedSection': kHome});
  var instance = await SharedPreferences.getInstance();
  sl.registerSingleton(ChachedDatasource(sharedPreferences: instance));

  late MockGetArticleUseCase mockGetArticleUseCase;

  late ProviderContainer container;
  late Listener listener;
  var data = AsyncData<List<ArticleEntity>>(articles);
  const loading = AsyncLoading<List<ArticleEntity>>();

  setUp(() {
    mockGetArticleUseCase = MockGetArticleUseCase();
    listener = Listener<AsyncValue>();
    container = createContainer(overrides: [
      getArticleUseCaseProvider.overrideWith((ref) {
        return mockGetArticleUseCase;
      }),
    ]);
    // listen to the provider and call [listener] whenever its value changes
    when(() => mockGetArticleUseCase.call(params: kHome))
        .thenAnswer((_) async => articles);
    container.listen(
      articleNotifierProvider,
      listener,
      fireImmediately: true,
    );
  });
  test(
    'should get articles from the remote data source after initializing the provider',
    () {
      verifyInOrder([
        // transition from null to loading state
        () => listener(null, loading),
        // // transition from loading state to data
        () => listener(loading, data),
      ]);

      verify(() => mockGetArticleUseCase(params: section)).called(1);
      verifyNoMoreInteractions(listener);
      verifyNoMoreInteractions(mockGetArticleUseCase);
    },
  );
}
