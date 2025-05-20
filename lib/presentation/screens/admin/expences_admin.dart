import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';

void main() {
  runApp(ExpencesAdmin());
}

class ExpencesAdmin extends StatelessWidget {
  const ExpencesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expences"),
          toolbarHeight: 89,
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconCircleAdmin(
                icon: Icon(Icons.add_circle_outline_outlined, size: 52),
                onpress: () {
                  context.push("/AddServicesAdmin");
                },
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text("Expences Name", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 60),
                  Text("Price", style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          "Box of razors",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(color: Color(0xffFFBB4E)),

                        child: Text(
                          "10\$",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 22),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              size: 25,
                              color: const Color.fromARGB(255, 8, 43, 104),
                            ),
                          ),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              size: 25,
                              color: const Color.fromARGB(255, 8, 43, 104),
                            ),
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
}
