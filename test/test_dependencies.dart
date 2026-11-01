import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tech_catalog/data/catalog_seed.dart';
import 'package:tech_catalog/models/product.dart';
import 'package:tech_catalog/repositories/catalog_repository.dart';
import 'package:tech_catalog/services/connectivity_service.dart';

class TestConnectivityService implements ConnectivityService {
  final bool online;

  TestConnectivityService(this.online);

  @override
  Stream<List<ConnectivityResult>> get networkChanges =>
      const Stream.empty();

  @override
  Stream<bool> get internetChanges => const Stream.empty();

  @override
  Future<bool> checkInternet() async => online;
}

class TestCatalogRepository implements CatalogRepository {  @override
  Future<List<Product>> loadProducts() async => [initialProducts.first];
}