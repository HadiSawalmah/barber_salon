import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/models/user/reservation_model.dart';

class ReservationProviderUser with ChangeNotifier {
  ReservationModel? _upcomingReservation;
  ReservationModel? get upcomingReservation => _upcomingReservation;
  List<ReservationModel> _lastFiveReservations = [];
  List<ReservationModel> get lastFiveReservations => _lastFiveReservations;
  final _firestore = FirebaseFirestore.instance;

  Future<void> addReservation(
    ReservationModel reservation,
    BuildContext context,
  ) async {
    try {
      final existing =
          await _firestore
              .collection('reservations')
              .where('userId', isEqualTo: reservation.userId)
              .get();

      if (existing.docs.isNotEmpty) {
        throw Exception("User already has an active reservation.");
      }
      await _firestore
          .collection('reservations')
          .doc(reservation.id)
          .set(reservation.toMap());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User already has an active reservation ',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  Future<void> fetchReservations(String userId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('userId', isEqualTo: userId)
              // .orderBy('date')
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        _upcomingReservation = ReservationModel.fromMap(
          snapshot.docs.first.data(),
        );
      } else {
        _upcomingReservation = null;
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching reservations: $e');
      _upcomingReservation = null;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchReservationsByBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              // .orderBy('date', descending: true)
              .limit(5)
              .get();

      _lastFiveReservations =
          snapshot.docs
              .map((doc) => ReservationModel.fromMap(doc.data()))
              .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching barber reservations: $e');
    }
  }
}
