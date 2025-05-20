import 'package:flutter/material.dart';

class ChooseTime extends StatelessWidget {
  final List<String> times;
  final void Function(String) onTimePressed;
  final Color color;
  final Color textColor;
  const ChooseTime({
    super.key,
    required this.times,
    required this.onTimePressed,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x33D9D9D9),
      child: Wrap(
        spacing: 25,
        runSpacing: 4,
        children:
            times
                .map(
                  (time) => ElevatedButton(
                    onPressed: () => onTimePressed(time),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: textColor,
                      minimumSize: Size(75, 40),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(time),
                  ),
                )
                .toList(),
      ),
    );
  }
}
