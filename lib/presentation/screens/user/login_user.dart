import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';
import '../../widgets/user/textfiled_password.dart';

void main() {
  runApp(Loginuser());
}

class Loginuser extends StatefulWidget {
  const Loginuser({super.key});

  @override
  State<Loginuser> createState() => _LoginState();
}

Future signIn() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _email.text.trim(),
    password: _password.text.trim(),
  );
}

final _email = TextEditingController();
final _password = TextEditingController();

@override
void dispose() {
  _email.dispose();
  _password.dispose();
}

class _LoginState extends State<Loginuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F1F1F),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 41),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/face.png"),
                  SizedBox(height: 10),
                  Text(
                    "Log In",
                    style: TextStyle(color: Color(0xffD6D4CA), fontSize: 32),
                  ),
                  SizedBox(height: 43),
                  Column(
                    children: [
                      Textfiled(
                        "Phone Number :",
                        "05********",
                        Color(0xffD6D4CA),
                        Colors.white,
                        _email,
                      ),
                      textfiledPassword(
                        "Passowrd",
                        "password",
                        Color(0xffD6D4CA),
                        Colors.white,
                        _password,
                      ),
                      SizedBox(height: 44),
                      ButtonLoginUser(text: "Log In", onPressed: signIn),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go("/SginupUser");
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
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
    );
  }
}
