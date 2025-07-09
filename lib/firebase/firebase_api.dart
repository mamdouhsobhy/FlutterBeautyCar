

import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async{
    try {
      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      
      print("User granted permission: ${settings.authorizationStatus}");
      
      // Get FCM token
      final fCMToken = await _firebaseMessaging.getToken();
      print("FCM_Token: $fCMToken");
      

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      
      // Handle when app is opened from notification
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
      
      // Check if app was opened from notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }
      
    } catch (e) {
      print("Firebase messaging initialization error: $e");
    }
  }
  
  // Method to get FCM token for testing
  Future<String?> getFCMToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("Got a message whilst in the foreground!");
    print("Message data: ${message.data}");

    if (message.notification != null) {
      print("Message also contained a notification: ${message.notification}");
    }
  }
  
  void _handleMessageOpenedApp(RemoteMessage message) {
    print("App opened from notification");
    print("Message data: ${message.data}");
    // Handle navigation based on message data
  }

}