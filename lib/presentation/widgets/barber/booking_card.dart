import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String title;
  final String service;
  final String date;
  final String time;

  const BookingCard({
    super.key,
    required this.title,
    required this.service,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(title, style: TextStyle(fontSize: 20)),
                  Container(
                    constraints: BoxConstraints(maxWidth: 150),
                    decoration: BoxDecoration(
                      color: Color(0xffD6D4CA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [Text(service, style: TextStyle(fontSize: 20))],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(date, style: TextStyle(fontSize: 20)),
                  Text(time, style: TextStyle(fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
