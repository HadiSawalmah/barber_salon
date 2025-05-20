import 'package:flutter/material.dart';

import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/textfiled.dart';

void main() {
  runApp(ProfileAdmin());
}

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

final TextEditingController _firstname = TextEditingController();
final TextEditingController _lastname = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _dateOfBirth = TextEditingController();

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/face.png", height: 110),
              Text(
                "Hadi sawalmeh",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "hadisawa135@gmail.com",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 14),

              Textfiled(
                "First Name:",
                "whats your first name?",
                Colors.white,
                Colors.black,
                _firstname,
              ),
              Textfiled(
                "Last Name:",
                "and your last name?",
                Colors.white,
                Colors.black,
                _lastname,
              ),
              Textfiled(
                "Phone :",
                "phone number",
                Colors.white,
                Colors.black,
                _phone,
              ),
              Textfiled(
                "Email :",
                "blabla@gmail.com",
                Colors.white,
                Colors.black,
                _email,
              ),
              Textfiled(
                "Date Of Birth :",
                "2003",
                Colors.white,
                Colors.black,
                _dateOfBirth,
              ),

              SizedBox(height: 33),
              SizedBox(
                height: 55,
                width: 260,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFBB4E),
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
