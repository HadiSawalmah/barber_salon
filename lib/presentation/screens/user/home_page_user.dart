import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/barber/barber_provider.dart';
import '../../../providers/user/services_fetch.dart';
import '../../../providers/user/user_provider.dart';
import '../../widgets/user/appbar_homepage_user.dart';
import '../../widgets/user/definition_barber_homepage.dart';
import '../../widgets/user/image_homepage.dart';
import '../../widgets/user/navigation_bar_homepage.dart';
import '../../widgets/user/services_homepage.dart';
import 'definition_of_barber.dart';
import 'reservation_user.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final barberProvider = Provider.of<BarberProvider>(
        context,
        listen: false,
      );
      final serviceProvider = Provider.of<ServicesFetchProvider>(
        context,
        listen: false,
      );
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchUserData();
      barberProvider.fetchBarbers();
      serviceProvider.fetchServices();
    });
  }

  final List<String> images = [
    "assets/images/salonimage.jpeg",
    "assets/images/salonimage.jpeg",
    "assets/images/salonimage.jpeg",
  ];

  final List<String> texts = ["", "Opening Salon \n 3:00 - 11:00", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarHomepageUser(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.85,
                    initialPage: 1,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ImageHomepage(
                        imagePath: images[index],
                        text: texts[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  final services =
                      Provider.of<ServicesFetchProvider>(
                        context,
                        listen: false,
                      ).services;
                  if (services.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReservationUser(services: services[0]),
                      ),
                    );
                  }
                },
                child: const ServicesHomepage(),
              ),
              const SizedBox(height: 25),
              const Text(
                "Hair Styling Expert",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Consumer<BarberProvider>(
                builder: (context, provider, _) {
                  if (provider.barbers.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    children:
                        provider.barbers.map((barber) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DefinitionOfBarber(
                                            barber: barber,
                                          ),
                                    ),
                                  );
                                },
                                child: DefinitionBarberHomepage(barber: barber),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarHomepage(currentPageIndex: 0),
    );
  }
}
