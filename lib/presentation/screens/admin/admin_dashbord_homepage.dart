import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/statistics_admin_dashboard.dart';

void main() {
  runApp(AdminDashbordHomepage());
}

class AdminDashbordHomepage extends StatefulWidget {
  const AdminDashbordHomepage({super.key});

  @override
  State<AdminDashbordHomepage> createState() => _AdminDashbordHomepageState();
}

class _AdminDashbordHomepageState extends State<AdminDashbordHomepage> {
  int selected = 0;

  // بيانات الشارت لكل تبويب
  final Map<String, double> todayData = {"Income": 250, "Expenses": 100};

  final Map<String, double> monthData = {"Income": 2000, "Expenses": 800};

  final Map<String, double> yearData = {"Income": 24000, "Expenses": 9600};

  final List<String> tabs = ["Today", "Month", "Year"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Finance Report"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatisticsAdminDashboard(
                        titles: "Numbers Of Users",
                        value: 20,
                      ),
                      SizedBox(width: 10),
                      StatisticsAdminDashboard(
                        titles: "Total Revenue",
                        value: 2000,
                      ),

                      SizedBox(width: 10),
                      StatisticsAdminDashboard(
                        titles: "Total Expence",
                        value: 3000,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Revinue report",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              Card(
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
                          Textbutton(title: "Today", onprees: () {}),
                          Textbutton(title: "Month", onprees: () {}),
                          Textbutton(title: "Year", onprees: () {}),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "250  \$",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Overall Revenue ",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
              ),
              SizedBox(height: 10),
              Card(
                elevation: 10,
                child: SizedBox(
                  height: 236,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text("Upcoming Booking"),
                            ),
                            TextButton(onPressed: () {}, child: Text("All")),
                            TextButton(
                              onPressed: () {},
                              child: Text("canceled"),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Start time",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Book Services",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Client",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Employee",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Column(
                            spacing: 12,
                            children: [
                              DefinitionProcess(),
                              DefinitionProcess(),
                              DefinitionProcess(),
                              DefinitionProcess(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}

class DefinitionProcess extends StatelessWidget {
  const DefinitionProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "10:29 AM",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "Hair Cut",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "Hadi",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "ahmad",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Textbutton extends StatelessWidget {
  final String title;
  final VoidCallback onprees;
  const Textbutton({super.key, required this.title, required this.onprees});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.amber,
        fixedSize: Size.fromWidth(105),
      ),
      onPressed: onprees,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
