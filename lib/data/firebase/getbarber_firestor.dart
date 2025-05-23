import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/admin/barber_model.dart';

class BarberService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BarberModel>> getBarbers() async {
    try {
      QuerySnapshot snapshot =
          await _firestore
              .collection('users')
              .where('role', isEqualTo: 'barber')
              .get();

      return snapshot.docs.map((doc) {
        return BarberModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching barbers: $e");
      rethrow;
    }
  }
}
