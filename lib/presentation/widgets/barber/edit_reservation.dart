import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/barber/appbar_barber.dart';

import '../textfiled.dart';

void main() {
  runApp(EditReservation());
}

class EditReservation extends StatelessWidget {
  const EditReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "Edit Reservation"),
        body: Column(
          children: [
            SizedBox(height: 60),
            CustomTextField(
              label: "services :",
              hint: "",
              color: const Color.fromARGB(255, 240, 236, 236),
              textColor: Colors.white,
              controller: TextEditingController(),
            ),
            CustomTextField(
              label: "services :",
              hint: "",
              color: const Color.fromARGB(255, 240, 236, 236),
              textColor: Colors.white,
              controller: TextEditingController(),
            ),
            CustomTextField(
              label: "services :",
              hint: "",
              color: const Color.fromARGB(255, 240, 236, 236),
              textColor: Colors.white,
              controller: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
