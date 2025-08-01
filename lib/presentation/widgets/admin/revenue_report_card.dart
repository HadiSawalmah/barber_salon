import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_admin_provider.dart';
import '../textbutton.dart';

class RevenueReportSection extends StatelessWidget {
  final int selected;
  final Map<String, double> todayData;
  final Map<String, double> monthData;
  final Map<String, double> yearData;
  final Function(int) onChangeSelected;

  const RevenueReportSection({
    super.key,
    required this.selected,
    required this.todayData,
    required this.monthData,
    required this.yearData,
    required this.onChangeSelected,
  });

  Map<String, double> getSelectedData() {
    switch (selected) {
      case 0:
        return todayData;
      case 1:
        return monthData;
      case 2:
        return yearData;
      default:
        return todayData;
    }
  }

  double getSelectedTotal(DashboardAdminProvider dashboardprovider) {
    switch (selected) {
      case 0:
        return dashboardprovider.todayRevenue;
      case 1:
        return dashboardprovider.monthRevenue;
      case 2:
        return dashboardprovider.yearRevenue;
      default:
        return dashboardprovider.totalRevenue;
    }
  }

  double getSelectedTotalexpences(DashboardAdminProvider dashboardprovider) {
    switch (selected) {
      case 0:
        return dashboardprovider.todayExpences;
      case 1:
        return dashboardprovider.monthExpences;
      case 2:
        return dashboardprovider.yearExpences;
      default:
        return dashboardprovider.totalExpences;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardprovider = Provider.of<DashboardAdminProvider>(context);
    final selectedData = getSelectedData();
    final total = selectedData.values.fold(0.0, (sum, value) => sum + value);
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Color(0xffE8E0E0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Textbutton(
                  title: "Today",
                  onprees: () => onChangeSelected(0),
                  isSelected: selected == 0,
                ),
                Textbutton(
                  title: "Month",
                  onprees: () => onChangeSelected(1),
                  isSelected: selected == 1,
                ),
                Textbutton(
                  title: "Year",
                  onprees: () => onChangeSelected(2),
                  isSelected: selected == 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${getSelectedTotal(dashboardprovider)} \$",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Overall Revenue ",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${getSelectedTotalexpences(dashboardprovider)} \$",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Overall Expences ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10),

                PieChart(
                  dataMap: getSelectedData(),
                  chartType: ChartType.ring,
                  chartRadius: 120,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
