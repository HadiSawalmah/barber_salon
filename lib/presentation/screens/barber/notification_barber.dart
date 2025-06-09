import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/notification_header.dart';
import '../../widgets/notification_item.dart';

class NotificationBarber extends StatelessWidget {
  const NotificationBarber({super.key});

  @override
  Widget build(BuildContext context) {
    final barberId = FirebaseAuth.instance.currentUser?.uid;

    if (barberId == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            "Barber not logged in",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarBarber(title: "Notification"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            NotificationHeader(
              title: "New :",
              titlecolor: Colors.white,
              seeAll: () {
                context.push('/AllNotificationBarber');
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(barberId)
                        .collection('notifications')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No notifications",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 225, 79, 68),
                        ),
                      ),
                    );
                  }

                  final notifications = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount:
                        notifications.length > 8 ? 8 : notifications.length,
                    itemBuilder: (context, index) {
                      final notifDoc = notifications[index];
                      final data = notifDoc.data() as Map<String, dynamic>;

                      return Dismissible(
                        key: Key(notifDoc.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) async {
                          await notifDoc.reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Notification deleted'),
                            ),
                          );
                        },
                        child: NotificationCard(
                          title: data['title'] ?? '',
                          body: data['body'] ?? '',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
