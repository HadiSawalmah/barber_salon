import 'package:go_router/go_router.dart';
import 'package:project_new/main.dart';
import 'package:provider/provider.dart';
import '../../auth.dart';
import '../../data/models/admin/services_admin.dart';
import '../../data/models/barber/barber_model.dart';
import '../../providers/dashboard_admin_provider.dart';
import '../screens/admin/add_barber_admin_dashbord.dart';
import '../screens/admin/add_expences_admin.dart';
import '../screens/admin/add_services_admin.dart';
import '../screens/admin/admin_dashbord_homepage.dart';
import '../screens/admin/barber_page_admindashboard.dart';
import '../screens/admin/edit_barber_admin.dart';
import '../screens/admin/edit_expences_admin.dart';
import '../screens/admin/edit_services_admin.dart';
import '../screens/admin/expences_admin.dart';
import '../screens/admin/notification_admin.dart';
import '../screens/admin/notification_page_barber.dart';
import '../screens/admin/profile_admin.dart';
import '../screens/admin/services_page_admin.dart';
import '../screens/barber/all_notification_barber.dart';
import '../screens/barber/availability_time.dart';
import '../screens/barber/barber_dashboard_home.dart';
import '../screens/barber/login_barber.dart';
import '../screens/barber/notification_barber.dart';
import '../screens/barber/profile_page.dart';
import '../screens/barber/upcoming_barber.dart';
import '../screens/user/all_services.dart';
import '../screens/user/booking_user.dart';
import '../screens/user/definition_of_barber.dart';
import '../screens/user/home_page_user.dart';
import '../screens/user/login_user.dart';
import '../screens/user/notification_page_customer.dart';
import '../screens/user/opening_page.dart';
import '../screens/user/profile_user.dart';
import '../screens/user/reservation_user.dart';
import '../screens/user/sginup_user.dart';

import '../widgets/waiting_load_project.dart';

final GoRouter appRouter = GoRouter(
    navigatorKey: navigatorKey,

  initialLocation: "/Auth",
  routes: <RouteBase>[
    GoRoute(path: '/AddBarber', builder: (context, state) => AddBarber()),
    GoRoute(path: '/Auth', builder: (context, state) => Auth()),

    GoRoute(
      path: '/admin-dashboard',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => DashboardAdminProvider(),
          child: AdminDashbordHomepage(),
        );
      },
    ),

    GoRoute(
      path: '/AddServicesAdmin',
      builder: (context, state) => AddServicesAdmin(),
    ),
    GoRoute(
      path: '/AdminDashbordHomepage',
      builder: (context, state) => AdminDashbordHomepage(),
    ),
    GoRoute(
      path: '/AddExpencesAdmin',
      builder: (context, state) => AddExpencesAdmin(),
    ),
    GoRoute(
      path: '/BarberPageAdmindashboard',
      builder: (context, state) => BarberPageAdmindashboard(),
    ),
    GoRoute(
      path: "/EditBarber",
      builder: (context, state) {
        final barber = state.extra as BarberModel;
        return EditBarber(barber: barber);
      },
    ),
    GoRoute(
      path: '/EditServicesAdmin/:id',

      builder: (context, state) {
        final serviceId = state.pathParameters['id']!;
        return EditServicesAdmin(serviceId: serviceId);
      },
    ),
    GoRoute(
      path: '/EditExpenseAdmin/:id',

      builder: (context, state) {
        final expencesId = state.pathParameters['id']!;
        return EditExpenseAdmin(expenseId: expencesId);
      },
    ),

    GoRoute(
      path: '/DefinitionOfBarber',
      builder:
          (context, state) =>
              DefinitionOfBarber(barber: state.extra as BarberModel),
    ),
    GoRoute(
      path: '/ExpencesAdmin',
      builder: (context, state) => ExpencesAdmin(),
    ),
    GoRoute(
      path: '/NotificationAdmin',
      builder: (context, state) => NotificationAdmin(),
    ),
    GoRoute(
      path: '/BarberNotificationsPage',
      builder: (context, state) => BarberNotificationsPage(notifications: []),
    ),
    GoRoute(
      path: '/CustomerNotificationsPage',
      builder: (context, state) => CustomerNotificationsPage(),
    ),
    GoRoute(
      path: '/ServicesScreen',
      builder: (context, state) => ServicesScreen(),
    ),
    GoRoute(path: '/ProfileAdmin', builder: (context, state) => ProfileAdmin()),

    // ************************* barber routes
    GoRoute(
      path: '/AvailabilityTime',
      builder: (context, state) => AvailabilityTime(),
    ),
    GoRoute(path: '/Loginbarber', builder: (context, state) => Loginbarber()),
    GoRoute(
      path: '/BarberDashboardHome',
      builder: (context, state) => BarberDashboardHome(),
    ),

    GoRoute(
      path: '/UpcomingBarber',
      builder: (context, state) => UpcomingBarber(),
    ),
    GoRoute(path: '/ProfilePage', builder: (context, state) => ProfilePage()),
    GoRoute(
      path: '/AllNotificationBarber',
      builder: (context, state) => AllNotificationBarber(),
    ),
     GoRoute(
      path: '/NotificationBarber',
      builder: (context, state) => NotificationBarber(),
    ),
    // ************user
    GoRoute(path: '/Openingpage', builder: (context, state) => Openingpage()),
    GoRoute(
      path: '/WaitingLoadProject',
      builder: (context, state) => WaitingLoadProject(),
    ),

    GoRoute(path: '/AllServices', builder: (context, state) => AllServices()),
    GoRoute(path: '/BookingUser', builder: (context, state) => BookingUser()),

    GoRoute(path: '/ProfileUser', builder: (context, state) => ProfileUser()),

    GoRoute(
      path: '/ReservationUser',

      builder: (context, state) {
        final service = state.extra as ServicesAdmin;
        return ReservationUser(services: service);
      },
    ),

    GoRoute(path: '/HomePageUser', builder: (context, state) => HomePageUser()),
    GoRoute(path: '/Loginuser', builder: (context, state) => Loginuser()),
    GoRoute(path: '/SginupUser', builder: (context, state) => SginupUser()),
  ],
);