import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class CatalogStorageService {
  static const _key = 'relicarium_catalog_v1';
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<void> saveProducts(List<Product> products) async {
    final data = products.map((product) => product.toJson()).toList();
    await _preferences.setString(_key, jsonEncode(data));
  }

  Future<List<Product>?> loadProducts() async {
    final stored = await _preferences.getString(_key);
    if (stored == null) return null;

    try {
      final decoded = jsonDecode(stored);
      if (decoded is! List) {
        throw const FormatException('Formato de catalogo invalido');
      }
      return decoded.map((item) {
        return Product.fromJson(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();
    } on FormatException {
      debugPrint('Catalogo local ilegible; se usaran datos iniciales.');
      return null;
    } on TypeError {
      debugPrint('Catalogo local incompatible; se usaran datos iniciales.');
      return null;
    }
  }
}