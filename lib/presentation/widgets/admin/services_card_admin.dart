import 'package:flutter/material.dart';

import '../../../data/models/services_admin.dart';

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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 30),
                Image.asset(servicesAdmin.image, height: 120),
                Container(
                  width: double.infinity,
                  height: 45,
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

              child: Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: Colors.blue, size: 30),
                  ),
                  IconButton(
                    onPressed: onEdit,
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
