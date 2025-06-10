import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/barber/availability_time_barber_model.dart';

class AvailabilityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAvailability({
    required String barberId,
    required AvailabilityModel availability,
  }) async {
    final barberRef = _firestore.collection('users').doc(barberId);

    await barberRef.update({
      'availabilities': FieldValue.arrayUnion([availability.toMap()]),
    });
  }
}
