import 'package:flutter/material.dart';

Widget definitionofbarber(String controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$controller ",
        style: TextStyle(color: Color(0xffD6D4CA), fontSize: 24),
      ),
    ],
  );
}
