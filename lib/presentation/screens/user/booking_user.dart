import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/user/appbar_user.dart';
import 'package:project_new/presentation/widgets/user/navigation_bar_homepage.dart';
import '../../widgets/user/upcoming_user_reservation.dart';

class BookingUser extends StatelessWidget {
  const BookingUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarUser(title: "Booking"),
      body: Padding(
        padding: EdgeInsets.all(8),

        child: SingleChildScrollView(child: UpcomingUserReservation()),
      ),
      bottomNavigationBar: NavigationBarHomepage(currentPageIndex: 2),
    );
  }
}
