import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../widgets/user/button_user_openingpage.dart";

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
                      SizedBox(height: 100),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/face.png"),
                        radius: 90,
                        backgroundColor: Color(0xff1F1F1F),
                      ),
                      SizedBox(height: 53),
                      Text(
                        "Salon AL_Basha",
                        style: TextStyle(
                          color: Color(0xffD6D4CA),
                          fontSize: 40,
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
                        width: 207,
                        text: "Log in ",
                        onPressed: () {
                          context.go("/Loginuser");
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
