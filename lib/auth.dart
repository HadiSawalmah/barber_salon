import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/admin/admin_dashbord_homepage.dart';
import 'presentation/screens/admin/services_page_admin.dart';
import 'presentation/screens/barber/barber_dashboard_home.dart';
import 'presentation/screens/user/home_page_user.dart';
import 'presentation/screens/user/opening_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  Future<String?> getUserRole(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data()?['role'] as String?;
      }
    } catch (e) {
      debugPrint('Error getting user role: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!authSnapshot.hasData || authSnapshot.data == null) {
            return const Openingpage();
          }
          final uid = authSnapshot.data!.uid;
          return FutureBuilder<String?>(
            future: getUserRole(uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (roleSnapshot.hasError || roleSnapshot.data == null) {
                return const Openingpage();
              }
              final role = roleSnapshot.data;
              switch (role) {
                case 'admin':
                  return const AdminDashbordHomepage();
                case 'barber':
                  return const BarberDashboardHome();
                case 'user':
                  return const HomePageUser();
                default:
                  return const Openingpage();
              }
            },
          );
        },
      ),
    );
  }
}
