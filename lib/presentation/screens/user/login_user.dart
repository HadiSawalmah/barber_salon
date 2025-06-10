import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/auth_layout.dart';
import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';
import '../../widgets/textfiled_password.dart';
import '../../widgets/validators.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Loginuser extends StatefulWidget {
  const Loginuser({super.key});

  @override
  State<Loginuser> createState() => _LoginState();
}

class _LoginState extends State<Loginuser> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> signInUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      final uid = credential.user!.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        final role = doc.data()?['role'];
        String? fcmToken;
        if (kIsWeb) {
          print("Skip FCM token on web");
        } else {
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          print("FCM Token: $fcmToken");
        }
        if (role == 'barber') {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'fcmToken': fcmToken,
          });
        }
        if (role == 'admin') {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'fcmToken': fcmToken,
          });
        } else {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'fcmToken': fcmToken,
          });
        }
        switch (role) {
          case 'admin':
            context.go('/AdminDashbordHomepage');
            break;
          case 'barber':
            context.go('/BarberDashboardHome');
            break;
          case 'user':
            context.go('/HomePageUser');
            break;
          default:
            setState(() {
              _errorMessage = "no defined role";
            });
            await FirebaseAuth.instance.signOut();
        }
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This user does not have an account")),
          );
        });
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred. Please try again";
      if (e.code == 'user-not-found') {
        message = "This user does not have an account";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password. Please try again";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address format";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message) , backgroundColor: Colors.red,));
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
    return AuthLayout(
      title: "Log In",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 24),

            CustomTextField(
              label: "Email :",
              hint: "Enter your email",
              color: Color(0xffD6D4CA),
              textColor: Colors.white,
              controller: _email,
              validator: Validators.email,
            ),
            PasswordTextField(
              label: "Password",
              hint: "Enter your Password",
              color: const Color(0xffD6D4CA),
              textColor: Colors.white,
              controller: _password,
            ),

            SizedBox(height: 44),
            ButtonLoginUser(
              text: _isLoading ? 'Loading...' : 'Log In',
              onPressed: signInUser,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
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
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    context.go("/SginupUser");
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
