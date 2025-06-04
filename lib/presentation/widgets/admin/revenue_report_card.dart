import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../screens/admin/admin_dashbord_homepage.dart';

class RevenueReportCard extends StatelessWidget {
  final Map<String, double> dataMap;
  final Function(int) onTabSelected;
  final int selected;

  const RevenueReportCard({
    super.key,
    required this.dataMap,
    required this.onTabSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
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
                Textbutton(title: "Today", onprees: () => onTabSelected(0)),
                Textbutton(title: "Month", onprees: () => onTabSelected(1)),
                Textbutton(title: "Year", onprees: () => onTabSelected(2)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${dataMap["Income"] ?? 0}\$",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Overall Revenue",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                PieChart(
                  dataMap: dataMap,
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
