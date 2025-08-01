import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/models/user/reservation_model.dart';

class ReservationProviderUser with ChangeNotifier {
  ReservationModel? _upcomingReservation;
  ReservationModel? get upcomingReservation => _upcomingReservation;
  List<ReservationModel> _lastFiveReservations = [];
  List<ReservationModel> get lastFiveReservations => _lastFiveReservations;
  List<ReservationModel> _allReservationsByBarber = [];
  List<ReservationModel> get allReservationsByBarber =>
      _allReservationsByBarber;
  List<ReservationModel> _last4CompletedReservations = [];

  List<ReservationModel> get last4CompletedReservations =>
      _last4CompletedReservations;

  final _firestore = FirebaseFirestore.instance;

  Future<bool> addReservation(
    ReservationModel reservation,
    BuildContext context,
  ) async {
    try {
      final existing =
          await _firestore
              .collection('reservations')
              .where('userId', isEqualTo: reservation.userId)
              .where('status', isEqualTo: 'pending')
              .get();
      if (existing.docs.isNotEmpty) {
        return false;
      }
      await _firestore.collection('reservations').doc(reservation.id).set({
        ...reservation.toMap(),
        'status': 'pending',
      });
      final availabilityRef = _firestore
          .collection('users')
          .doc(reservation.barberId)
          .collection('availability')
          .doc(reservation.date);

      await availabilityRef.update({
        'availableTimes': FieldValue.arrayRemove([reservation.time]),
        'unavailableTimes': FieldValue.arrayUnion([reservation.time]),
      });

      return true;
    } catch (e) {
      notifyListeners();
      return true;
    }
  }

  Future<void> fetchLast4CompletedReservations() async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('status', isEqualTo: 'completed')
              .limit(4)
              .get();

      _lastFiveReservations =
          snapshot.docs
              .map((doc) => ReservationModel.fromMap(doc.data()))
              .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching last 4 completed reservations: $e');
    }
  }

  Future<void> cancelReservation(
    String reservationId,
    double price,
    String barberId,
    String date,
    String time,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservationId)
          .delete();

      // إعادة الوقت المتاح
      final availabilityRef = FirebaseFirestore.instance
          .collection('users')
          .doc(barberId)
          .collection('availability')
          .doc(date);

      await availabilityRef.update({
        'availableTimes': FieldValue.arrayUnion([time]),
        'unavailableTimes': FieldValue.arrayRemove([time]),
      });

      allReservationsByBarber.removeWhere((res) => res.id == reservationId);
      notifyListeners();
    } catch (e) {
      print("Error canceling reservation: $e");
    }
  }

  Future<void> deleteReservation(
    String reservationId,
    double price,
    String barberId,
    String date,
    String time,
  ) async {
    try {
      // Delete reservation from Firestore
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservationId)
          .update({'status': 'completed'});

      // Update the review
      await _firestore.collection('revenues').add({
        'barberId': barberId,
        'price': price,
        'date': DateTime.now(),
      });

      // Return available date
      final availabilityRef = FirebaseFirestore.instance
          .collection('users')
          .doc(barberId)
          .collection('availability')
          .doc(date);

      await availabilityRef.update({
        'availableTimes': FieldValue.arrayUnion([time]),
        'unavailableTimes': FieldValue.arrayRemove([time]),
      });
      // Delete reservation from data provider
      allReservationsByBarber.removeWhere((res) => res.id == reservationId);
      notifyListeners();
    } catch (e) {
      print("Error deleting reservation: $e");
    }
  }

  Future<void> fetchReservations(String userId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('userId', isEqualTo: userId)
              // .orderBy('date')
              .where('status', isEqualTo: 'pending')
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

  Future<void> fetchAllReservationsByBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              .where('status', isEqualTo: 'pending')
              .get();

      _allReservationsByBarber =
          snapshot.docs
              .map((doc) => ReservationModel.fromMap(doc.data()))
              .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching all barber reservations: $e');
    }
  }

  Future<double> calculateTotalRevenueForBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              .where('status', isEqualTo: 'completed')
              .get();

      double totalRevenue = 0.0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        totalRevenue += (data['price'] ?? data['totalRevenue'] ?? 0).toDouble();
      }

      return totalRevenue;
    } catch (e) {
      print("Error calculating total revenue: $e");
      return 0.0;
    }
  }

  Future<void> completeReservationsForBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              .where('status', isEqualTo: 'pending')
              .get();

      double totalRevenue = 0.0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        totalRevenue += (data['price'] ?? 0).toDouble();

        await _firestore.collection('reservations').doc(doc.id).update({
          'status': 'completed',
          'completedAt': DateTime.now(),
        });
      }

      // After deletion - Record the revenue with the admin
      await _firestore.collection('revenues').add({
        'barberId': barberId,
        'totalRevenue': totalRevenue,
        'date': DateTime.now(),
      });

      notifyListeners();
    } catch (e) {
      print("Error completing and removing reservations: $e");
    }
  }

  Future<void> completeSingleReservation(
    String reservationId,
    double price,
    String barberId,
  ) async {
    try {
      await _firestore.collection('reservations').doc(reservationId).update({
        'status': 'completed',
        'completedAt': DateTime.now(),
      });

      await _firestore.collection('revenues').add({
        'barberId': barberId,
        'price': price,
        'date': DateTime.now(),
      });
      final adminDoc = _firestore.collection('admin').doc('adminDocId');
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(adminDoc);
        final currentRevenue = snapshot['revenue'] ?? 0;
        transaction.update(adminDoc, {'revenue': currentRevenue + price});
      });
      notifyListeners();
    } catch (e) {
      print("Error completing reservation: $e");
    }
  }

  Future<void> fetchReservationsByBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
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

  Future<void> fetchCompletedReservationsByBarber(String barberId) async {
    try {
      final snapshot =
          await _firestore
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              .where('status', isEqualTo: 'completed')
              .get();

      _lastFiveReservations =
          snapshot.docs
              .map((doc) => ReservationModel.fromMap(doc.data()))
              .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching completed barber reservations: $e');
    }
  }
}
