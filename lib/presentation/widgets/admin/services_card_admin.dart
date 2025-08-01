import 'package:flutter/material.dart';

import '../../../data/models/admin/services_admin.dart';

class ServicesCardAdmin extends StatelessWidget {
  final ServicesAdmin servicesAdmin;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ServicesCardAdmin({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.servicesAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.grey[200],
        elevation: 30,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 30),
                Image.network(
                  servicesAdmin.imageUrl,
                  height: 173,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(color: Color(0xffFFBB4E)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        servicesAdmin.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 68,
              bottom: 202,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: Colors.blue, size: 30),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
