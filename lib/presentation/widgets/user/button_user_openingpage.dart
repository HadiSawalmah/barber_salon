import 'package:flutter/material.dart';

class ButtonOpeningpage extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  const ButtonOpeningpage({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffC77218),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Color(0xffFFFFFF)),
        ),
      ),
    );
  }
}
