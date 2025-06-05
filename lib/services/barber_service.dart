import 'package:cloud_firestore/cloud_firestore.dart';

class BarberServiceAvailability {
  Future<void> addAvailability({
    required String barberId,
    required String date,
    required List<String> times,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(barberId)
        .collection('availability')
        .doc(date)
        .set({'times': times});
  }

  Future<Map<String, dynamic>?> getAvailability({
    required String barberId,
    required String date,
  }) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(barberId)
            .collection('availability')
            .doc(date)
            .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }
}
