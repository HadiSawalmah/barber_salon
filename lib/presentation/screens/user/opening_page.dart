import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../widgets/user/button_user_openingpage.dart";

void main() {
  runApp(Openingpage());
}

class Openingpage extends StatelessWidget {
  const Openingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff1F1F1F),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/face.png"),
                        radius: 90,
                        backgroundColor: Color(0xff1F1F1F),
                      ),
                      SizedBox(height: 103),
                      Text(
                        "barber shop",
                        style: TextStyle(
                          color: Color(0xffD6D4CA),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Best Style",
                        style: TextStyle(
                          color: Color(0xffD6D4CA),
                          fontSize: 30,
                          fontFamily: "Tuffy",
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 93),
                      ButtonOpeningpage(
                        text: "User",
                        onPressed: () {
                          context.go("/Loginuser");
                        },
                      ),
                      SizedBox(height: 13),
                      ButtonOpeningpage(
                        text: "Barber",
                        onPressed: () {
                          context.go('/Loginbarber');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
