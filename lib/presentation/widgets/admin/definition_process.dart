import 'package:flutter/material.dart';

class DefinitionProcess extends StatelessWidget {
  final String startTime;
  final String services;
  final String clientName;
  final String employeeName;

  const DefinitionProcess({
    super.key,
    required this.startTime,
    required this.services,
    required this.clientName,
    required this.employeeName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          startTime,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          services,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          clientName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          employeeName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
