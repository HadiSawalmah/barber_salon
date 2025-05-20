import 'package:flutter/material.dart';

import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';

void main() {
  runApp(Loginuser());
}

class Loginuser extends StatefulWidget {
  const Loginuser({super.key});

  @override
  State<Loginuser> createState() => _LoginState();
}

final TextEditingController _idNumber = TextEditingController();
final TextEditingController _password = TextEditingController();

class _LoginState extends State<Loginuser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff1F1F1F),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 41),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("images/face.png"),
                    SizedBox(height: 10),
                    Text(
                      "Log In",
                      style: TextStyle(color: Color(0xffD6D4CA), fontSize: 32),
                    ),
                    SizedBox(height: 43),
                    Column(
                      children: [
                        Textfiled(
                          "ID Number :",
                          "05********",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _idNumber,
                        ),
                        Textfiled(
                          "Passowrd",
                          "password",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _password,
                        ),
                        SizedBox(height: 44),
                        ButtonLoginUser(text: "Log In", onPressed: () {}),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),

                              child: Text(
                                "Forget Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Text(
                          "Just For Barber",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
