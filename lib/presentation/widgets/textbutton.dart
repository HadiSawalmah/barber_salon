import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  final String title;
  final VoidCallback onprees;
  final bool isSelected;
  const Textbutton({
    super.key,
    required this.title,
    required this.onprees,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Color(0xffFFBB4E) : Colors.grey[200],
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
