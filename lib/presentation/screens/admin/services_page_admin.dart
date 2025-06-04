import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/admin/services_admin.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';
import '../../widgets/admin/services_card_admin.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
        backgroundColor: Colors.grey[300],
      ),
      drawer: DrawerAdmin(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconCircleAdmin(
              icon: Icon(Icons.add_circle_outline_outlined, size: 52),
              onpress: () {
                context.push("/AddServicesAdmin");
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('services')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error occurred while fetching data'),
                    );
                  }

                  final servicesDocs = snapshot.data!.docs;

                  return GridView.builder(
                    itemCount: servicesDocs.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      final data = servicesDocs[index];
                      final service = ServicesAdmin.fromMap(
                        data.data() as Map<String, dynamic>,
                        data.id,
                      );

                      return ServicesCardAdmin(
                        servicesAdmin: service,
                        onDelete: () {
                          FirebaseFirestore.instance
                              .collection('services')
                              .doc(service.id)
                              .delete();
                        },
                        onEdit: () {
                          context.push("/EditServicesAdmin/${service.id}");
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
