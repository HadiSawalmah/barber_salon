import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_barber_provider.dart';
import '../../../providers/user/reservation_provider_user.dart';
import '../../widgets/barber/appbar_homepage.dart';
import '../../widgets/barber/booking_card.dart';
import '../../widgets/barber/buttom_navigation.dart';
import '../../widgets/barber/add_availability_button.dart';
import '../../widgets/barber/title_with_underline.dart';

class BarberDashboardHome extends StatefulWidget {
  const BarberDashboardHome({super.key});

  @override
  State<BarberDashboardHome> createState() => _BarberDashboardHomeState();
}

class _BarberDashboardHomeState extends State<BarberDashboardHome> {
  @override
  void initState() {
    super.initState();
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReservationProviderUser>(
        context,
        listen: false,
      ).fetchReservationsByBarber(barberId);
      Provider.of<ReservationProviderUser>(
        context,
        listen: false,
      ).fetchCompletedReservationsByBarber(barberId);
      Provider.of<ProfileBarberProvider>(
        context,
        listen: false,
      ).fetchBarberData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reservations =
        Provider.of<ReservationProviderUser>(context).lastFiveReservations;

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
              if (reservations.isEmpty)
                const Text(
                  "No reservations found",
                  style: TextStyle(color: Colors.white),
                )
              else
                ...reservations.map(
                  (res) => BookingCard(
                    title: res.userName,
                    service: res.serviceTitle,
                    date: res.date,
                    time: res.time,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigation(currentPageIndex: 0),
    );
  }
}
