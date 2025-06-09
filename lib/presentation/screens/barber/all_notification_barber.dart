import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/confirm_delete_dialog.dart';
import '../../widgets/notification_item.dart';

class AllNotificationBarber extends StatelessWidget {
  const AllNotificationBarber({super.key});

  Future<void> _deleteAllNotifications(
    BuildContext context,
    String barberId,
  ) async {
    final notifsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(barberId)
        .collection('notifications');

    final snapshot = await notifsRef.get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    // final notifsRef = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(barberId)
    //     .collection('notifications');

    // final snapshot = await notifsRef.get();

    // for (var doc in snapshot.docs) {
    //   await doc.reference.delete();
    // }
  }

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
      backgroundColor: const Color(0xff1F1F1F),
      appBar: AppbarBarber(title: "All Notification"),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => ConfirmDeleteDialog(
                          title: "Delete All Notifications",
                          message:
                              "Are you sure you want to delete all notifications?",
                          onConfirm: () async {
                            Navigator.of(context).pop();
                            await _deleteAllNotifications(context, barberId);
                          
                          },
                        ),
                  );
                },
                child: const Icon(Icons.delete, size: 20),
              ),
            ),
          ),
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
                      "NO Notifications",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  );
                }

                final notifications = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notifDoc = notifications[index];
                    final data = notifDoc.data() as Map<String, dynamic>;

                    return Dismissible(
                      key: Key(notifDoc.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) async {
                        await notifDoc.reference.delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Notification deleted')),
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
    );
  }
}
