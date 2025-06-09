import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

import 'package:project_new/main.dart';

import 'send_notification_service.dart';

class MessagingConfig {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: LocalNotificationService.onTap,
      onDidReceiveBackgroundNotificationResponse: onBackgroundTap,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      log("message received in foreground");
      try {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;

        if (notification != null && android != null) {
          log("Notification title: ${notification.title ?? 'No Title'}");
          log("Notification body: ${notification.body ?? 'No Body'}");

          String payloadData = jsonEncode(event.data);
          LocalNotificationService.showBasicNotification(
            notification.title,
            notification.body,
            payloadData,
          );
        }
      } catch (err) {
        log(" Error while handling foreground message: $err");
      }
    });
  }

  static Future<void> getDeviceToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      log("token : $token");
      if (token != null) {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          final docRef = FirebaseFirestore.instance
              .collection('users')
              .doc(uid);

          final userDoc = await docRef.get();
          if (userDoc.exists) {
            final role = userDoc.data()?['role'] ?? 'user';

            if (role == 'barber' || role == 'admin' || role == 'user') {
              await docRef.update({'fcmToken': token});
            }

            log('FCM Token updated successfully');
          }
        }
      }
    } catch (e) {
      log('Error saving FCM token: $e');
    }
  }
}

@pragma('vm:entry-point')
void onBackgroundTap(NotificationResponse notificationResponse) async {
  log('Notification tapped in background');
  await LocalNotificationService._navigateBasedOnRole();
}

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      MessagingConfig.flutterLocalNotificationsPlugin;
  static onTap(NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      log("Tapped payload: ${notificationResponse.payload}");
      await _navigateBasedOnRole();
    }
  }

  static Future<void> _navigateBasedOnRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final docSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        final role = docSnapshot.data()?['role'];
        if (role == 'user') {
          navigatorKey.currentState?.pushNamed('/BookingUser');
        } else if (role == 'barber') {
          navigatorKey.currentState?.pushNamed('/UpcomingBarber');
        } else {
          log('Role not recognized: $role');
        }
      } else {
        log("No user is logged in");
      }
    } catch (e) {
      log("Error navigating based on role: $e");
    }
  }

  static void showBasicNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOS = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails details = NotificationDetails(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title ?? 'No Title',
      body ?? 'No Body',
      details,
      payload: payload,
    );
  }
}
