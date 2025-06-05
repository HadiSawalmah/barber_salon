import 'package:flutter/material.dart';
import 'package:project_new/providers/profile_barber_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/barber/appbar_barber.dart';
import '../../widgets/barber/buttom_navigation.dart';
import '../../widgets/textfiled.dart';

import 'package:project_new/presentation/widgets/validators.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ProfileBarberProvider>(
            context,
            listen: false,
          ).fetchBarberData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileBarberProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarBarber(title: "Profile"),
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
                        provider.imageUrl != null
                            ? NetworkImage(provider.imageUrl!)
                            : AssetImage("assets/images/face.png")
                                as ImageProvider,
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: provider.pickAndUploadImage,
                  ),
                ],
              ),
              Text(
                provider.firstname.text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                provider.email.text,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 14),

              CustomTextField(
                label: "Name:",
                hint: "whats your  name?",
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
                  onPressed: () async {
                    await provider.updateBarberProfile(
                      name: provider.firstname.text,
                      phone: provider.phone.text,
                      email: provider.email.text,
                      image: provider.image.text,
                      facebook: provider.social.text,
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
      bottomNavigationBar: ButtomNavigation(currentPageIndex: 3),
    );
  }
}
