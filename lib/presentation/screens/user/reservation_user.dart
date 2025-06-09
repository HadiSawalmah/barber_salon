import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/models/admin/services_admin.dart';
import 'package:project_new/presentation/widgets/user/time_select.dart';
import 'package:project_new/presentation/widgets/admin/button_add_admin.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user/reservation_model.dart';
import '../../../providers/barber/barber_provider.dart';
import '../../../providers/user/reservation_provider_user.dart';
import '../../../providers/user/user_provider.dart';
import '../../../services/send_notification_service.dart';
import '../../widgets/barber/title_with_underline.dart';
import '../../widgets/user/appbar_witharrowback.dart';
import '../../widgets/user/calender_daily.dart';
import 'package:uuid/uuid.dart';

class ReservationUser extends StatefulWidget {
  final ServicesAdmin services;
  const ReservationUser({super.key, required this.services});

  @override
  State<ReservationUser> createState() => _ReservationUserState();
}

class _ReservationUserState extends State<ReservationUser> {
  int? selectedIndex;
  int? selectedDate;
  String? selectedTime;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final barbers = Provider.of<BarberProvider>(context).barbers;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarWitharrowback(title: "Reservation"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    final barberImage = barbers[index].barberImage;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Opacity(
                        opacity: isSelected ? 1.0 : 0.5,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  (barberImage != null &&
                                          barberImage.isNotEmpty)
                                      ? NetworkImage(barberImage)
                                      : AssetImage('assets/images/image 4.png')
                                          as ImageProvider,
                            ),
                            //  CircleAvatar(
                            //                             radius: 55,
                            //                             backgroundImage: NetworkImage(
                            //                               barbers[index].barberImage ?? '',
                            //                             ),
                            //                           ),
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
              SizedBox(height: 30),
              if (selectedIndex != null) ...[
                TitleWithUnderline(
                  title: "Available Date",
                  size: 18,
                  width: 120,
                ),
                CalenderDaily(
                  onDateSelected: (date) {
                    setState(() {
                      //كخكخ
                      selectedDate = 1;
                    });
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
                  ChooseTime(
                    times: [
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
                    ],
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
                        serviceTitle: widget.services.title,
                        price: widget.services.price,
                        barberId: selectedBarber.id,
                        barberName: selectedBarber.name,
                        date: selectedDate.toString(),
                        time: selectedTime!,
                      );

                      await Provider.of<ReservationProviderUser>(
                        context,
                        listen: false,
                      ).addReservation(reservation, context);
                      if (selectedBarber.fcmToken != null &&
                          selectedBarber.fcmToken!.isNotEmpty) {
                        final barberNotification = {
                          'receiverId': selectedBarber.id,
                          'role': 'barber',
                          'title': 'New Appointment',
                          'body':
                              'Appointment with ${user.name} at $selectedTime',
                          'timestamp': FieldValue.serverTimestamp(),
                        };

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(selectedBarber.id)
                            .collection('notifications')
                            .add(barberNotification);

                        await sendNotification(
                          selectedBarber.fcmToken!,
                          'New Appointment',
                          'Appointment with ${user.name} at $selectedTime',
                        );
                      }
                      log(
                        " New Appointment : Appointment with ${user.name} at $selectedTime",
                      );
                      log("barber in reservation: ${selectedBarber.id}");

                      if (user.fcmToken != null && user.fcmToken!.isNotEmpty) {
                        final userNotification = {
                          'receiverId': user.id,
                          'role': 'user',
                          'title': 'Booking Confirmed',
                          'body':
                              'Your appointment with ${selectedBarber.name} is at $selectedTime',
                          'timestamp': FieldValue.serverTimestamp(),
                        };

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.id)
                            .collection('notifications')
                            .add(userNotification);
                        await sendNotification(
                          user.fcmToken!,
                          'Booking Confirmed',
                          'Your appointment with ${selectedBarber.name} is at $selectedTime',
                        );
                      }
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
                            "Please complete all fields",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
