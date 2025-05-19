import 'package:flutter/material.dart';

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

final TextEditingController _title = TextEditingController();
final TextEditingController _price = TextEditingController();
// final TextEditingController _image = TextEditingController();

class _AddServicesAdminState extends State<AddServicesAdmin> {
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
                  // ممكن تخزن الصورة أو ترفعها مباشرة هون
                  print("Selected image path: ${imageFile?.path}");
                },
              ),
              SizedBox(height: 100),
              ButtonAdd(text: "Add", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
