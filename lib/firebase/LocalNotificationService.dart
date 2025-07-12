import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../home/presentation/routeManager/home_routes_manager.dart';
import 'firebase_api.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // parse payload if needed
        // مثلا: {"order_id":"52"}
        final payload = response.payload;
        if (payload != null) {
          final data = jsonDecode(payload);
          final orderId = data['order_id'];
          if (orderId != null) {
            navigatorKey.currentState?.pushNamed(
              HomeRoutes.reserveDetailsRoute,
              arguments: {"orderId": orderId},
            );
          }
        }
      },
    );
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

    final data = message.data;
    final payload = jsonEncode(data); // {"order_id":"52"}

    _notificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      details,
      payload: payload,
    );
  }


}
