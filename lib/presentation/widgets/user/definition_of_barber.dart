import 'package:flutter/material.dart';

Widget definitionofbarber(String controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$controller ",
          style: TextStyle(color: Color(0xffD6D4CA), fontSize: 24),
        ),
      ],
    ),
  );
}
