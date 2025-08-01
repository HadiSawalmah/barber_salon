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

      dashboardprovider.fetchDashboardData();
    });
  }

  Map<String, double> safeData(Map<String, double> data) {
    if (data.values.every((value) => value == 0.0)) {
      return {"No Data": 0.01};
    }
    return data;
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
      body:
          dashboardprovider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardCardOne(),
                      SizedBox(height: 16),
                      Text(
                        "Revinue report",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      RevenueReportSection(
                        selected: selected,
                        todayData: safeData({
                          "Expences": dashboardprovider.todayExpences,
                          "Income": dashboardprovider.todayRevenue,
                        }),
                        monthData: safeData({
                          "Expences": dashboardprovider.monthExpences,
                          "Income": dashboardprovider.monthRevenue,
                        }),
                        yearData: safeData({
                          "Expences": dashboardprovider.yearExpences,
                          "Income": dashboardprovider.yearRevenue,
                        }),
                        onChangeSelected: (index) async {
                          setState(() {
                            selected = index;
                          });
                          await dashboardprovider.fetchDashboardData();
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
