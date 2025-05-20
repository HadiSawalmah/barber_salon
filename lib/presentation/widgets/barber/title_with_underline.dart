import 'package:flutter/material.dart';

class TitleWithUnderline extends StatelessWidget {
  final String title;
  final double width;
  const TitleWithUnderline({
    super.key,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
        Container(height: 1, width: width, color: Colors.white),
      ],
    );
  }
}
