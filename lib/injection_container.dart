import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:news_app/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  await getApplicationDocumentsDirectory().then((dir) {
    sl.registerSingleton<Store>(
        Store(getObjectBoxModel(), directory: join(dir.path, 'objectbox')));
  });
  sl.registerSingleton(NetworkInfoImp(Connectivity()));
  await SharedPreferences.getInstance().then((value) {
    sl.registerSingleton(ChachedDatasource(sharedPreferences: value));
  });
}
