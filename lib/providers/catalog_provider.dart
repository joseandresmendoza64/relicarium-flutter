import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../repositories/catalog_repository.dart';

class CatalogProvider extends ChangeNotifier {
  final CatalogRepository _repository;
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;
  bool _disposed = false;

  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get error => _error;

  CatalogProvider(this._repository) {
    _load();
  }

  Future<void> _load() async {
    try {
      final loaded = await _repository.loadProducts();
      if (!_disposed) _products = loaded;
    } catch (error) {
      debugPrint('Error al cargar el catalogo: $error');
      if (!_disposed) _error = 'No se pudo cargar el catálogo.';
    } finally {
      if (!_disposed) {
        _isLoading = false;
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