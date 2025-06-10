import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderDaily extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  const CalenderDaily({super.key, required this.onDateSelected});

  @override
  State<CalenderDaily> createState() => _CalenderDailyState();
}

class _CalenderDailyState extends State<CalenderDaily> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focuseday) {
    setState(() {
      today = day;
    });
    widget.onDateSelected(day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: "en_US",
          rowHeight: 40,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(color: Colors.green),
            selectedDecoration: BoxDecoration(color: Colors.blue),
            weekendTextStyle: TextStyle(color: Colors.white),
            defaultTextStyle: TextStyle(color: Colors.white),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            weekdayStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          daysOfWeekHeight: 25,
          focusedDay: today,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2025, 12, 30),
          onDaySelected: _onDaySelected,
        ),
      ],
    );
  }
}
