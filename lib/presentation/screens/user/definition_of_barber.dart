import "package:flutter/material.dart";
import '../../widgets/user/definition_of_barber.dart';

void main() {
  runApp(DefinitionOfBarber());
}

class DefinitionOfBarber extends StatefulWidget {
  const DefinitionOfBarber({super.key});
  @override
  State<DefinitionOfBarber> createState() => _DefinitionOfBarberState();
}

class _DefinitionOfBarberState extends State<DefinitionOfBarber> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff1F1F1F),

        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      "assets/images/image 4.png",
                      width: 260,
                      height: 248,
                    ),
                    SizedBox(height: 30),
                    label("Name :"),
                    //importanttt ****************
                    //casting hadi sawalmeh for _name nad casting in definitionofbarber TextEditingController for String
                    //In order for the design to be what you want, because we have not yet created the firebase and the design is not working on the interface
                    definitionofbarber("hadi sawalmeh"),
                    SizedBox(height: 10),
                    label("Email :"),
                    definitionofbarber("_email"),
                    SizedBox(height: 10),
                    label("Phone :"),
                    definitionofbarber("_phone"),
                    SizedBox(height: 10),
                    label("Country :"),
                    definitionofbarber("_country"),
                    SizedBox(height: 10),
                    label("Facebook :"),
                    definitionofbarber("_facebook"),
                    SizedBox(height: 10),
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
