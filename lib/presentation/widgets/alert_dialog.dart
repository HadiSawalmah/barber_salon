import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CustomDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(alignment: Alignment.topLeft),
          const SizedBox(height: 119),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 29),
          Icon(icon, color: iconColor, size: 80),
          const SizedBox(height: 66),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 29),
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
