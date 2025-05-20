import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/card_barber.dart';
import '../../widgets/admin/card_barber_admin.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';

void main() {
  runApp(BarberPageAdmindashboard());
}

class BarberPageAdmindashboard extends StatelessWidget {
  const BarberPageAdmindashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Barber> barbers = [
      Barber(
        name: "hadisawa",
        phone: "0567686972",
        city: "Nablus",
        age: 21,
        email: "hadisawa135@gmail.com",
        facebook: "Hadi Sawalmeh",
        monthPercent: 0.54,
        yearPercent: 0.67,
        bookingCount: 155,
      ),
      Barber(
        name: "moath",
        phone: "051626262",
        city: "jenin",
        age: 35,
        email: "moath@gmail.com",
        facebook: "moath sawalmeh",
        monthPercent: 0.35,
        yearPercent: 0.43,
        bookingCount: 120,
      ),
      Barber(
        name: "Anas",
        phone: "0564656262",
        city: "asira",
        age: 25,
        email: "anas@gmail.com",
        facebook: "anas sawalha",
        monthPercent: 0.24,
        yearPercent: 0.30,
        bookingCount: 99,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Barbers"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 4),
            IconCircleAdmin(
              icon: Icon(Icons.add_circle_outline_outlined, size: 52),
              onpress: () {
                context.push("/AddBarber");
              },
            ),
            SizedBox(height: 12),
            // الكروت
            Expanded(
              child: ListView.builder(
                itemCount: barbers.length,
                itemBuilder: (context, index) {
                  return CardBarber(barber: barbers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
