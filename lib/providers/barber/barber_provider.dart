import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/models/barber/barber_model.dart';

class BarberProvider with ChangeNotifier {
  List<BarberModel> _barbers = [];
  List<BarberModel> get barbers => _barbers;
  bool _isLoading = false;

  Future<void> fetchBarbers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'barber')
              .get();

      _barbers =
          snapshot.docs.map((doc) => BarberModel.fromMap(doc.data())).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching barbers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
