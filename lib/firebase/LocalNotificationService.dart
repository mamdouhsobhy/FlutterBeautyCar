import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'), // your app icon
    );

    _notificationsPlugin.initialize(settings);
  }

  static void showNotification(RemoteMessage message) {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'default_channel',
        'Default',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    _notificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      details,
    );
  }
}
