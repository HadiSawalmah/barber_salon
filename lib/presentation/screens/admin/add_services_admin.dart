import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_new/data/firebase/firebase_storage_service.dart';
import 'package:project_new/data/models/admin/services_admin.dart';

import '../../widgets/admin/addimage_filed_admin.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/textfiled.dart';
import '../../widgets/alert_dialog.dart';

void main() {
  runApp(AddServicesAdmin());
}

class AddServicesAdmin extends StatefulWidget {
  const AddServicesAdmin({super.key});

  @override
  State<AddServicesAdmin> createState() => _AddServicesAdminState();
}

final _title = TextEditingController();
final _price = TextEditingController();

class _AddServicesAdminState extends State<AddServicesAdmin> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAdmin(title: "Add Services"),

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 80),

              Textfiled("Title :", "Title", Colors.white, Colors.black, _title),
              SizedBox(height: 5),

              Textfiled("Price :", "Price", Colors.white, Colors.black, _price),
              SizedBox(height: 5),

              ImagePickerContainer(
                onImagePicked: (imageFile) {
                  setState(() {
                    _selectedImage = imageFile;
                  });
                },
              ),
              SizedBox(height: 100),
              ButtonAdd(
                text: "Add",
                onPressed: () async {
                  if (_title.text.isNotEmpty &&
                      _price.text.isNotEmpty &&
                      _selectedImage != null) {
                    String imageUrl = await uploadImageToCloudinary(
                      _selectedImage!,
                    );
                    ServicesAdmin servicesAdmin = ServicesAdmin(
                      title: _title.text,
                      price: double.parse(_price.text),
                      imageUrl: imageUrl,
                    );
                    await FirebaseFirestore.instance
                        .collection('services')
                        .add(servicesAdmin.toMap());
                    showDialog(
                      context: context,
                      builder:
                          (context) => CustomDialog(
                            icon: Icons.check_circle_outline,
                            iconColor: Colors.green,
                            title: "added Successfully",
                            description:
                                "service have been added successfully.",
                            buttonText: "Ok",
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                    );

                    _title.clear();
                    _price.clear();
                    setState(() {
                      _selectedImage = null;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder:
                          (context) => CustomDialog(
                            icon: Icons.error_outline,
                            iconColor: Colors.red,
                            title: "Failed Operation",
                            description:
                                "All fields must be completed and an image added before adding.",
                            buttonText: "Ok",
                            onButtonPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
