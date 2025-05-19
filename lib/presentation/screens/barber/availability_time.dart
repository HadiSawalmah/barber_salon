import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:test1/pages/admin_dashbord_homepage.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/choose_time.dart';
import '../../widgets/barber/pick_day.dart';
import '../../widgets/textbutton.dart';
import '../../widgets/barber/title_with_underline.dart';
import '../../widgets/login/button_login_user.dart';

void main() {
  runApp(AvailabilityTime());
}

class AvailabilityTime extends StatefulWidget {
  const AvailabilityTime({super.key});

  @override
  State<AvailabilityTime> createState() => _BarberDashboardHomeState();
}

class _BarberDashboardHomeState extends State<AvailabilityTime> {
  DateTime selectedDate = DateTime.now();
  List<String> availableTimes = [];
  List<String> unavailableTimes = [];

  List<String> allTimes = [
    "3:00",
    "3:30",
    "4:00",
    "4:30",
    "5:00",
    "5:30",
    "6:00",
    "6:30",
    "7:00",
    "7:30",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
  ];
  List<DateTime> daysOfWeek = [];
  @override
  void initState() {
    super.initState();
    availableTimes = List.from(allTimes);
    daysOfWeek = List.generate(
      30,
      (index) => DateTime.now().add(Duration(days: index - 0)),
    );
  }

  void selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
      availableTimes = List.from(allTimes);
      unavailableTimes.clear();
    });
  }

  void moveToUnavailabilityTime(String time) {
    setState(() {
      availableTimes.remove(time);
      unavailableTimes.add(time);
    });
  }

  void moveToAvailabilityTime(String time) {
    setState(() {
      unavailableTimes.remove(time);
      availableTimes.add(time);
    });
  }

  void clearAvailabilityTime() {
    setState(() {
      availableTimes = List.from(allTimes);
      unavailableTimes.clear();
    });
  }

  void clearAll() {
    setState(() {
      availableTimes.clear();
      unavailableTimes = allTimes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "Time availability"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWithUnderline(title: "Add Availability", width: 130),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        DateFormat("MMMM yyyy").format(selectedDate),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              PickDay(
                daysOfWeek: daysOfWeek,
                selectedDate: selectedDate,
                onDateSelected: selectDate,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 39,
                  decoration: BoxDecoration(
                    color: Color(0XFF680306),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Click on the date you are not available on!! ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWithUnderline(title: "Available Time", width: 124),
                  Textbutton(title: "remove all", onprees: clearAll),
                ],
              ),
              SizedBox(height: 10),
              ChooseTime(
                times: availableTimes,
                onTimePressed: moveToUnavailabilityTime,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 16),
              TitleWithUnderline(title: "Un Available Time", width: 150),
              SizedBox(height: 10),
              ChooseTime(
                times: unavailableTimes,
                onTimePressed: moveToAvailabilityTime,
                color: Color.fromARGB(255, 164, 36, 27),
                textColor: Colors.white,
              ),
              SizedBox(height: 70),
              ButtonLoginUser(text: "Confirm", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

