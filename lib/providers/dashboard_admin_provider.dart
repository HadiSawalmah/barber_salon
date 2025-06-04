import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/models/admin/expences_admin_model.dart';

class DashboardAdminProvider with ChangeNotifier {
  double _totalExpences = 0;
  int _numOfUsers = 0;

  double get totalExpences => _totalExpences;
  int get numOfUsers => _numOfUsers;

  Future<void> fetchTotalExpences() async {
    double total = 0;
    final snapshot =
        await FirebaseFirestore.instance.collection('expences').get();

    for (var exp in snapshot.docs) {
      var expences = ExpencesAdminModel.fromMap(exp.data(), exp.id);
      total += expences.price;
    }
    _totalExpences = total;
    notifyListeners();
  }

  Future<void> fetchNoOfUser() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'user')
            .get();

    _numOfUsers = snapshot.docs.length;
    notifyListeners();
  }
}
