import 'package:flutter/material.dart';

Widget textfiledPassword(
  String label,
  String hint,
  Color color,
  Color textcolor,
  TextEditingController controller, {
  String? Function(String?)? validator,
}) => Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SizedBox(width: 12),
            Text(
              "*",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textcolor,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          validator: validator,

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: hint,
            filled: true,
            fillColor: color,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    ),
  );
