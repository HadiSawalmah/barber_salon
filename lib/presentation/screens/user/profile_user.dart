import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/user/appbar_user.dart';
import 'package:project_new/presentation/widgets/user/navigation_bar_homepage.dart';
import '../../widgets/textfiled.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileUser> {
  final _firstname = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _image = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstname.dispose();
    _phone.dispose();
    _email.dispose();
    _image.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarUser(title: "Profile"),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/face.png"),
                  ),

                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                _firstname.text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                _email.text,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 14),

              textfiled(
                "First Name:",
                "whats your first name?",
                Colors.white,
                Colors.white,
                _firstname,
              ),

              textfiled(
                "Phone :",
                "phone number",
                Colors.white,
                Colors.white,
                _phone,
              ),
              textfiled(
                "Email :",
                "blabla@gmail.com",
                Colors.white,
                Colors.white,
                _email,
              ),

              SizedBox(height: 33),
              SizedBox(
                height: 46,
                width: 260,
                child: ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Profile updated successfully!",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    );
                  },
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
      bottomNavigationBar: NavigationBarHomepage(currentPageIndex: 3),
    );
  }
}
