import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/user/all_services.dart';
import '../../screens/user/booking_user.dart';
import '../../screens/user/home_page_user.dart';
import '../../screens/user/profile_user.dart';

class NavigationBarHomepage extends StatelessWidget {
  final int currentPageIndex;

  const NavigationBarHomepage({super.key, required this.currentPageIndex});

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
            context.go("/HomePageUser");
            break;
          case 1:
            context.go("/AllServices");
            break;
          case 2:
            context.go("/BookingUser");
            break;
          case 3:
            context.go("/ProfileUser");
            break;
        }
      },
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.add), label: 'Services'),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Booking',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
