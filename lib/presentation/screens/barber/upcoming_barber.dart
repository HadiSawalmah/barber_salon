import 'package:flutter/material.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/upcoming_booking_section.dart';

void main() {
  runApp(UpcomingBarber());
}

class UpcomingBarber extends StatelessWidget {
  const UpcomingBarber({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "Booking"),
        body: Padding(
          padding: EdgeInsets.all(8),

          child: SingleChildScrollView(child: UpcomingBookingSection()),
        ),
      ),
    );
  }
}
