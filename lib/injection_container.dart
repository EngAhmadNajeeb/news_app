import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/network_info.dart';
final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerSingleton(NetworkInfoImp(Connectivity()));
}
