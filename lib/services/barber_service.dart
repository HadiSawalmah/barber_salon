import 'package:cloud_firestore/cloud_firestore.dart';

class BarberServiceAvailability {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addAvailability({
    required String barberId,
    required String date,
    required List<String> availableTimes,
    required List<String> unavailableTimes,
  }) async {
    await _firestore
        .collection('users')
        .doc(barberId)
        .collection('availability')
        .doc(date)
        .set({
          'availableTimes': availableTimes,
          'unavailableTimes': unavailableTimes,
        });
  }

  Future<List<String>> getAvailableDates({required String barberId}) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(barberId)
            .collection('availability')
            .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<Map<String, dynamic>?> getAvailability({
    required String barberId,
    required String date,
  }) async {
    final doc =
        await _firestore
            .collection('users')
            .doc(barberId)
            .collection('availability')
            .doc(date)
            .get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }
}
