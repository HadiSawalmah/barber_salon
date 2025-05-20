import 'package:go_router/go_router.dart';
import '../screens/admin/add_barber_admin_dashbord.dart';
import '../screens/admin/add_expences_admin.dart';
import '../screens/admin/add_services_admin.dart';
import '../screens/admin/admin_dashbord_homepage.dart';
import '../screens/admin/barber_page_admindashboard.dart';
import '../screens/admin/expences_admin.dart';
import '../screens/admin/notification_page_barber.dart';
import '../screens/admin/profile_admin.dart';
import '../screens/admin/services_page_admin.dart';
import '../screens/barber/all_notification_barber.dart';
import '../screens/barber/availability_time.dart';
import '../screens/barber/barber_dashboard_home.dart';
import '../screens/barber/notification_barber.dart';
import '../screens/barber/profile_page.dart';
import '../screens/barber/upcoming_barber.dart';
import '../screens/user/definition_of_barber.dart';
import '../screens/user/login_user.dart';
import '../screens/user/notification_page_customer.dart';
import '../screens/user/opening_page.dart';
import '../screens/user/sginup_user.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/Openingpage",
  routes: [
    GoRoute(path: '/AddBarber', builder: (context, state) => AddBarber()),
    GoRoute(
      path: '/AddExpencesAdmin',
      builder: (context, state) => AddExpencesAdmin(),
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
      path: '/BarberPageAdmindashboard',
      builder: (context, state) => BarberPageAdmindashboard(),
    ),
    GoRoute(
      path: '/DefinitionOfBarber',
      builder: (context, state) => DefinitionOfBarber(),
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
      builder: (context, state) => CustomerNotificationsPage(notifications: []),
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
      builder: (context, state) => AllNotificationBarber(notifications: []),
    ),
    // ************user
    GoRoute(path: '/Openingpage', builder: (context, state) => Openingpage()),
    GoRoute(path: '/Loginuser', builder: (context, state) => Loginuser()),
    GoRoute(path: '/SginupUser', builder: (context, state) => SginupUser()),
  ],
);
