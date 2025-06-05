import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtomNavigation extends StatelessWidget {
  final int currentPageIndex;

  const ButtomNavigation({super.key, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Color(0xffD9D9D9),
      indicatorColor: Colors.grey[100],
      selectedIndex: currentPageIndex,
      onDestinationSelected: (index) {
        if (index == currentPageIndex) return;
        switch (index) {
          case 0:
            context.go("/BarberDashboardHome");
            break;
          case 1:
            context.go("/AvailabilityTime");
            break;
          case 2:
            context.go("/UpcomingBarber");
            break;
          case 3:
            context.go("/ProfilePage");
            break;
        }
      },
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.add), label: 'available'),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Booking',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
