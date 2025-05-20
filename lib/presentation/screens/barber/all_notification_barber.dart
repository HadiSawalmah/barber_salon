import 'package:flutter/material.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/notification_item.dart';

void main() {
  runApp(AllNotificationBarber(notifications: []));
}

class AllNotificationBarber extends StatelessWidget {
  final List<String> notifications;
  const AllNotificationBarber({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "All Notification"),
        body:
            notifications.isEmpty
                ? const Center(
                  child: Text(
                    "NO Notification",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: notifications.length,
                  itemBuilder:
                      (context, index) =>
                          NotificationCard(content: notifications[index]),
                ),
      ),
    );
  }
}
