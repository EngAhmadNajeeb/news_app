import 'package:news_app/core/resources/app_lists.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sections_filter_provider.g.dart';

@riverpod
class SectionsFilterNotifier extends _$SectionsFilterNotifier {
  final _data = AppList.sections;
  @override
  List<String> build() {
    return _data;
  }

  void searchFilter(String keyword) {
    if (keyword.trim().isEmpty) {
      state = _data;
    } else {
      state = _data
          .where((element) =>
              element.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    var results = _data;
    if (keyword.trim().isNotEmpty) {
      results = results
          .where((element) =>
              element.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      state = results;
    }
  }
}
