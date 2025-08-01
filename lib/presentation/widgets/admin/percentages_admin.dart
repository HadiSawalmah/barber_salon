import 'package:flutter/material.dart';

Widget percentages(String title, double date) {
  return Column(
    children: [
      Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      SizedBox(
        height: 100,
        width: 71,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: date / 100,
              strokeAlign: 3,
              strokeWidth: 7,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Text("${date.toStringAsFixed(1)}%"),
          ],
        ),
      ),
    ],
  );
}
