import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/admin/expences_admin_model.dart';
import '../presentation/widgets/alert_dialog.dart';

class AddExpensesProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> updateExpences({
    required BuildContext context,
    required String docId,
    required String name,
    required String price,
    required String category,
    required VoidCallback onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    if (name.isNotEmpty && price.isNotEmpty && category.isNotEmpty) {
      await FirebaseFirestore.instance.collection('expences').doc(docId).update(
        {'name': name, 'price': price, 'category': category},
      );
      onSuccess();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => CustomDialog(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: "Updated Successfully",
              description: "Expense has been updated successfully.",
              buttonText: "OK",
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => CustomDialog(
              icon: Icons.error_outline,
              iconColor: Colors.red,
              title: "Failed Operation",
              description: "All fields must be filled.",
              buttonText: "OK",
              onButtonPressed: () => Navigator.of(context).pop(),
            ),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense({
    required BuildContext context,
    required String name,
    required String price,
    required String category,
    required VoidCallback onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    if (name.isNotEmpty && price.isNotEmpty && category.isNotEmpty) {
      ExpencesAdminModel expense = ExpencesAdminModel(
        name: name,
        price: double.parse(price),
        category: category,
        created: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('expences')
          .add(expense.myMap());

      onSuccess();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => CustomDialog(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: "Added Successfully",
              description: "Expenses have been added successfully.",
              buttonText: "OK",
              onButtonPressed: () {
                context.pop();
                context.pop();
              },
            ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => CustomDialog(
              icon: Icons.error_outline,
              iconColor: Colors.red,
              title: "Failed Operation",
              description: "All fields must be filled.",
              buttonText: "OK",
              onButtonPressed: () => context.pop(),
            ),
      );
    }
    _isLoading = false;
    notifyListeners();
  }
}
