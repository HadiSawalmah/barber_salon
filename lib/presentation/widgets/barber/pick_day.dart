import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDay extends StatelessWidget {
  final List<DateTime> daysOfWeek;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const PickDay({
    super.key,
    required this.daysOfWeek,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = daysOfWeek[index];
          return GestureDetector(
            onTap: () => onDateSelected(day),
            child: Container(
              width: 68,
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    day.day == selectedDate.day
                        ? Color(0xffC77218)
                        : Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "${day.day}\n${DateFormat("E").format(day)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
