import 'package:flutter/material.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/textfiled.dart';
import 'package:project_new/presentation/widgets/validators.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _image = TextEditingController();
  final _social = TextEditingController();

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _phone.dispose();
    _email.dispose();
    _image.dispose();
    _social.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarBarber(title: "Profile"),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/image.png", height: 110),
              // asset("images/image4.png", height: 110),
              Text(
                "Hadi sawalmeh",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "hadisawa135@gmail.com",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 14),

              CustomTextField(
                label: "First Name:",
                hint: "whats your first name?",
                color: Colors.white,
                textColor: Colors.white,
                controller: _firstname,
                validator: Validators.text,
              ),
              CustomTextField(
                label: "Last Name:",
                hint: "whats your last name?",
                color: Colors.white,
                textColor: Colors.white,
                controller: _lastname,
                validator: Validators.text,
              ),

              CustomTextField(
                label: "Phone Number :",
                hint: "phone number",
                color: Colors.white,
                textColor: Colors.white,
                controller: _phone,

                validator: Validators.phone,
              ),

              CustomTextField(
                label: "Email :",
                hint: "email",
                color: Colors.white,
                textColor: Colors.white,
                controller: _email,

                validator: Validators.email,
              ),
              CustomTextField(
                label: "Photo :",
                hint: "your photo",
                color: Colors.white,
                textColor: Colors.white,
                controller: _image,
              ),
              CustomTextField(
                label: " Facebook Account:",
                hint: "facebook",
                color: Colors.white,
                textColor: Colors.white,
                controller: _social,
                validator: Validators.facebookUrl,
              ),

              SizedBox(height: 33),
              SizedBox(
                height: 46,
                width: 260,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC77218),
                  ),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
