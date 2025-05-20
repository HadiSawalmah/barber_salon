import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  final String title;
  final VoidCallback onprees;
  const Textbutton({super.key, required this.title, required this.onprees});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.amber,
        fixedSize: Size.fromWidth(105),
      ),
      onPressed: onprees,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
