import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/admin/services_admin.dart';
import '../../../providers/admin/add_services_provider.dart';

class ServiceItem {
  final String name;
  final String price;
  bool selected;

  ServiceItem({required this.name, required this.price, this.selected = false});
}

class CheckboxAllServices extends StatefulWidget {
  final Function(List<ServicesAdmin>) onSelectionChanged;

  const CheckboxAllServices({super.key, required this.onSelectionChanged});

  @override
  State<CheckboxAllServices> createState() => _CheckboxAllServicesState();
}

class _CheckboxAllServicesState extends State<CheckboxAllServices> {
  bool isLoading = true;
  List<ServiceItem> selectedServices = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AddServicesProvider>(
        context,
        listen: false,
      ).fetchServicesFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addServicesProvider = Provider.of<AddServicesProvider>(context);
    final services = addServicesProvider.services;
    final isLoading = addServicesProvider.isLoading;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final isSelected = selectedServices.any(
              (s) => s.name == service.title,
            );

            return Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedServices.add(
                            ServiceItem(
                              name: service.title,
                              price: '${service.price} \$',
                              selected: true,
                            ),
                          );
                        } else {
                          selectedServices.removeWhere(
                            (s) => s.name == service.title,
                          );
                        }
                        widget.onSelectionChanged(
                          services
                              .where(
                                (s) => selectedServices.any(
                                  (sel) => sel.name == s.title,
                                ),
                              )
                              .toList(),
                        );
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.green,
                  ),
                ),
                Expanded(
                  child: Text(
                    service.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Text(
                  '${service.price} \$',
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
