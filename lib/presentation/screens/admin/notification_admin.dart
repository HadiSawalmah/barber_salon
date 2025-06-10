import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/notification_header.dart';
import '../../widgets/admin/notification_item.dart';

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

  final List<String> customerNotifications = [
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
        appBar: AppBar(
          title: Text("Notification"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationHeader(
                  titlecolor: Colors.black,
                  title: "Barber :",
                  seeAll: () {
                    context.push("/BarberNotificationsPage");
                  },
                ),
                SizedBox(height: 16),
                ..._buildNotificationList(barberNotifications),
                SizedBox(height: 40),
                NotificationHeader(
                  titlecolor: Colors.black,
                  title: "Customer :",
                  seeAll: () {
                    context.push("/CustomerNotificationsPage");
                  },
                ),
                SizedBox(height: 16),
                ..._buildNotificationList(customerNotifications),
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
      .take(4)
      .map((note) => NotificationCard(content: note))
      .toList();
}
