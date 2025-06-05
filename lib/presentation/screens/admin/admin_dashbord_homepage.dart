import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_admin_provider.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
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
                todayData: {"Expences": 40, "Income": 20},
                monthData: {"Expences": 300, "Income": 150},
                yearData: {"Expences": 2000, "Income": 1000},
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
