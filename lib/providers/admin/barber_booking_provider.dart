import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarberBookingProvider with ChangeNotifier {
  final String barberId;

  BarberBookingProvider(this.barberId) {
    fetchCompletedBookingData();
  }

  int completedBookingCount = 0;
  double monthRevenue = 0;
  double yearRevenue = 0;
  bool isLoading = true;

  Future<void> fetchCompletedBookingData() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('reservations')
              .where('barberId', isEqualTo: barberId)
              .where('status', isEqualTo: 'completed')
              .get();

      int bookingCount = snapshot.docs.length;

      double monthRev = 0;
      double yearRev = 0;

      DateTime now = DateTime.now();

      for (var doc in snapshot.docs) {
        final data = doc.data();

        double price = 0;
        if (data.containsKey('price')) {
          price = (data['price'] as num).toDouble();
        } else if (data.containsKey('totalRevenue')) {
          price = (data['totalRevenue'] as num).toDouble();
        }

        Timestamp ts = data['date'] as Timestamp? ?? Timestamp.now();
        DateTime date = ts.toDate();

        if (date.year == now.year) {
          yearRev += price;
          if (date.month == now.month) {
            monthRev += price;
          }
        }
      }

      completedBookingCount = bookingCount;
      monthRevenue = monthRev;
      yearRevenue = yearRev;
    } catch (e) {
      print("Error fetching completed booking data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
