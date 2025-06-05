import 'package:flutter/material.dart';

class ChooseTime extends StatelessWidget {
  final List<String> times;
  final void Function(String) onTimePressed;
  final Color color;
  final Color textColor;
  final String? selectedTime;
  const ChooseTime({
    super.key,
    required this.times,
    required this.onTimePressed,
    required this.color,
    required this.textColor,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x33D9D9D9),
      child: Wrap(
        spacing: 5,
        runSpacing: 0,
        children:
            times.map((time) {
              final isSelected = time == selectedTime;
              return ElevatedButton(
                onPressed: () => onTimePressed(time),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.blue : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  minimumSize: Size(69, 40),
                  padding: EdgeInsets.zero,
                ),
                child: Text(time),
              );
            }).toList(),
      ),
    );
  }
}
