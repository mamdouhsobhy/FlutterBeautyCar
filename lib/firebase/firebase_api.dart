import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../home/presentation/routeManager/home_routes_manager.dart';
import 'LocalNotificationService.dart';

// استخدم navigatorKey في MaterialApp
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FireBaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      final fcmToken = await _firebaseMessaging.getToken();
      print("FCM_Token: $fcmToken");

      // Foreground
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // When App is Opened from Notification (background)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Terminated
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage, fromInitialMessage: true);
      }
    } catch (e) {
      print("Firebase Init Error: $e");
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      LocalNotificationService.showNotification(message);
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message, {bool fromInitialMessage = false}) async {
    final data = message.data;
    final orderId = data['order_id'];

    if (orderId != null) {
      if (fromInitialMessage) {
        // Delay to allow HomeScreen to fully load first
        Future.delayed(const Duration(milliseconds: 1000), () {
          navigatorKey.currentState?.pushNamed(
            HomeRoutes.reserveDetailsRoute,
            arguments: {"orderId": orderId},
          );
        });
      } else {
        navigatorKey.currentState?.pushNamed(
          HomeRoutes.reserveDetailsRoute,
          arguments: {"orderId": orderId},
        );
      }
    }
  }
}
