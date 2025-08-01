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
      final barberProvider = Provider.of<BarberProvider>(context, listen: false);
      final serviceProvider = Provider.of<ServicesFetchProvider>(context, listen: false);
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;
    final maxWidth = isWeb ? 800.0 : double.infinity;
    final horizontalPadding = isWeb ? 20.0 : 8.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarHomepageUser(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    height: isWeb ? 200 : 140,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: isWeb ? 0.7 : 0.85, initialPage: 1),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: isWeb ? 12.0 : 8.0),
                          child: ImageHomepage(imagePath: images[index], text: texts[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: isWeb ? 30 : 20),
                  GestureDetector(
                    onTap: () {
                      final services = Provider.of<ServicesFetchProvider>(context, listen: false).services;
                      if (services.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ReservationUser(services: services[0])),
                        );
                      }
                    },
                    child: const ServicesHomepage(),
                  ),
                  SizedBox(height: isWeb ? 35 : 25),
                  Text(
                    "Hair Styling Expert",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isWeb ? 22 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isWeb ? 15 : 10),
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
                      if (isWeb && provider.barbers.length > 1) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: provider.barbers.length,
                          itemBuilder: (context, index) {
                            final barber = provider.barbers[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DefinitionOfBarber(barber: barber),
                                  ),
                                );
                              },
                              child: DefinitionBarberHomepage(barber: barber),
                            );
                          },
                        );
                      } else {
                        return Column(
                          children: provider.barbers.map((barber) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DefinitionOfBarber(barber: barber),
                                      ),
                                    );
                                  },
                                  child: DefinitionBarberHomepage(barber: barber),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                  if (isWeb) SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarHomepage(currentPageIndex: 0),
    );
  }
}
