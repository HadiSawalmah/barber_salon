import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_admin_provider.dart';
import '../../../providers/user/reservation_provider_user.dart';
import '../../widgets/admin/dashboard_booking_table.dart';
import '../../widgets/admin/dashboard_card_one.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/revenue_report_card.dart';

class AdminDashbordHomepage extends StatefulWidget {
  const AdminDashbordHomepage({super.key});

  @override
  State<AdminDashbordHomepage> createState() => _AdminDashbordHomepageState();
}

class _AdminDashbordHomepageState extends State<AdminDashbordHomepage> {
  int selected = 0;

  double _totalRevenue = 0;
  double get totalRevenue => _totalRevenue;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final dashboardprovider = Provider.of<DashboardAdminProvider>(
        context,
        listen: false,
      );

      dashboardprovider.fetchTotalExpences();
      dashboardprovider.fetchNoOfUser();
      dashboardprovider.fetchTotalRevenue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardprovider = Provider.of<DashboardAdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Finance Report"),
        backgroundColor: Colors.grey[300],
      ),
      drawer: DrawerAdmin(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardCardOne(),
              SizedBox(height: 16),
              Text(
                "Revinue report",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RevenueReportSection(
                selected: selected,
                todayData: {
                  "Expences": dashboardprovider.totalExpences,
                  "Income": dashboardprovider.totalRevenue,
                },
                monthData: {
                  "Expences": dashboardprovider.totalExpences,
                  "Income": dashboardprovider.totalRevenue,
                },
                yearData: {
                  "Expences": dashboardprovider.totalExpences,
                  "Income": dashboardprovider.totalRevenue,
                },
                onChangeSelected: (index) {
                  setState(() {
                    selected = index;
                  });
                },
              ),
              SizedBox(height: 10),
              BookingTableSection(),
            ],
          ),
        ),
      ),
    );
  }
}
