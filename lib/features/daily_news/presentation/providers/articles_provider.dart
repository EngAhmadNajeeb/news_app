import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'articles_provider.g.dart';

@riverpod
class ArticleNotifier extends _$ArticleNotifier {
  var _data = <ArticleEntity>[];
  var _keyword = '';
  @override
  Future<List<ArticleEntity>> build() async {
    return getData(params: ref.read(selectedSectionProvider.notifier).state);
  }

  void searchFilter(String keyword) async {
    if (state.hasError) return;
    _keyword = keyword;
    if (keyword.trim().isEmpty) {
      state = AsyncValue.data(_data);
    } else {
      state = AsyncValue.data(
        _data.where((element) {
          bool search1 =
              element.aTitle.toLowerCase().contains(keyword.toLowerCase());
          bool search2 =
              element.aByline.toLowerCase().contains(keyword.toLowerCase());
          return search1 || search2;
        }).toList(),
      );
    }
  }

  Future<void> swichSection(String section) async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await getData(params: section));
      searchFilter(_keyword);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<List<ArticleEntity>> getData({String? params}) async {
    _data = await ref.read(getArticleUseCaseProvider).call(params: params);
    return _data;
  }

  Future<void> refreshData(String section) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(removeSetionArticlesFromCacheUseCaseProvider)(
          params: section);
      state = AsyncValue.data(await getData(params: section));
      searchFilter(_keyword);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
