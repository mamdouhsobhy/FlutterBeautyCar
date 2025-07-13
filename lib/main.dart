import 'package:beauty_car/firebase/firebase_api.dart';
import 'package:beauty_car/resources/languageManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';
import 'app/di/di.dart';
import 'firebase/LocalNotificationService.dart';

// This needs to be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print("Message data: ${message.data}");
  print("Message notification: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    final orderId = initialMessage.data['order_id'];
    if (orderId != null) {
      FireBaseApi.pendingOrderId = orderId;
    }
  }
  await FireBaseApi().initNotification();
  LocalNotificationService.initialize();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCALE, ENGLISH_LOCALE],
      path: ASSET_PATH_LOCALIZATION,
      child: Phoenix(child: MyApp())));
}
