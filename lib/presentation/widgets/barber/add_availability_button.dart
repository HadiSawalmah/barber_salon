import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAvailabilityButton extends StatelessWidget {
  const AddAvailabilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            context.push('/AvailabilityTime');
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.add_circle_outline, size: 55),
              SizedBox(width: 20),
              Text("Add Availability", style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
