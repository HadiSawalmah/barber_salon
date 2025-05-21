import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/admin/add_barber_admin_dashbord.dart';
// import 'presentation/screens/admin/admin_dashbord_homepage.dart';
import 'presentation/screens/admin/add_expences_admin.dart';
import 'presentation/screens/admin/add_services_admin.dart';
// import 'presentation/screens/admin/definition_of_barber.dart';
import 'presentation/screens/admin/barber_page_admindashboard.dart';
import 'presentation/screens/admin/expences_admin.dart';
import 'presentation/screens/admin/services_page_admin.dart';
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
            return ExpencesAdmin();
          } else {
            return Loginuser();
          }
        }),
      ),
    );
  }
}
