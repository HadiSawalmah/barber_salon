import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_new/presentation/widgets/user/appbar_user.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/admin/services_admin.dart';
import '../../../data/models/user/reservation_model.dart';
import '../../../providers/barber/barber_provider.dart';
import '../../../providers/user/reservation_provider_user.dart';
import '../../../providers/user/user_provider.dart';
import '../../../services/barber_service.dart';
import '../../widgets/admin/button_add_admin.dart';
import 'package:project_new/presentation/widgets/user/time_select.dart';
import '../../widgets/barber/title_with_underline.dart';
import '../../widgets/user/calender_daily.dart';
import '../../widgets/user/checkbox_all_services.dart';
import '../../widgets/user/navigation_bar_homepage.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  int? selectedIndex;
  DateTime? selectedDate;
  String? selectedTime;
  final _barberServiceAvailability = BarberServiceAvailability();

  List<String> availableTimes = [];
  bool isLoadingTimes = false;
  Future<void> fetchAvailableTimes(String barberId, String date) async {
    setState(() {
      isLoadingTimes = true;
    });

    final data = await _barberServiceAvailability.getAvailability(
      barberId: barberId,
      date: date,
    );

    setState(() {
      availableTimes =
          data != null ? List<String>.from(data['availableTimes']) : [];
      isLoadingTimes = false;
    });
  }

  List<ServicesAdmin> selectedServices = [];

  void onServicesSelected(List<ServicesAdmin> services) {
    setState(() {
      selectedServices = services;
    });
    print("Selected services: ${services.map((s) => s.title).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    final barbers = Provider.of<BarberProvider>(context).barbers;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarUser(title: "Comprehensive service"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CheckboxAllServices(onSelectionChanged: onServicesSelected),
            if (selectedServices.isNotEmpty) ...[
              TitleWithUnderline(
                title: "Select Hair Specialest",
                size: 18,
                width: 180,
              ),
              SizedBox(height: 20),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(barbers.length, (index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedDate = null;
                          availableTimes = [];
                        });
                      },
                      child: Opacity(
                        opacity: isSelected ? 1.0 : 0.5,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  (barbers[index].barberImage != null &&
                                          barbers[index].barberImage!
                                              .startsWith('http'))
                                      ? NetworkImage(
                                        barbers[index].barberImage!,
                                      )
                                      : AssetImage('assets/images/image 4.png')
                                          as ImageProvider,
                            ),

                            SizedBox(height: 4),
                            Text(
                              barbers[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
            SizedBox(height: 30),
            if (selectedIndex != null) ...[
              TitleWithUnderline(title: "Available Date", size: 18, width: 120),
              CalenderDaily(
                onDateSelected: (date) async {
                  setState(() {
                    selectedDate = date;
                  });

                  final selectedBarber = barbers[selectedIndex!];
                  await fetchAvailableTimes(
                    selectedBarber.id,
                    DateFormat('yyyy-MM-dd').format(date),
                  );
                },
              ),
              SizedBox(height: 10),
              if (selectedDate != null) ...[
                TitleWithUnderline(
                  title: "Available Time",
                  size: 18,
                  width: 120,
                ),
                SizedBox(height: 12),
                if (isLoadingTimes)
                  Center(child: CircularProgressIndicator())
                else if (availableTimes.isEmpty)
                  Center(
                    child: Text(
                      "No available times for this day.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  ChooseTime(
                    times: availableTimes,
                    onTimePressed: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    selectedTime: selectedTime,
                  ),
              ],
            ],
            SizedBox(height: 20),
            if (selectedDate != null) ...[
              ButtonAdd(
                text: "Confirm",
                onPressed: () async {
                  if (selectedIndex != null &&
                      selectedDate != null &&
                      selectedTime != null) {
                    final selectedBarber = barbers[selectedIndex!];
                    final id = const Uuid().v4();
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User not found")),
                      );
                      return;
                    }

                    final reservation = ReservationModel(
                      id: id,
                      userId: user.id,
                      userName: user.name,
                      imageUser: user.userimage ?? '',
                      serviceTitle: selectedServices
                          .map((s) => s.title)
                          .join(", "),
                      price: selectedServices.fold(
                        0,
                        (sum, s) => sum + s.price,
                      ),

                      barberId: selectedBarber.id,
                      barberName: selectedBarber.name,
                      date: DateFormat('d-M-yyyy').format(selectedDate!),
                      time: selectedTime!,
                      barberImage: selectedBarber.barberImage,
                    );

                    final isAdded = await Provider.of<ReservationProviderUser>(
                      context,
                      listen: false,
                    ).addReservation(reservation, context);
                    if (!mounted) return;

                    if (isAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Reservation added successfully",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "You already have an active reservation",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please complete all fields",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 30),
            ],
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarHomepage(currentPageIndex: 1),
    );
  }
}
