import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/user/appbar_user.dart';
import 'package:project_new/presentation/widgets/user/navigation_bar_homepage.dart';
import 'package:project_new/providers/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/textfiled.dart';
import 'package:project_new/presentation/widgets/validators.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.fetchUserData().then((_) {
        final user = provider.user;
        if (user != null) {
          _firstname.text = user.name;
          _phone.text = user.phone;
          _email.text = user.email;
          _image.text = user.userimage ?? '';
        }
      });
    });
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
    final userprov = Provider.of<UserProvider>(context);
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
                    backgroundImage:
                        userprov.imageUrl != null
                            ? NetworkImage(userprov.imageUrl!)
                            : AssetImage("assets/images/face.png")
                                as ImageProvider,
                  ),

                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: userprov.pickAndUploadImage,
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

              CustomTextField(
                label: "First Name:",
                hint: "whats your first name?",
                color: Colors.white,
                textColor: Colors.white,
                controller: _firstname,
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

            

              SizedBox(height: 33),
              SizedBox(
                height: 46,
                width: 260,
                child: ElevatedButton(
                  onPressed: () async {
                    await userprov.updateUserData(
                      name: _firstname.text,
                      phone: _phone.text,
                      email: _email.text,
                    );

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
