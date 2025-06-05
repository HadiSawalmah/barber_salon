import 'package:flutter/material.dart';

import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/notification_item.dart';


class CustomerNotificationsPage extends StatelessWidget {
  final List<String> notifications;
  const CustomerNotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(title: "Customer Notification"),
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
    );
  }
}
