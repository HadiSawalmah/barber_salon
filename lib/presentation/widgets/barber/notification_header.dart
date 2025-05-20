import 'package:flutter/material.dart';

class NotificationHeader extends StatelessWidget {
  final String title;
  final VoidCallback seeAll;
  final Color titlecolor;
  const NotificationHeader({
    super.key,
    required this.title,
    required this.seeAll,
    required this.titlecolor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: titlecolor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: seeAll,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
