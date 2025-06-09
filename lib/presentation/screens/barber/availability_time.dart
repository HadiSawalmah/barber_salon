import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/barber/availability_barber_provider.dart';
import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/buttom_navigation.dart';
import '../../widgets/barber/choose_time.dart';
import '../../widgets/barber/pick_day.dart';
import '../../widgets/textbutton.dart';
import '../../widgets/barber/title_with_underline.dart';
import '../../widgets/login/button_login_user.dart';

class AvailabilityTime extends StatefulWidget {
  const AvailabilityTime({super.key});

  @override
  State<AvailabilityTime> createState() => _BarberDashboardHomeState();
}

class _BarberDashboardHomeState extends State<AvailabilityTime> {
  DateTime selectedDate = DateTime.now();

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
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    daysOfWeek = List.generate(
      30,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchTimes());
  }

  void _fetchTimes() async {
    final availabilityProvider = Provider.of<BarberAvailabilityProvider>(
      context,
      listen: false,
    );
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    await availabilityProvider.fetchAvailability(
      barberId: barberId,
      date: DateFormat('yyyy-MM-dd').format(selectedDate),
      allTimes: allTimes,
    );
  }

  void selectDate(DateTime date) async {
    setState(() {
      selectedDate = date;
    });
    _fetchTimes();
  }

  void clearAll() {
    final availabilityProvider = Provider.of<BarberAvailabilityProvider>(
      context,
      listen: false,
    );
    availabilityProvider.clearAvailability();
  }

  @override
  Widget build(BuildContext context) {
    final availabilityProvider = Provider.of<BarberAvailabilityProvider>(
      context,
    );
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarBarber(title: "Time availability"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWithUnderline(
                    title: "Add Availability",
                    width: 130,
                    size: 18,
                  ),
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
                  TitleWithUnderline(
                    title: "Available Time",
                    width: 124,
                    size: 18,
                  ),
                  Textbutton(
                    title: "remove all",
                    onprees: clearAll,
                    isSelected: false,
                  ),
                ],
              ),
              SizedBox(height: 10),
              ChooseTime(
                times: availabilityProvider.availableTimes,
                onTimePressed: (time) {
                  availabilityProvider.moveToUnavailable(time);
                },
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 16),
              TitleWithUnderline(
                title: "Un Available Time",
                width: 150,
                size: 18,
              ),
              SizedBox(height: 10),
              ChooseTime(
                times: availabilityProvider.unavailableTimes,
                onTimePressed: (time) {
                  availabilityProvider.moveToAvailable(time);
                },
                color: Color.fromARGB(255, 164, 36, 27),
                textColor: Colors.white,
              ),
              SizedBox(height: 50),
              ButtonLoginUser(
                text: "Confirm",
                onPressed: () async {
                  await availabilityProvider.saveAvailability(
                    barberId: barberId,
                    date: DateFormat('yyyy-MM-dd').format(selectedDate),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Availability saved!",
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigation(currentPageIndex: 1),
    );
  }
}
