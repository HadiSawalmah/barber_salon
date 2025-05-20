import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/services_admin.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/icon_circle_admin.dart';
import '../../widgets/admin/services_card_admin.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<ServicesAdmin> services = [
    ServicesAdmin(
      id: '1',
      title: 'HairCut',
      image: 'images/book.webp',
      price: 10,
    ),
    ServicesAdmin(
      id: '2',
      title: 'Mustache',
      image: 'images/image 4.png',
      price: 5,
    ),
    ServicesAdmin(
      id: '3',
      title: 'Mustache',
      image: 'images/face.png',
      price: 5,
    ),
    ServicesAdmin(
      id: '3',
      title: 'Mustache',
      image: 'images/face.png',
      price: 5,
    ),
    ServicesAdmin(
      id: '3',
      title: 'Mustache',
      image: 'images/face.png',
      price: 5,
    ),
    ServicesAdmin(
      id: '3',
      title: 'Mustache',
      image: 'images/face.png',
      price: 5,
    ),
  ];

  void handleDelete(ServicesAdmin service) {
    // setState(() {
    //   services.removeWhere((s) => s.id == service.id);
    // });
  }

  void handleEdit(ServicesAdmin service) {
    // افتح صفحة التعديل
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (_) => EditServiceScreen(service: service),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
        backgroundColor: Colors.grey[300],
      ),
      drawer: DrawerAdmin(),
      body: Column(
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
            child: GridView.builder(
              itemCount: services.length,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) {
                final service = services[index];
                return ServicesCardAdmin(
                  servicesAdmin: service,
                  onDelete: () => handleDelete(service),
                  onEdit: () => handleEdit(service),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
