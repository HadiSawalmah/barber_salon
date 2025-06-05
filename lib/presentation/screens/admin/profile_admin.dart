import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/admin_profile_provider.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/textfiled.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  void initState() {
    super.initState();
    // Call to load profile data after building the page
    Future.microtask(
      () =>
          Provider.of<AdminProfileProvider>(
            context,
            listen: false,
          ).fetchAdminProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.grey[300]),
      drawer: DrawerAdmin(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 65,
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
              '${provider.firstName.text} ${provider.lastName.text}',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              provider.email.text,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 14),

            textfiled(
              "First Name:",
              "whats your first name?",
              Colors.white,
              Colors.black,
              provider.firstName,
            ),
            textfiled(
              "Last Name:",
              "whats your last name?",
              Colors.white,
              Colors.black,
              provider.lastName,
            ),
            textfiled(
              "Phone :",
              "phone number",
              Colors.white,
              Colors.black,
              provider.phone,
            ),
            textfiled(
              "Email :",
              "blabla@gmail.com",
              Colors.white,
              Colors.black,
              provider.email,
            ),
            textfiled(
              "Password :",
              "Enter your password",
              Colors.white,
              Colors.black,
              provider.password,
            ),
            textfiled(
              "Date Of Birth :",
              "2003",
              Colors.white,
              Colors.black,
              provider.dateOfBirth,
            ),

            SizedBox(height: 33),
            SizedBox(
              height: 55,
              width: 260,
              child: ElevatedButton(
                onPressed: () => provider.updateProfile(context),
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
    );
  }
}
