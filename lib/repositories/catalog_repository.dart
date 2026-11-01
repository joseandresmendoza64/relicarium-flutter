import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../data/catalog_seed.dart';
import '../models/product.dart';
import '../services/catalog_storage_service.dart';

class CatalogRepository {
  final CatalogStorageService _storage = CatalogStorageService();

  Future<List<Product>> loadProducts() async {
    try {
      final saved = await _storage.loadProducts();

      if (saved != null) {
        debugPrint('Catalogo recuperado del almacenamiento local.');
        return saved;
      }

      await _storage.saveProducts(initialProducts);
      debugPrint('Catalogo inicial guardado en almacenamiento local.');
      return List<Product>.of(initialProducts);
    } on PlatformException catch (error) {
      debugPrint('No se pudo acceder al almacenamiento: ${error.code}');
      return List<Product>.of(initialProducts);
    }
  }
}