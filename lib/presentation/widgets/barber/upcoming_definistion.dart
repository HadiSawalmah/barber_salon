import 'package:flutter/material.dart';

class UpcomingDefinision extends StatelessWidget {
  final String image;
  final String service;
  final String date;
  final String time;
  const UpcomingDefinision({
    super.key,
    required this.image,
    required this.service,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(image, height: 50),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 93, 88, 68),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      service,
                      style: TextStyle(color: Colors.white, fontSize: 22),
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box,
                    size: 30,
                    color: Color(0xFF03F60B),
                  ),
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
        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
