import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_new/data/models/user/user_model.dart';

import '../../data/firebase/firebase_storage_service.dart';

class UserProvider with ChangeNotifier {
  String? imageUrl;
  UserModel? _user;
  UserModel? get user => _user;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future fetchUserData() async {
    var user =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();

    if (user.exists) {
      _user = UserModel.fromMap(user.data()!);
      imageUrl = _user?.userimage;
      notifyListeners();
    } else {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    if (_auth.currentUser == null) return;

    final userId = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(userId).update({
      'userName': name,
      'userPhone': phone,
      'userEmail': email,
      'userimage': imageUrl ?? '',
    });

    // Update the local user data
    _user = UserModel(
      id: userId,
      name: name,
      phone: phone,
      email: email,
      role: _user?.role ?? 'user',
      userimage: imageUrl ?? _user?.userimage,
    );

    notifyListeners();
  }

  Future<void> pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      imageUrl = await uploadImageToCloudinary(imageFile);
      notifyListeners();
    }
  }
}
