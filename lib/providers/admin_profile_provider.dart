import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/firebase/firebase_storage_service.dart';
import '../data/models/admin/profile_admin.dart';

class AdminProfileProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();

  String? imageUrl;

  Admin? admin;

  Future<void> fetchAdminProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      admin = Admin.fromMap(doc.data()!);

      final nameParts = admin!.name.split(' ');
      firstName.text = nameParts.isNotEmpty ? nameParts.first : '';
      lastName.text =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      phone.text = admin!.phone;
      email.text = admin!.email;
      dateOfBirth.text = admin!.dateOfBirth;
      imageUrl = admin!.imageUrl;

      notifyListeners();
    }
  }

  Future<bool> reauthenticateUser(String password) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Reauthentication failed: ${e.message}");
      return false;
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final fullName = '${firstName.text} ${lastName.text}';

    try {
      final reauthenticated = await reauthenticateUser(password.text);

      if (!reauthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password, please try again')),
        );
        return;
      }

      await _firestore.collection('users').doc(uid).update({
        'name': fullName,
        'phone': phone.text,
        'email': email.text,
        'dateOfBirth': dateOfBirth.text,
        'imageUrl': imageUrl,
      });

      await _auth.currentUser?.verifyBeforeUpdateEmail(email.text);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Future<void> pickAndUploadImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File image = File(picked.path);
      imageUrl = await uploadImageToCloudinary(image);
      notifyListeners();
    }
  }
}
