import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/admin_profile_provider.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/textfiled.dart';
import 'package:project_new/presentation/widgets/validators.dart';
import '../../widgets/textfiled_password.dart';


class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  void initState() {
    super.initState();
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



            CustomTextField(
              label: "First Name:",
              hint: "whats your first name?",
              color: Colors.white,
              textColor: Colors.black,
              controller: provider.firstName,
              validator: Validators.text,
            ),
            CustomTextField(
              label: "Last Name:",
              hint: "whats your last name?",
              color: Colors.white,
              textColor: Colors.black,
              controller: provider.lastName,
              validator: Validators.text,
            ),
         CustomTextField(
              label: "Phone Name:",
              hint: "phone number",
              color: Colors.white,
              textColor: Colors.black,
              controller: provider.phone,
              validator: Validators.phone,
            ),
 
            CustomTextField(
                label: "Email :",
                hint: "email",
                color: Colors.white,
                textColor: Colors.black,
                controller:  provider.email,
                validator: Validators.email,
              ),
 
            PasswordTextField(
              label: " Password:",
              hint: "Enter password",
              color: Color(0xffD6D4CA),
              textColor: Colors.black,
              controller: provider.password,
              validator: Validators.password,
            ),
          
             CustomTextField(
                label: "Date Of Birth : :",
                hint: "Date Of Birth ",
                color: Colors.white,
                textColor: Colors.black,
                controller: provider.dateOfBirth,
                validator: Validators.text,
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
