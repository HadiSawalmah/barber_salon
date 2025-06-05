import 'package:flutter/material.dart';
import 'package:project_new/presentation/widgets/admin/statistics_admin_dashboard.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_admin_provider.dart';

class DashboardCardOne extends StatelessWidget {
  const DashboardCardOne({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardprovider = Provider.of<DashboardAdminProvider>(context);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatisticsAdminDashboard(
              titles: "Numbers Of Users",
              value: dashboardprovider.numOfUsers,
            ),
            SizedBox(width: 10),
            StatisticsAdminDashboard(
              titles: "Total Revenue",
              value: dashboardprovider.totalRevenue,
            ),
            SizedBox(width: 10),
            StatisticsAdminDashboard(
              titles: "Total Expence",
              value: dashboardprovider.totalExpences,
            ),
          ],
        ),
      ),
    );
  }
}
