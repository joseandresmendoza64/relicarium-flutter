import 'package:flutter/foundation.dart';

import '../services/photo_service.dart';
import '../services/photo_storage_service.dart';

class PhotoProvider extends ChangeNotifier {
  final String productKey;
  final PhotoStorageService _storage = PhotoStorageService();
  String? _savedPath;

  String? get photoPath => _previewPath ?? _savedPath;
  bool get hasPendingPhoto => _previewPath != null;

  PhotoProvider(this.productKey) {
    _restore();
  }
  final PhotoService _service = PhotoService();
  String? _previewPath;
  String? _error;
  bool _busy = false;
  bool _requiresSettings = false;
  bool _disposed = false;

  String? get previewPath => _previewPath;
  String? get error => _error;
  bool get busy => _busy;
  bool get requiresSettings => _requiresSettings;

  Future<void> selectPhoto({required bool fromCamera}) async {
    if (_busy || _disposed) return;
    _busy = true;
    _error = null;
    _requiresSettings = false;
    notifyListeners();

    try {
      final path = await _service.selectPhoto(fromCamera: fromCamera);
      if (!_disposed && path != null) _previewPath = path;
    } on PhotoPermissionException catch (exception) {
      if (!_disposed) {
        _requiresSettings = exception.permanentlyDenied;
        _error = _requiresSettings
            ? 'Habilita el permiso de cámara en los ajustes.'
            : 'Permiso de cámara denegado. Puedes elegir de la galería.';
      }
    } catch (exception) {
      debugPrint('Error al seleccionar foto: $exception');
      if (!_disposed) _error = 'No se pudo abrir o procesar la imagen.';
    } finally {
      if (!_disposed) {
        _busy = false;
        notifyListeners();
      }
    }
  }

  Future<bool> openSettings() => _service.openSettings();

  Future<void> _restore() async {
    _busy = true;
    try {
      final path = await _storage.loadPhoto(productKey);
      if (!_disposed) _savedPath = path;
    } catch (exception) {
      debugPrint('Error al recuperar foto: $exception');
      if (!_disposed) _error = 'No se pudo recuperar la foto guardada.';
    } finally {
      if (!_disposed) {
        _busy = false;
        notifyListeners();
      }
    }
  }

  Future<void> savePhoto() async {
    final path = _previewPath;
    if (_busy || _disposed || path == null) return;
    _busy = true;
    _error = null;
    notifyListeners();

    try {
      final saved = await _storage.savePhoto(
        productKey: productKey,
        temporaryPath: path,
      );
      if (!_disposed) {
        _savedPath = saved;
        _previewPath = null;
      }
    } catch (exception) {
      debugPrint('Error al guardar foto: $exception');
      if (!_disposed) _error = 'No se pudo guardar la foto. Intenta otra vez.';
    } finally {
      if (!_disposed) {
        _busy = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
