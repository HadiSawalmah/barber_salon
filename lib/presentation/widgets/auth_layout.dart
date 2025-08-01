import 'package:flutter/material.dart';
class AuthLayout extends StatelessWidget {
  final String title;
  final Widget child; 

  const AuthLayout({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset("assets/images/face.png", height: 140),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Color(0xffD6D4CA), fontSize: 28),
            ),
            const SizedBox(height: 24),
            child, 
          ],
        ),
      ),
    );
  }
}
