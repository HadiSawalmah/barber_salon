import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    super.key,
    this.title = "Confirm Delete",
    this.message = "Are you sure you want to delete this ?",
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
