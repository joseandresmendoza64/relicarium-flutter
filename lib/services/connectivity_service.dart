import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final Connectivity _network = Connectivity();
  final InternetConnection _internet = InternetConnection();

  Stream<List<ConnectivityResult>> get networkChanges =>
      _network.onConnectivityChanged;

  Stream<bool> get internetChanges => _internet.onStatusChange
      .map((status) => status == InternetStatus.connected)
      .distinct();

  Future<bool> checkInternet() async {
    try {
      return await _internet.hasInternetAccess.timeout(
        const Duration(seconds: 8),
      );
    } catch (_) {
      return false;
    }
  }
}