import 'package:flutter/material.dart';

import 'upcoming_definistion.dart';

class UpcomingBookingSection extends StatelessWidget {
  const UpcomingBookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        Text(
          "Today Booking",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 2,
          width: 165,
          decoration: BoxDecoration(color: Colors.white),
        ),
        SizedBox(height: 20),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),

        SizedBox(height: 40),
        Text(
          "Upcoming Booking",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 2,
          width: 210,
          decoration: BoxDecoration(color: Colors.white),
        ),
        SizedBox(height: 20),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
        UpcomingDefinision(
          image: "images/image 4.png",
          service: "hair cut",
          date: "21 january",
          time: "12:00pm",
        ),
      ],
    );
  }
}
