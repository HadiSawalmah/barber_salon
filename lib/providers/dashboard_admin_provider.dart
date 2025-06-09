import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/models/admin/expences_admin_model.dart';

class DashboardAdminProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double _totalExpences = 0;
  int _numOfUsers = 0;
  double _totalRevenue = 0;

  double _todayRevenue = 0;
  double _monthRevenue = 0;
  double _yearRevenue = 0;

  double _todayExpences = 0;
  double _monthExpences = 0;
  double _yearExpences = 0;

  double get totalRevenue => _totalRevenue;
  double get totalExpences => _totalExpences;
  int get numOfUsers => _numOfUsers;

  double get todayRevenue => _todayRevenue;
  double get monthRevenue => _monthRevenue;
  double get yearRevenue => _yearRevenue;

  double get todayExpences => _todayExpences;
  double get monthExpences => _monthExpences;
  double get yearExpences => _yearExpences;
  Future<void> fetchDashboardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.wait([
        fetchTotalRevenue(),
        fetchTotalExpences(),
        fetchNoOfUser(),
      ]);
    } catch (e) {
      print("Error in fetchDashboardData: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTotalRevenue() async {
    try {
      double total = 0;
      double todayTotal = 0;
      double monthTotal = 0;
      double yearTotal = 0;

      final now = DateTime.now();

      final snapshot =
          await FirebaseFirestore.instance.collection('revenues').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final price =
            (data['price'] ?? data['totalRevenue'])?.toDouble() ?? 0.0;
        final date = (data['date'] as Timestamp?)?.toDate();

        total += price;

        if (date != null) {
          if (date.year == now.year &&
              date.month == now.month &&
              date.day == now.day) {
            todayTotal += price;
          }
          if (date.year == now.year && date.month == now.month) {
            monthTotal += price;
          }
          if (date.year == now.year) {
            yearTotal += price;
          }
        }
      }

      _totalRevenue = total;
      _todayRevenue = todayTotal;
      _monthRevenue = monthTotal;
      _yearRevenue = yearTotal;
      notifyListeners();
    } catch (e) {
      print("Error in fetchTotalRevenue: $e");
    }
  }

  Future<void> fetchTotalExpences() async {
    try {
      double total = 0;
      double todayTotal = 0;
      double monthTotal = 0;
      double yearTotal = 0;

      final now = DateTime.now();

      final snapshot =
          await FirebaseFirestore.instance.collection('expences').get();

      for (var exp in snapshot.docs) {
        var expences = ExpencesAdminModel.fromMap(exp.data(), exp.id);
        total += expences.price;

        if (expences.created != null) {
          if (expences.created!.year == now.year &&
              expences.created!.month == now.month &&
              expences.created!.day == now.day) {
            todayTotal += expences.price;
          }
          if (expences.created!.year == now.year &&
              expences.created!.month == now.month) {
            monthTotal += expences.price;
          }
          if (expences.created!.year == now.year) {
            yearTotal += expences.price;
          }
        } else {
          print(
            "Expense with no created date found: name=${expences.name}, price=${expences.price}, SKIPPING for Today/Month/Year.",
          );
        }
      }

      _totalExpences = total;
      _todayExpences = todayTotal;
      _monthExpences = monthTotal;
      _yearExpences = yearTotal;

      notifyListeners();
    } catch (e) {
      print("Error in fetchTotalExpences: $e");
    }
  }

  Future<void> fetchNoOfUser() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'user')
              .get();

      _numOfUsers = snapshot.docs.length;
      notifyListeners();
    } catch (e) {
      print("Error in FetchNoOfUser: $e");
    }
  }
}
