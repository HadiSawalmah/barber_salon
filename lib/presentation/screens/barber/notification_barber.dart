import 'package:flutter/material.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/notification_header.dart';
import '../../widgets/notification_item.dart';

void main() {
  runApp(NotificationAdmin());
}

class NotificationAdmin extends StatelessWidget {
  NotificationAdmin({super.key});

  final List<String> barberNotifications = [
    "📅 New Booking: 'You have a new appointment with [Customer Name] on [Date] at [Time].'",
    "❌ Appointment Canceled: '[Customer Name] has canceled their appointment for [Date & Time].'",
    "🌐 Booking Updated: '[Customer Name] has changed their appointment to [New Date & Time].'",
    "⏰ Upcoming Appointment: 'Reminder: You have an appointment with [Customer Name] in 30 minutes.'",
    "📅 New Booking: 'You have a new appointment with [Customer Name] on [Date] at [Time].'",
    "❌ Appointment Canceled: '[Customer Name] has canceled their appointment for [Date & Time].'",
    "🌐 Booking Updated: '[Customer Name] has changed their appointment to [New Date & Time].'",
    "⏰ Upcoming Appointment: 'Reminder: You have an appointment with [Customer Name] in 30 minutes.'",
    "📅 New Booking: 'You have a new appointment with [Customer Name] on [Date] at [Time].'",
    "❌ Appointment Canceled: '[Customer Name] has canceled their appointment for [Date & Time].'",
    "🌐 Booking Updated: '[Customer Name] has changed their appointment to [New Date & Time].'",
    "⏰ Upcoming Appointment: 'Reminder: You have an appointment with [Customer Name] in 30 minutes.'",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "Notification"),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationHeader(
                  title: "New :",
                  titlecolor: Colors.white,
                  seeAll: () {
                    // context.push("/BarberNotificationsPage");
                  },
                ),
                SizedBox(height: 16),
                ..._buildNotificationList(barberNotifications),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildNotificationList(List<String> notifications) {
  if (notifications.isEmpty) {
    return [
      SizedBox(height: 24),
      Center(
        child: const Text(
          "No notifications",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 225, 79, 68),
          ),
        ),
      ),
    ];
  }
  return notifications
      .take(8)
      .map((note) => NotificationCard(content: note))
      .toList();
}
