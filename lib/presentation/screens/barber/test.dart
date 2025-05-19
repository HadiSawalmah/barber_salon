import 'package:flutter/material.dart';

import '../../widgets/admin/appbar_admin.dart';
// import 'package:test1/widget/appbar_admin.dart';

void main() {
  runApp(ConfirmData());
}

class ConfirmData extends StatelessWidget {
  const ConfirmData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBarAdmin(title: "Confirmation of data !"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("details:", style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("services :", style: TextStyle(fontSize: 22)),

                          Text(
                            "Hair Specialist :",
                            style: TextStyle(fontSize: 22),
                          ),
                          Text("Date :", style: TextStyle(fontSize: 22)),
                          Text("Total :", style: TextStyle(fontSize: 22)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hair Cuting", style: TextStyle(fontSize: 22)),
                        Text("David Startu", style: TextStyle(fontSize: 22)),
                        Text(
                          "Tuesday , 5:00-5:30",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text("25 NIS", style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
