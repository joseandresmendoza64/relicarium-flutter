import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _ready = false;

  static const _channel = AndroidNotificationChannel(
    'collection_photos',
    'Fotos de colección',
    description: 'Confirmaciones de fotos guardadas en Relicarium II',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    if (_ready) return;

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_relicarium'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.createNotificationChannel(_channel);
    _ready = true;
  }
  Future<bool> showPhotoSaved() async {
  await initialize();

  final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  final ios = _plugin.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>();

  bool allowed = false;

  if (android != null) {
    allowed = await android.requestNotificationsPermission() ?? false;
  } else if (ios != null) {
    allowed = await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        false;
  }

  if (!allowed) return false;

  await _plugin.show(
    id: 1,
    title: 'Foto guardada',
    body: 'La foto de tu reliquia se guardó en tu colección.',
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'collection_photos',
        'Fotos de colección',
        channelDescription:
            'Confirmaciones de fotos guardadas en Relicarium II',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'ic_stat_relicarium',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    ),
  );

  return true;
}
}
