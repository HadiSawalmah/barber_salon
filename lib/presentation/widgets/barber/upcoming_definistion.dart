import 'package:flutter/material.dart';

class UpcomingDefinision extends StatelessWidget {
  final String? image;
  final String? service;
  final String? date;
  final String? time;
  final VoidCallback onConfirm;
  const UpcomingDefinision({
    super.key,
    this.image,
    required this.service,
    required this.date,
    required this.time,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            image != null && image!.isNotEmpty
                ? Image.network(
                  image!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
                : Image.asset(
                  'assets/images/image 4.png',
                  height: 80,
                  width: 80,
                ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      service!,
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                  Text(
                    "$date     $time",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onConfirm,
                  icon: Icon(Icons.check_box, size: 30, color: Colors.green),
                  visualDensity: VisualDensity(horizontal: -4),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, size: 30, color: Colors.blue),
                  visualDensity: VisualDensity(horizontal: -4),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 30),
      ],
    );
  }
}
