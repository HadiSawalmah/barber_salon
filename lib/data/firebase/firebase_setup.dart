import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_new/services/message_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  log("Background Message Received");
  log('Title: ${message.data['title']}');
  log('Body: ${message.data['body']}');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'For important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  await MessagingConfig.flutterLocalNotificationsPlugin.show(
    0,
    message.data['title'] ?? 'No Title',
    message.data['body'] ?? 'No Body',
    notificationDetails,
    payload: jsonEncode(message.data),
  );
}

Future<void> setupFirebaseMessaging() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  await MessagingConfig.initFirebaseMessaging();

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    log("App opened via notification");
    MessagingConfig.getDeviceToken();
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log("App launched from terminated state via notification");
  }
}
