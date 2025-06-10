import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';
import '../../widgets/textfiled_password.dart';
import 'package:project_new/presentation/widgets/validators.dart';

class Loginbarber extends StatefulWidget {
  const Loginbarber({super.key});

  @override
  State<Loginbarber> createState() => _LoginState();
}

final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
bool _isLoading = false;
String? _errorMessage;

class _LoginState extends State<Loginbarber> {
  Future signInBarber() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _email.text.trim(),
            password: _password.text.trim(),
          );
      final uid = credential.user!.uid;
      final doc =
          await FirebaseFirestore.instance.collection('barbers').doc(uid).get();

      if (doc.exists) {
        // context.go('/barberDashboard');
      } else {
        setState(() {
          _errorMessage = 'This user is not registered as a Barber.';
        });
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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

                        CustomTextField(
                          label: "Email :",
                          hint: "Enter your email",
                          color: Color(0xffD6D4CA),
                          textColor: Colors.white,
                          controller: _email,

                          validator: Validators.email,
                        ),
                        PasswordTextField(
                          label: " Password:",
                          hint: "Enter password",
                          color: Color(0xffD6D4CA),
                          textColor: Colors.white,
                          controller: _password,
                          validator: Validators.password,
                        ),
                        SizedBox(height: 44),
                        ButtonLoginUser(
                          text: _isLoading ? 'Loading...' : 'Log In',
                          onPressed: signInBarber,
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
