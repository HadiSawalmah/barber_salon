import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/models/user/user_model.dart';

class UsersAcountProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'user')
              .get();

      _users =
          snapshot.docs.map((doc) {
            return UserModel.fromMap(doc.data());
          }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      _users.removeWhere((user) => user.id == userId);
      notifyListeners();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
