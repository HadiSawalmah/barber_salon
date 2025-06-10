import 'package:flutter/material.dart';

class UpcomingDefinisionUser extends StatelessWidget {
  final String? image;
  final String? service;
  final String? date;
  final String? time;
  final VoidCallback onConfirm;
  const UpcomingDefinisionUser({
    super.key,
    this.image,
    required this.service,
    required this.date,
    required this.time,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            image != null && image!.isNotEmpty
                ? Image.network(
                  image!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
                : Image.asset(
                  'assets/images/image 4.png',
                  height: 80,
                  width: 80,
                ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        service!,
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$date     $time",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                            title: Text('Confirm delete'),
                            content: Text(
                              'Do you want to delete this appointment ?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: Text('Cancle'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );

                    if (confirm == true) {
                      onConfirm();
                    }
                  },
                  icon: Icon(Icons.delete, size: 30, color: Colors.red),
                  visualDensity: VisualDensity(horizontal: -4),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 30),
      ],
    );
  }
}
