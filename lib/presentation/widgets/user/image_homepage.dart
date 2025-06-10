import 'package:flutter/material.dart';

class ImageHomepage extends StatelessWidget {
  final String imagePath;
  final String text;
  const ImageHomepage({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 243, 227, 227),
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
