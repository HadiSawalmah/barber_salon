import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/barber/appbar_homepage.dart';
import '../../widgets/barber/buttom_navigation.dart';
import '../../widgets/barber/add_availability_button.dart';
import '../../widgets/barber/title_with_underline.dart';

class BarberDashboardHome extends StatefulWidget {
  const BarberDashboardHome({super.key});

  @override
  State<BarberDashboardHome> createState() => _BarberDashboardHomeState();
}

class _BarberDashboardHomeState extends State<BarberDashboardHome> {
  void initState() {
    super.initState();
        final barberId = FirebaseAuth.instance.currentUser!.uid;

  }

  @override
  Widget build(BuildContext context) {
    final reservations;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppbarHomepage(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddAvailabilityButton(),
              SizedBox(height: 20),

              TitleWithUnderline(title: 'Today', width: 80, size: 28),
              SizedBox(height: 12),
          
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigation(currentPageIndex: 0),
    );
  }
}
