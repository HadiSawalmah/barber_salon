import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/firebase/firebase_options.dart';
import 'package:project_new/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

import 'providers/add_barber_provider.dart';
import 'providers/add_expences_provider.dart';
import 'providers/admin_profile_provider.dart';
import 'providers/dashboard_admin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddBarberProvider()),
        ChangeNotifierProvider(create: (_) => AddExpensesProvider()),
        ChangeNotifierProvider(create: (_) => AdminProfileProvider()),
        ChangeNotifierProvider(create: (_) => DashboardAdminProvider()),

        // AddServicesProvider is static, so you don't need ChangeNotifierProvider for it.
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
