import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoStorageService {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<String?> loadPhoto(String productKey) async {
    final path = await _preferences.getString('photo_$productKey');
    if (path == null) return null;

    return await File(path).exists() ? path : null;
  }

  Future<String> savePhoto({
    required String productKey,
    required String temporaryPath,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final photos = Directory('${directory.path}/collection_photos');
    await photos.create(recursive: true);

    final source = File(temporaryPath);
    final name = source.uri.pathSegments.last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final destination = '${photos.path}/${timestamp}_$name';

    final saved = await source.copy(destination);
    await _preferences.setString('photo_$productKey', saved.path);
    return saved.path;
  }
}