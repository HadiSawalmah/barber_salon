import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/admin/services_admin.dart';

class ServicesFetchProvider with ChangeNotifier {
  List<ServicesAdmin> _services = [];
  List<ServicesAdmin> get services => _services;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    final firestore =
        await FirebaseFirestore.instance.collection('services').get();
    _services =
        firestore.docs.map((doc) {
          return ServicesAdmin.fromMap(doc.data(), doc.id);
        }).toList();
    notifyListeners();
  }
}
