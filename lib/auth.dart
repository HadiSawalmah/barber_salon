import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/admin/admin_dashbord_homepage.dart';
import 'presentation/screens/barber/barber_dashboard_home.dart';
import 'presentation/screens/user/definition_of_barber.dart';
import 'presentation/screens/user/login_user.dart';
import 'presentation/screens/user/opening_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  Future<String?> getUserRole(String uid) async {
    try {
      final barberDoc =
          await FirebaseFirestore.instance.collection('barbers').doc(uid).get();
      if (barberDoc.exists) return 'barber';

      final adminDoc =
          await FirebaseFirestore.instance.collection('admins').doc(uid).get();
      if (adminDoc.exists) return 'admin';

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) return 'user';
    } catch (e) {
      print('Error getting user role: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Openingpage();
          }
          final uid = snapshot.data!.uid;
          return FutureBuilder<String?>(
            future: getUserRole(uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (roleSnapshot.hasError || roleSnapshot.data == null) {
                return const Center(child: Text('Error loading user data'));
              }

              final role = roleSnapshot.data;

              if (role == 'admin') {
                return const AdminDashbordHomepage();
              } else if (role == 'barber') {
                return const BarberDashboardHome();
              } else if (role == 'user') {
                return const Openingpage();
              } else {
                return const DefinitionOfBarber();
              }
            },
          );
        },
      ),
    );
  }
}
