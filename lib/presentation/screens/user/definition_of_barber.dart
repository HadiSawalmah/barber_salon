import "package:flutter/material.dart";
import 'package:project_new/data/models/barber/barber_model.dart';

import '../../widgets/user/appbar_witharrowback.dart';
import '../../widgets/user/definition_of_barber.dart';

class DefinitionOfBarber extends StatelessWidget {
  final BarberModel barber;
  const DefinitionOfBarber({super.key, required this.barber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      appBar: AppbarWitharrowback(title: "Definition of Barber"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Image.network(
                      barber.barberImage ?? '',
                      width: 260,
                      height: 248,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/image 4.png",
                          width: 260,
                          height: 248,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    label("Name :"),
                    definitionofbarber(barber.name),
                    SizedBox(height: 15),
                    label("Email :"),
                    definitionofbarber(barber.email),
                    SizedBox(height: 15),
                    label("Phone :"),
                    definitionofbarber(barber.phone),
                    SizedBox(height: 15),
                    label("Country :"),
                    definitionofbarber(barber.barberCountry),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget label(String text) {
    return Text(text, style: TextStyle(color: Color(0xffC77218), fontSize: 24));
  }
}
