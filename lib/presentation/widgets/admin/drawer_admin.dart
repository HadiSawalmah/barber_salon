import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 85,
              width: double.infinity,
              padding: EdgeInsets.only(top: 40),
              color: Colors.grey[300],
              child: Row(
                children: [
                  Image.asset("assets/images/face.png"),
                  Text(
                    "Hadi sawalmeh",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            textdrawer("Finance Report", () {
              context.go("/AdminDashbordHomepage");
            }),
            SizedBox(height: 30),

            textdrawer("Services", () {
              context.go("/ServicesScreen");
            }),
            SizedBox(height: 30),

            textdrawer("Barbers", () {
              context.go("/BarberPageAdmindashboard");
            }),
            SizedBox(height: 30),

            textdrawer("Users (client)", () {
              context.go("/UsersAccount");
            }),
            SizedBox(height: 30),

            textdrawer("Notification", () {
              context.go("/NotificationAdmin");
            }),
            SizedBox(height: 30),

            textdrawer("Profile", () {
              context.go("/ProfileAdmin");
            }),
            SizedBox(height: 30),
            textdrawer("Expences", () {
              context.go("/ExpencesAdmin");
            }),
            SizedBox(height: 30),
            textdrawer("Log out", () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text("Confirm Log Out"),
                      content: Text("Are you sure you want to log out ?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Log Out",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );

              if (shouldLogout == true) {
                FirebaseAuth.instance.signOut();
                context.go('/Loginuser');
              }
            }),
          ],
        ),
      ),
    );
  }
}

Widget textdrawer(String title, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Padding(
      padding: EdgeInsets.all(6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: TextStyle(fontSize: 20)),
      ),
    ),
  );
}
