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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            startTime,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Text(
            services,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            clientName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            employeeName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
