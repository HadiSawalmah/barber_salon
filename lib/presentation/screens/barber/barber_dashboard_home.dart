import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_barber_provider.dart';
import '../../../providers/user/reservation_provider_user.dart';
import '../../widgets/barber/appbar_homepage.dart';
import '../../widgets/barber/booking_card.dart';
import '../../widgets/barber/buttom_navigation.dart';
import '../../widgets/barber/add_availability_button.dart';
import '../../widgets/barber/title_with_underline.dart';

class BarberDashboardHome extends StatefulWidget {
  const BarberDashboardHome({super.key});
  @override
  State<BarberDashboardHome> createState() => _BarberDashboardHomeState();
}

class _BarberDashboardHomeState extends State<BarberDashboardHome> {
  @override
  void initState() {
    super.initState();
    final barberId = FirebaseAuth.instance.currentUser!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReservationProviderUser>(
        context,
        listen: false,
      ).fetchReservationsByBarber(barberId);
      Future.microtask(() {
        Provider.of<ProfileBarberProvider>(
          context,
          listen: false,
        ).fetchBarberData();
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final reservations = Provider.of<ReservationProviderUser>(context).lastFiveReservations;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = kIsWeb;
    final isWideScreen = screenWidth > 1000;
    final horizontalPadding = isWeb && isWideScreen ? (screenWidth * 0.1).clamp(24.0, 100.0) : 24.0;
    final maxContentWidth = isWeb ? 800.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isWeb ? _buildWebAppBar() : AppbarHomepage(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isWeb && isWideScreen ? 400 : double.infinity,
                    child: AddAvailabilityButton(),
                  ),
                  const SizedBox(height: 20),
                  TitleWithUnderline(title: 'Today', width: 80, size: 28),
                  const SizedBox(height: 12),
                  if (reservations.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 48, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          const Text("No reservations found", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: reservations
                          .map<Widget>(
                            (res) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: BookingCard(
                                title: res.userName,
                                service: res.serviceTitle,
                                date: res.date,
                                time: res.time,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  if (isWeb) const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: isWeb ? null : ButtomNavigation(currentPageIndex: 0),
      drawer: isWeb ? _buildWebDrawer() : null,
    );
  }

  PreferredSizeWidget _buildWebAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[600],
      elevation: 1,
      title: const Text('Barber Dashboard', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white, size: 36),
          onPressed: () {
            context.push('/NotificationBarber');
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white, size: 36),
          onPressed: () {
            context.push('/ProfilePage');
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildWebDrawer() {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            selected: true,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.white),
            title: const Text('Schedule', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
