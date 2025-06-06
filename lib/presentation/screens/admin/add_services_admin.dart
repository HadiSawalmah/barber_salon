import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/providers/admin/add_services_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/admin/addimage_filed_admin.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';

import 'package:project_new/presentation/widgets/validators.dart';

class AddServicesAdmin extends StatefulWidget {
  const AddServicesAdmin({super.key});

  @override
  State<AddServicesAdmin> createState() => _AddServicesAdminState();
}

final _title = TextEditingController();
final _price = TextEditingController();

class _AddServicesAdminState extends State<AddServicesAdmin> {
  File? _selectedImage;
  bool isLoading = false;

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

              CustomTextField(
                label: "Title :",
                hint: "add title",
                color: Colors.white,
                textColor: Colors.black,
                controller: _title,
                validator: Validators.text,
              ),
              SizedBox(height: 5),

              CustomTextField(
                label: "Price :",
                hint: "add price",
                color: Colors.white,
                textColor: Colors.black,
                controller: _price,

                validator: Validators.phone,
              ),

              SizedBox(height: 5),

              ImagePickerContainer(
                selectedImage: _selectedImage,
                onImagePicked: (imageFile) {
                  setState(() {
                    _selectedImage = imageFile;
                  });
                },
              ),
              SizedBox(height: 100),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<AddServicesProvider>(
                    builder: (context, provider, child) {
                      return ButtonAdd(
                        text:
                            provider.isLoading
                                ? "Adding Service..."
                                : "Add Service",
                        onPressed: () async {
                          if (_title.text.isEmpty ||
                              _price.text.isEmpty ||
                              _selectedImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please fill in all fields and select an image.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          provider.addService(
                            context: context,
                            title: _title.text,
                            price: _price.text,
                            image: _selectedImage!,
                            onSuccess: () {
                              _title.clear();
                              _price.clear();
                              setState(() {
                                _selectedImage = null;
                              });
                              context.pop();
                            },
                          );
                        },
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
