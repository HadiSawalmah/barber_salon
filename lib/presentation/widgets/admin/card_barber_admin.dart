import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/data/models/barber/barber_model.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin/barber_booking_provider.dart';
import 'percentages_admin.dart';

class CardBarber extends StatelessWidget {
  final BarberModel barber;
  final VoidCallback onDeleted;
  const CardBarber({super.key, required this.barber, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarberBookingProvider(barber.id),
      child: Consumer<BarberBookingProvider>(
        builder: (context, bookingProvider, _) {
          if (bookingProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          double monthRevenue = bookingProvider.monthRevenue;
          double yearRevenue = bookingProvider.yearRevenue;
          int completedBookings = bookingProvider.completedBookingCount;

          double monthPercent =
              (completedBookings > 0)
                  ? (monthRevenue / completedBookings) * 100
                  : 0;

          double yearPercent =
              (completedBookings > 0)
                  ? (yearRevenue / completedBookings) * 100
                  : 0;

          return Card(
            margin: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
                bottom: Radius.circular(20),
              ),
            ),
            elevation: 10,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 300),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    // Left Side: User Info
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFBB4E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                              ),
                            ),
                            padding: EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                              left: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  barber.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    iconbutton(Icon(Icons.edit, size: 26), () {
                                      context
                                          .push("/EditBarber", extra: barber)
                                          .then((value) {
                                            if (value == true) {
                                              onDeleted();
                                            }
                                          });
                                    }),
                                    iconbutton(
                                      Icon(Icons.delete, size: 26),
                                      () async {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: Text("Confirm Delete"),
                                                content: Text(
                                                  "Are you sure you want to delete this barber?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: Text("Cancle"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      try {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(barber.id)
                                                            .delete();

                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              "تم حذف الحلاق بنجاح ✅",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              "فشل في حذف الحلاق ❌",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      onDeleted();
                                                    },
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                definition(barber.phone),
                                SizedBox(height: 25),
                                definition(barber.barberCountry),
                                SizedBox(height: 25),
                                definition("${barber.barberAge} years"),
                                SizedBox(height: 25),
                                definition(barber.email),
                                SizedBox(height: 25),
                                definition(barber.barberFacebook),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 5,
                      color: Colors.grey[300],
                    ),
                    // Right Side: Booking Info
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFBB4E),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13.5,
                            ),
                            child: Center(
                              child: Text(
                                "Booking",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20)),
                              percentages("Month", monthRevenue),
                              Divider(),
                              percentages("Year", yearRevenue),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "No. of Booking",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          CircleAvatar(
                            backgroundColor: Color(0xffFFBB4E),
                            child: Text(
                              completedBookings.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget iconbutton(Icon icons, VoidCallback onpress) {
    return IconButton(onPressed: onpress, icon: icons);
  }

  static Widget definition(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      softWrap: true,
      overflow: TextOverflow.clip,
      maxLines: null,
    );
  }
}
