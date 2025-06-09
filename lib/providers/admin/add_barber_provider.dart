import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/barber/barber_model.dart';
import '../../presentation/widgets/alert_dialog.dart';

class AddBarberProvider with ChangeNotifier {
  bool isLoading = false;
  Future<void> editBarber({
    required context,
    required String barberId,
    required TextEditingController username,
    required TextEditingController email,
    required TextEditingController phoneNumber,
    required TextEditingController country,
    required TextEditingController facebookAccount,
    required TextEditingController age,
  }) async {
    isLoading = true;
    notifyListeners();

    if (username.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        country.text.isNotEmpty &&
        facebookAccount.text.isNotEmpty &&
        age.text.isNotEmpty) {
      try {
        BarberModel updatedBarber = BarberModel(
          id: barberId,
          name: username.text,
          email: email.text,
          phone: phoneNumber.text,
          barberCountry: country.text,
          barberFacebook: facebookAccount.text,
          barberAge: age.text,
          role: "barber",
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(barberId)
            .update(updatedBarber.toMap());

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialog(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: "Updated Successfully",
              description: "Barber has been updated successfully.",
              buttonText: "OK",
              onButtonPressed: () {
                context.pop(true);
                context.pop(true);
              },
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: "Error",
              description: e.toString(),
              buttonText: "OK",
              onButtonPressed: () {
                context.pop();
              },
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(
            icon: Icons.error_outline,
            iconColor: Colors.red,
            title: "Failed Operation",
            description: "Please fill all fields.",
            buttonText: "OK",
            onButtonPressed: () {
              context.pop();
            },
          );
        },
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addBarber({
    required context,
    required TextEditingController username,
    required TextEditingController email,
    required TextEditingController phoneNumber,
    required TextEditingController country,
    required TextEditingController facebookAccount,
    required TextEditingController age,
    required TextEditingController password,
  }) async {
    isLoading = true;
    notifyListeners();

    if (username.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        country.text.isNotEmpty &&
        facebookAccount.text.isNotEmpty &&
        age.text.isNotEmpty &&
        password.text.isNotEmpty) {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email.text.trim(),
              password: password.text.trim(),
            );
        final uid = credential.user!.uid;

        BarberModel newBarber = BarberModel(
          id: uid,
          name: username.text,
          email: email.text,
          phone: phoneNumber.text,
          barberCountry: country.text,
          barberFacebook: facebookAccount.text,
          barberAge: age.text,
          role: "barber",
        );

        final barberMap = newBarber.toMap();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(barberMap);

        // Clear fields
        username.clear();
        email.clear();
        phoneNumber.clear();
        country.clear();
        facebookAccount.clear();
        age.clear();
        password.clear();

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialog(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: "Added Successfully",
              description: "Barber has been added successfully.",
              buttonText: "OK",
              onButtonPressed: () {
                context.pop(true);
                context.pop(true);
              },
            );
          },
        );
      } catch (e) {
        // Show error dialog on failure
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: "Error",
              description: e.toString(),
              buttonText: "OK",
              onButtonPressed: () {
                context.pop();
              },
            );
          },
        );
      }
    } else {
      // Show error dialog for missing fields
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(
            icon: Icons.error_outline,
            iconColor: Colors.red,
            title: "Failed Operation",
            description: "Something went wrong, please fill all fields.",
            buttonText: "OK",
            onButtonPressed: () {
              context.pop();
            },
          );
        },
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
