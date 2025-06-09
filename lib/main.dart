import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/firebase/firebase_options.dart';
import 'package:project_new/data/firebase/firebase_setup.dart';
import 'package:project_new/presentation/routes/routes.dart';

import 'package:project_new/providers/admin/barber_booking_provider.dart';
import 'package:project_new/providers/admin/users_acount_provider.dart';
import 'package:project_new/providers/user/reservation_user.dart';
import 'package:provider/provider.dart';
import 'providers/admin/add_barber_provider.dart';
import 'providers/admin/add_expences_provider.dart';
import 'providers/admin/add_services_provider.dart';
import 'providers/admin_profile_provider.dart';
import 'providers/barber/barber_provider.dart';
import 'providers/dashboard_admin_provider.dart';
import 'providers/barber/availability_barber_provider.dart';
import 'providers/profile_barber_provider.dart';
import 'providers/user/reservation_provider_user.dart';
import 'providers/user/services_fetch.dart';
import 'providers/user/user_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupFirebaseMessaging();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddBarberProvider()),
        ChangeNotifierProvider(create: (context) => AddExpensesProvider()),
        ChangeNotifierProvider(create: (context) => AdminProfileProvider()),
        ChangeNotifierProvider(create: (context) => DashboardAdminProvider()),
        ChangeNotifierProvider(create: (context) => BarberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ServicesFetchProvider()),
        ChangeNotifierProvider(create: (context) => ReservationProviderUser()),
        ChangeNotifierProvider(create: (context) => UsersAcountProvider()),
        ChangeNotifierProvider(create: (_) => BarberBookingProvider(barberId)),

        ChangeNotifierProvider(
          create: (context) => BarberAvailabilityProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProfileBarberProvider()),
        ChangeNotifierProvider(create: (context) => AddServicesProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
