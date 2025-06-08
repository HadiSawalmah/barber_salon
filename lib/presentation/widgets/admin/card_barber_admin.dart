import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/data/models/barber/barber_model.dart';
import 'percentages_admin.dart';

class CardBarber extends StatelessWidget {
  final BarberModel barber;
  final VoidCallback onDeleted;
  const CardBarber({super.key, required this.barber, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    double monthPercent =
        (barber.bookingCount ?? 0) > 0
            ? ((barber.monthRevenue ?? 0) / (barber.bookingCount ?? 1)) * 100
            : 0;

    double yearPercent =
        (barber.bookingCount ?? 0) > 0
            ? ((barber.yearRevenue ?? 0) / (barber.bookingCount ?? 1)) * 100
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
      child: SizedBox(
        height: 300,
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
                    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4),
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
                              {
                                context.push("/EditBarber", extra: barber).then(
                                  (value) {
                                    if (value == true) {
                                      onDeleted();
                                    }
                                  },
                                );
                              }
                            }),
                            iconbutton(Icon(Icons.delete, size: 26), () async {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(barber.id)
                                    .delete();

                                await FirebaseAuth.instance.currentUser
                                    ?.delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Barber deleted successfully ✅",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                );
                                onDeleted();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Failed to delete barber ❌",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              }
                            }),
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
                      percentages("Month", monthPercent),
                      Divider(),
                      percentages("Year", yearPercent),
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    backgroundColor: Color(0xffFFBB4E),
                    child: Text(
                      barber.bookingCount.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconbutton(Icon icons, VoidCallback onpress) {
    return Row(children: [IconButton(onPressed: onpress, icon: icons)]);
  }

  Widget definition(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      softWrap: true,
      overflow: TextOverflow.clip,
      maxLines: null,
    );
  }
}
