import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/firebase/firebase_storage_service.dart';
import '../../../data/models/admin/services_admin.dart';
import '../presentation/widgets/alert_dialog.dart';

class AddServicesProvider {
  static Future<void> updateService({
    required BuildContext context,
    required String serviceId,
    required String title,
    required String price,
    required File? newImage,
    required String oldImageUrl,
  }) async {
    try {
      String imageUrl = oldImageUrl;

      if (newImage != null) {
        imageUrl = await uploadImageToCloudinary(newImage);
      }

      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .update({
            'title': title,
            'price': double.parse(price),
            'imageUrl': imageUrl,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Service updated successfully",
            style: TextStyle(color: Colors.green),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to update service",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  static Future<void> addService({
    required BuildContext context,
    required String title,
    required String price,
    required File? image,
    required VoidCallback onSuccess,
  }) async {
    if (title.isNotEmpty && price.isNotEmpty && image != null) {
      String imageUrl = await uploadImageToCloudinary(image);

      ServicesAdmin service = ServicesAdmin(
        title: title,
        price: double.parse(price),
        imageUrl: imageUrl,
      );

      await FirebaseFirestore.instance
          .collection('services')
          .add(service.toMap());

      onSuccess();

      showDialog(
        context: context,
        builder:
            (context) => CustomDialog(
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
              title: "Added Successfully",
              description: "Service has been added successfully.",
              buttonText: "OK",
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => CustomDialog(
              icon: Icons.error_outline,
              iconColor: Colors.red,
              title: "Failed Operation",
              description: "All fields must be filled, including image.",
              buttonText: "OK",
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
      );
    }
  }
}
