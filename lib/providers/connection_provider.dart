import 'dart:async';
import 'package:flutter/widgets.dart';
import '../services/connectivity_service.dart';

class ConnectionProvider extends ChangeNotifier
    with WidgetsBindingObserver {
  final ConnectivityService _service;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool? _isOnline;
  bool _disposed = false;
  int _revision = 0;

  bool? get isOnline => _isOnline;

  ConnectionProvider(this._service) {
    WidgetsBinding.instance.addObserver(this);
    _subscriptions.add(_service.networkChanges.listen(
      (_) => refresh(),
      onError: (Object _) => refresh(),
    ));
    _subscriptions.add(_service.internetChanges.listen(
      _update,
      onError: (Object _) => _update(false),
    ));
    refresh();
  }

  void _update(bool value) {
    if (_disposed) return;
    _revision++;
    if (_isOnline == value) return;
    _isOnline = value;
    notifyListeners();
  }

  Future<void> refresh() async {
    final revision = ++_revision;
    final online = await _service.checkInternet();
    if (_disposed || revision != _revision) return;
    _update(online);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    super.dispose();
  }
}