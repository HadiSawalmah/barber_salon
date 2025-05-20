import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String content;
  const NotificationCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
