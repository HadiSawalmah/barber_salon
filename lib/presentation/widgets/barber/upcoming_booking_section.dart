import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user/reservation_provider_user.dart';
import 'upcoming_definistion.dart';

class UpcomingBookingSection extends StatefulWidget {
  const UpcomingBookingSection({super.key});

  @override
  State<UpcomingBookingSection> createState() => _UpcomingBookingSectionState();
}

class _UpcomingBookingSectionState extends State<UpcomingBookingSection> {
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
      await reservationProvider.fetchAllReservationsByBarber(userId);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservationProviderUser>(context);
    final reservation = provider.allReservationsByBarber;
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
        else if (reservation.isNotEmpty)
          Column(
            children:
                reservation
                    .map(
                      (reservation) => UpcomingDefinision(
                        image: reservation.imageUser,
                        service: reservation.serviceTitle,
                        date: reservation.date,
                        time: reservation.time,
                        onConfirm: () async {
                          await provider.deleteReservation(
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
                                'Reservation deleted successfully!',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
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
