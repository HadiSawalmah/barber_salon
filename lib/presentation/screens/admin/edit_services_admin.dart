import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_new/providers/admin/add_services_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/admin/addimage_filed_admin.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';

class EditServicesAdmin extends StatefulWidget {
  final String serviceId;
  const EditServicesAdmin({super.key, required this.serviceId});

  @override
  State<EditServicesAdmin> createState() => _EditServicesAdminState();
}

class _EditServicesAdminState extends State<EditServicesAdmin> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  File? _selectedImage;
  String? existingImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchServiceData();
  }

  void fetchServiceData() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('services')
            .doc(widget.serviceId)
            .get();

    if (doc.exists) {
      final data = doc.data()!;
      _title.text = data['title'];
      _price.text = data['price'].toString();
      existingImageUrl = data['imageUrl'];
    }

    setState(() {
      isLoading = false;
    });
  }

  void updateService() async {
    if (_title.text.isEmpty || _price.text.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    final provider = Provider.of<AddServicesProvider>(context, listen: false);
    await provider.updateService(
      context: context,
      serviceId: widget.serviceId,
      title: _title.text,
      price: _price.text,
      newImage: _selectedImage,
      oldImageUrl: existingImageUrl!,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          isLoading
              ? Scaffold(
                appBar: AppBarAdmin(title: "Edit Service"),
                body: Center(child: CircularProgressIndicator()),
              )
              : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBarAdmin(title: "Edit Service"),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      SizedBox(height: 80),
                      CustomTextField(
                        label: "Title :",
                        hint: "Title",
                        color: Colors.white,
                        textColor: Colors.white,
                        controller: _title,
                        validator: Validators.text,
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        label: "Price :",
                        hint: "Price",
                        color: Colors.white,
                        textColor: Colors.white,
                        controller: _price,
                        validator: Validators.phone,
                      ),

                      SizedBox(height: 5),
                      ImagePickerContainer(
                        selectedImage: _selectedImage,
                        existingImageUrl: existingImageUrl,
                        onImagePicked: (imageFile) {
                          setState(() {
                            _selectedImage = imageFile;
                          });
                        },
                      ),
                      SizedBox(height: 100),
                      Consumer<AddServicesProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ButtonAdd(
                                text: "Update",
                                onPressed: updateService,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
