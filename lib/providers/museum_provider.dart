import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/museum_artwork.dart';
import '../services/museum_api_service.dart';

enum MuseumStatus { loading, success, error }

class MuseumProvider extends ChangeNotifier {
  MuseumProvider(this._service);

  final MuseumApiService _service;
  MuseumStatus _status = MuseumStatus.loading;
  List<MuseumArtwork> _artworks = const [];
  String? _error;
  bool _requestInProgress = false;
  bool _disposed = false;

  MuseumStatus get status => _status;
  List<MuseumArtwork> get artworks => _artworks;
  String? get error => _error;

  Future<void> load() async {
    if (_requestInProgress || _disposed) return;

    _requestInProgress = true;
    _status = MuseumStatus.loading;
    _error = null;
    notifyListeners();

    try {
      _artworks = List.unmodifiable(await _service.fetchArtworks());
      _status = MuseumStatus.success;
    } on TimeoutException {
      _error = 'El museo tardó demasiado en responder. Intenta de nuevo.';
      _status = MuseumStatus.error;
    } catch (error) {
      debugPrint('Error al consultar el museo: $error');
      _error = 'No se pudo cargar el archivo. Revisa tu conexión e intenta de nuevo.';
      _status = MuseumStatus.error;
    } finally {
      _requestInProgress = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
