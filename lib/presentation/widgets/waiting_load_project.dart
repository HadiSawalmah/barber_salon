import "package:flutter/material.dart";

void main() {
  runApp(WaitingLoadProject());
}

class WaitingLoadProject extends StatelessWidget {
  const WaitingLoadProject({super.key});

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
                      SizedBox(height: 150),
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/face.png"),
                        radius: 90,
                        backgroundColor: Color(0xff1F1F1F),
                      ),
                      SizedBox(height: 63),
                      Text(
                        "barber shop",
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
                      SizedBox(height: 40),
                      Text(
                        "Salon Al_Basha",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 40,
                          fontFamily: "Tuffy",
                          fontWeight: FontWeight.bold,
                        ),
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
