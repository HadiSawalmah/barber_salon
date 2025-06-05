import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppbarHomepage extends StatelessWidget implements PreferredSizeWidget {
 const AppbarHomepage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
               context.push('/AllNotificationBarber');
            },
            icon: Icon(Icons.notifications_none, size: 35, color: Colors.white),
          ),
           IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              context.go('/Loginuser');
            },
            icon: Icon(Icons.logout, size: 30, color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(color: Colors.red, height: 2.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
