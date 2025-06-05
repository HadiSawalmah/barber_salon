import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_new/data/models/barber/barber_model.dart';

import '../data/firebase/firebase_storage_service.dart';

class ProfileBarberProvider extends ChangeNotifier {
  String? imageUrl;
  BarberModel? _barber;
  BarberModel? get barber => _barber;

  final firstname = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final image = TextEditingController();
  final social = TextEditingController();

  Future<void> fetchBarberData() async {
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(barberId)
            .get();
    if (doc.exists) {
      final data = doc.data()!;
      firstname.text = data['barberName'];
      phone.text = data['barberPhone'];
      email.text = data['barberEmail'];
      age.text = data['barberAge'];
      social.text = data['barberFacebook'];
      imageUrl = data['barberImage'];
      notifyListeners();
    } else {
      throw Exception("barber not found");
    }
  }

  Future<void> updateBarberProfile({
    required String name,
    required String phone,
    required String email,
    required String image,
    required String facebook,
  }) async {
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(barberId).update({
      'barberName': name,
      'barberPhone': phone,
      'barberEmail': email,
      'barberImage': image,
      'barberFacebook': facebook,
    });
    await fetchBarberData();
    notifyListeners();
  }

  Future<void> pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      imageUrl = await uploadImageToCloudinary(imageFile);
      image.text = imageUrl ?? '';
      notifyListeners();
    }
  }
}
