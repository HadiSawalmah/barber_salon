import 'package:flutter/material.dart';

class StatisticsAdminDashboard extends StatelessWidget {
  final String titles;
  final num value;

  const StatisticsAdminDashboard({
    super.key,
    required this.titles,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    String displayValue;

    if (value is double) {
      displayValue =
          value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
    } else {
      displayValue = value.toString();
    }

    return Container(
      width: 101,
      height: 121,
      decoration: BoxDecoration(
        color: Color(0xffFFBB4E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                titles,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 249, 244, 244),
                ),
                child: Center(
                  child: Text(
                    displayValue,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
