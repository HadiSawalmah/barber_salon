import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/admin/admin_dashbord_homepage.dart';
import 'presentation/screens/user/login_user.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return AdminDashbordHomepage();
          } else {
            return Loginuser();
          }
        }),
      ),
    );
  }
}
