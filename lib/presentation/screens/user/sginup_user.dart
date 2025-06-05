import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/presentation/widgets/validators.dart';
import '../../../data/models/user/user_model.dart';
import '../../widgets/auth_layout.dart';
import '../../widgets/login/button_login_user.dart';
import '../../widgets/textfiled.dart';
import '../../widgets/textfiled_password.dart';

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
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Future signup(BuildContext context) async {
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
        id: credential.user!.uid,
        name: _username.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        role: 'user',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());
      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();
      _confirmPassword.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You have successfully signed up",
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      if (context.mounted) {
        GoRouter.of(context).go("/Loginuser");
      }
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }
    if (value != _password.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Sign Up",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            textfiled(
              "User Name :",
              "Enter your name",
              Color(0xffD6D4CA),
              Colors.white,
              _username,
              validator:
                  Validators.username,
            ),
            textfiled(
              "Email :",
              "Enter your email",
              Color(0xffD6D4CA),
              Colors.white,
              _email,
              validator: Validators.email,
            ),
            textfiled(
              "Phone Number :",
              "Enter your phone number",
              Color(0xffD6D4CA),
              Colors.white,
              _phone,
              validator: Validators.phone,
            ),
            textfiledPassword(
              "Password",
              "Enter password",
              Color(0xffD6D4CA),
              Colors.white,
              _password,
              validator: Validators.password,
            ),
            textfiledPassword(
              "Confirm Password",
              "Confirm password",
              Color(0xffD6D4CA),
              Colors.white,
              _confirmPassword,
              validator:
                  _validateConfirmPassword, 
            ),
            const SizedBox(height: 44),
            ButtonLoginUser(
              text: _isLoading ? "Loading..." : "Sign Up",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signup(context);
                }
              },
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    context.go("/Loginuser");
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
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
