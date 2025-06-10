import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user/services_fetch.dart';
import '../../screens/user/reservation_user.dart';
import 'services_item_hompage.dart';

class ServicesHomepage extends StatelessWidget {
  const ServicesHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ServicesFetchProvider>(context).services;
    return Container(
      height: 250,
      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6)),
      child:
          prov.isEmpty
              ? Center(child: Text("not found services"))
              : GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: prov.length,
                itemBuilder: (context, index) {
                  final service = prov[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReservationUser(services: service),
                        ),
                      );
                    },
                    child: ServicesItemHompage(
                      imagePath: service.imageUrl,
                      title: service.title,
                      price: service.price.toString(),
                    ),
                  );
                },
              ),
    );
  }
}
