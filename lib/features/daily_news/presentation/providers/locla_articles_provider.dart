import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/providers/general_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'locla_articles_provider.g.dart';

@riverpod
class LocalArticlesNotifier extends _$LocalArticlesNotifier {
  var _data = <ArticleEntity>[];
  @override
  Future<List<ArticleEntity>> build() async {
    return getData();
  }

  void searchFilter(String keyword) async {
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

  Future<List<ArticleEntity>> getData() async {
    _data = ref.read(getLocalArticleUseCaseProvider).call();
    return _data;
  }

  void removArticle(ArticleEntity entity) async {
    ref.read(removeLocalArticleUseCaseProvider).call(params: entity);
    // state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await getData());
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
