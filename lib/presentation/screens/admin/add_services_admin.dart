import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_new/providers/add_services_provider.dart';

import '../../widgets/admin/addimage_filed_admin.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/textfiled.dart';

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

              Textfiled("Title :", "Title", Colors.white, Colors.black, _title),
              SizedBox(height: 5),

              Textfiled("Price :", "Price", Colors.white, Colors.black, _price),
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
                  : ButtonAdd(
                    text: "Add",
                    onPressed: () async {
                      AddServicesProvider.addService(
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
