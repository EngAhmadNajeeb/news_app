import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/cached_datasorce.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerSingleton(NetworkInfoImp(Connectivity()));
  await SharedPreferences.getInstance().then((value) =>
      sl.registerSingleton(ChachedDatasource(sharedPreferences: value)));
}
