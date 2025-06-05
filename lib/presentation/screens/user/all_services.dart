import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/user/appbar_user.dart';

import '../../widgets/user/checkbox_all_services.dart';
import '../../widgets/user/navigation_bar_homepage.dart';


class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarUser(title: "Comprehensive service"),
      body: SingleChildScrollView(
        child: Column(children: [CheckboxAllServices()]),
      ),
      bottomNavigationBar: NavigationBarHomepage(currentPageIndex: 1),
    );
  }
}
