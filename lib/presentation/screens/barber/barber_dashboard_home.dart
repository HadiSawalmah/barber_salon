import 'package:flutter/material.dart';
import '../../widgets/barber/appbar_homepage.dart';
import '../../widgets/barber/booking_card.dart';
import '../../widgets/barber/buttom_navigation.dart';

void main() {
  runApp(BarberDashboardHome());
}

class BarberDashboardHome extends StatelessWidget {
  const BarberDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppbarHomepage(title: "Home Page"),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 76,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(Icons.add_circle_outline, size: 55),
                        SizedBox(width: 20),
                        Text(
                          "Add Availability",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Today",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Container(
                height: 1,
                width: 80,
                decoration: BoxDecoration(color: Colors.white),
              ),
              SizedBox(height: 12),

              BookingCard(
                title: "mohammed",
                service: "hair cut",
                date: "21 march",
                time: "12:00pm",
              ),
              BookingCard(
                title: "mohammed",
                service: "hair cut",
                date: "21 march",
                time: "12:00pm",
              ),
              BookingCard(
                title: "mohammed",
                service: "hair cut",
                date: "21 march",
                time: "12:00pm",
              ),
              BookingCard(
                title: "mohammed",
                service: "hair cut",
                date: "21 march",
                time: "12:00pm",
              ),
              BookingCard(
                title: "mohammed",
                service: "hair cut",
                date: "21 march",
                time: "12:00pm",
              ),
            ],
          ),
        ),
        bottomNavigationBar: ButtomNavigation(
          selectedIndex: 0,
          onItemTapped: (index) {
            if (index == 0) {
            } else if (index == 1) {
            } else if (index == 2) {
            } else if (index == 3) {
            }
          },
        ),
      ),
    );
  }
}
