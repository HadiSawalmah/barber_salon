import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user/reservation_provider_user.dart';
import 'upcoming_definision_user.dart';

class UpcomingUserReservation extends StatefulWidget {
  const UpcomingUserReservation({super.key});

  @override
  State<UpcomingUserReservation> createState() =>
      _UpcomingBookingSectionState();
}

class _UpcomingBookingSectionState extends State<UpcomingUserReservation> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReservation();
  }

  Future<void> _loadReservation() async {
    final reservationProvider = Provider.of<ReservationProviderUser>(
      context,
      listen: false,
    );
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      await reservationProvider.fetchReservations(userId);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProviderUser>(context);
    final reservation = provider.upcomingReservation;
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
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (reservation != null)
          UpcomingDefinisionUser(
            image: reservation.barberImage,
            service: reservation.serviceTitle,
            date: reservation.date,
            time: reservation.time,
            onConfirm: () async {
              final provider = Provider.of<ReservationProviderUser>(
                context,
                listen: false,
              );
              await provider.cancelReservation(
                reservation.id,
                reservation.price,
                reservation.barberId,
                reservation.date,
                reservation.time,
              );
              await _loadReservation();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Reservation deleted successfully',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              );
            },
          )
        else
          const Text(
            "No upcoming reservations.",
            style: TextStyle(color: Colors.white),
          ),
      ],
    );
  }
}
