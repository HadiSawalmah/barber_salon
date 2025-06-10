import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/firebase/firebase_options.dart';
import 'package:project_new/presentation/routes/routes.dart';
import 'package:project_new/services/message_config.dart';
import 'package:provider/provider.dart';
import 'providers/admin/add_barber_provider.dart';
import 'providers/admin/add_expences_provider.dart';
import 'providers/admin/add_services_provider.dart';
import 'providers/admin_profile_provider.dart';
import 'providers/barber/barber_provider.dart';
import 'providers/dashboard_admin_provider.dart';
import 'providers/barber/availability_barber_provider.dart';
import 'providers/profile_barber_provider.dart';
import 'providers/user/reservation_provider_user.dart';
import 'providers/user/services_fetch.dart';
import 'providers/user/user_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  log("some notification received in background");
  log('Background Message Title: ${message.data['title']}');
  log('Background Message Body: ${message.data['body']}');

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
      );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: DarwinNotificationDetails(),
  );

  await MessagingConfig.flutterLocalNotificationsPlugin.show(
    0,
    message.data['title'] ?? 'No Title',
    message.data['body'] ?? 'No Body',
    platformChannelSpecifics,
    payload: jsonEncode(message.data),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  await MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      log(" App opened  ");
    }
    MessagingConfig.getDeviceToken();
  });

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    log("terminated state");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddBarberProvider()),
        ChangeNotifierProvider(create: (context) => AddExpensesProvider()),
        ChangeNotifierProvider(create: (context) => AdminProfileProvider()),
        ChangeNotifierProvider(create: (context) => DashboardAdminProvider()),
        ChangeNotifierProvider(create: (context) => BarberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ServicesFetchProvider()),
        ChangeNotifierProvider(create: (context) => ReservationProviderUser()),

        ChangeNotifierProvider(
          create: (context) => BarberAvailabilityProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProfileBarberProvider()),
        ChangeNotifierProvider(create: (context) => AddServicesProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
