import 'package:flutter/material.dart';

import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';

void main() {
  runApp(SginupUser());
}

class SginupUser extends StatefulWidget {
  const SginupUser({super.key});

  @override
  State<SginupUser> createState() => _SginupUserState();
}

final TextEditingController _username = TextEditingController();
final TextEditingController _emailaddres = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _password = TextEditingController();

class _SginupUserState extends State<SginupUser> {
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
                      "Sign Up",
                      style: TextStyle(color: Color(0xffD6D4CA), fontSize: 32),
                    ),
                    SizedBox(height: 28),
                    Column(
                      children: [
                        Textfiled(
                          "User Name :",
                          "Full name",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _username,
                        ),
                        Textfiled(
                          "Email Address :",
                          "123@gmail.com",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _emailaddres,
                        ),
                        Textfiled(
                          "Phone Number :",
                          "05********",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _phone,
                        ),

                        Textfiled(
                          "Passowrd",
                          "password",
                          Color(0xffD6D4CA),
                          Colors.white,
                          _password,
                        ),

                        SizedBox(height: 44),
                        ButtonLoginUser(text: "Sign Up", onPressed: () {}),
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
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have an account ? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
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
