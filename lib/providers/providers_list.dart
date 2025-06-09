import 'package:project_new/providers/admin/add_barber_provider.dart';
import 'package:project_new/providers/admin/add_expences_provider.dart';
import 'package:project_new/providers/admin/add_services_provider.dart';
import 'package:project_new/providers/admin/barber_booking_provider.dart';
import 'package:project_new/providers/admin/users_acount_provider.dart';
import 'package:project_new/providers/admin_profile_provider.dart';
import 'package:project_new/providers/barber/availability_barber_provider.dart';
import 'package:project_new/providers/barber/barber_provider.dart';
import 'package:project_new/providers/dashboard_admin_provider.dart';
import 'package:project_new/providers/profile_barber_provider.dart';
import 'package:project_new/providers/user/reservation_provider_user.dart';
import 'package:project_new/providers/user/reservation_user.dart';
import 'package:project_new/providers/user/services_fetch.dart';
import 'package:project_new/providers/user/user_provider.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> providersList = [
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

  ChangeNotifierProvider(create: (context) => BarberAvailabilityProvider()),
  ChangeNotifierProvider(create: (context) => ProfileBarberProvider()),
  ChangeNotifierProvider(create: (context) => AddServicesProvider()),
];
