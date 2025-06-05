import 'package:flutter/material.dart';

class ServiceItem {
  final String name;
  final String price;
  bool selected;

  ServiceItem({required this.name, required this.price, this.selected = false});
}

class CheckboxAllServices extends StatefulWidget {
  const CheckboxAllServices({super.key});

  @override
  State<CheckboxAllServices> createState() => _CheckboxAllServicesState();
}

class _CheckboxAllServicesState extends State<CheckboxAllServices> {
  List<ServiceItem> services = [
    ServiceItem(name: "Haircut", price: "25 \$"),
    ServiceItem(name: "Beard Trim", price: "10 \$"),
    ServiceItem(name: "Face Waxing", price: "5 \$"),
    ServiceItem(name: "Face Masks", price: "15 \$"),
    ServiceItem(name: "Massage Chair", price: "10 \$"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: service.selected,
                onChanged: (value) {
                  setState(() {
                    service.selected = value!;
                  });
                },
                checkColor: Colors.black,
                activeColor: Colors.green,
              ),
            ),
            Expanded(
              child: Text(
                service.name,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Text(
              service.price,
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
}