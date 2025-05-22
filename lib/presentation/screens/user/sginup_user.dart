import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/admin/user_model.dart';
import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';
import '../../widgets/user/textfiled_password.dart';

class SginupUser extends StatefulWidget {
  const SginupUser({super.key});

  @override
  State<SginupUser> createState() => _SginupUserState();
}

class _SginupUserState extends State<SginupUser> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;
  Future signup(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.text.trim(),
            password: _password.text.trim(),
          );
      final userModel = UserModel(
        userId: credential.user!.uid,
        userName: _username.text.trim(),
        userEmail: _email.text.trim(),
        userPhone: _phone.text.trim(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.userId)
          .set(userModel.toMap());

      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You have successfully signed up",
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        context.go("/Loginuser");
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "An error occurred while registering",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                        "Email  :",
                        "123@gmail.com",
                        Color(0xffD6D4CA),
                        Colors.white,
                        _email,
                      ),
                      Textfiled(
                        "Phone Number :",
                        "05********",
                        Color(0xffD6D4CA),
                        Colors.white,
                        _phone,
                      ),

                      textfiledPassword(
                        "Passowrd",
                        "password",
                        Color(0xffD6D4CA),
                        Colors.white,
                        _password,
                      ),

                      SizedBox(height: 44),
                      ButtonLoginUser(
                        text: _isLoading ? "Loading..." : "Sign Up",
                        onPressed: () => signup(context),
                      ),

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
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont have an account ? ",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              context.go("/Loginuser");
                            },
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
    );
  }
}
