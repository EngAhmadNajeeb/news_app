import 'package:cross_connectivity/cross_connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImp(this.connectivity);

  @override
  Future<bool> get isConnected async => await connectivity.checkConnection();
}
