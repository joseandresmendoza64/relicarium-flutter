import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoPermissionException implements Exception {
  final bool permanentlyDenied;

  const PhotoPermissionException({
    required this.permanentlyDenied,
  });
}

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> selectPhoto({required bool fromCamera}) async {
    if (fromCamera) {
      final permission = await Permission.camera.request();

      if (!permission.isGranted) {
        throw PhotoPermissionException(
          permanentlyDenied: permission.isPermanentlyDenied,
        );
      }
    }

    final photo = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 75,
      requestFullMetadata: false,
    );

    return photo?.path;
  }

  Future<bool> openSettings() => openAppSettings();
}