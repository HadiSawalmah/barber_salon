import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/models/admin/expences_admin_model.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/categorydropdownfield.dart';
import '../../widgets/admin/textfiled.dart';
import '../../widgets/alert_dialog.dart';

void main() {
  runApp(AddExpencesAdmin());
}

class AddExpencesAdmin extends StatefulWidget {
  const AddExpencesAdmin({super.key});

  @override
  State<AddExpencesAdmin> createState() => _AddExpencesAdminState();
}

class _AddExpencesAdminState extends State<AddExpencesAdmin> {
  final _nameExpences = TextEditingController();
  final _price = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAdmin(title: "Add Expences"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              SizedBox(height: 136),
              Textfiled(
                "Name Expences :",
                "buy machine",
                Colors.white,
                Colors.black,
                _nameExpences,
              ),
              SizedBox(height: 4),
              Textfiled("Price :", "350", Colors.white, Colors.black, _price),
              SizedBox(height: 4),
              Categorydropdownfield(
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 237),
              ButtonAdd(
                text: "Add",
                onPressed: () async {
                  if (_nameExpences.text.isNotEmpty &&
                      _price.text.isNotEmpty &&
                      _selectedCategory != null) {
                    ExpencesAdminModel expencesAdminModel = ExpencesAdminModel(
                      name: _nameExpences.text,
                      price: double.parse(_price.text),
                      category: _selectedCategory!,
                      created: DateTime.now(),
                    );
                    await FirebaseFirestore.instance
                        .collection('expences')
                        .add(expencesAdminModel.myMap());

                    _nameExpences.clear();
                    _price.clear();
                    setState(() {
                      _selectedCategory;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return CustomDialog(
                          icon: Icons.check_circle,
                          iconColor: Colors.green,
                          title: "Added Successfully",
                          description: "Expenses have been added successfully.",
                          buttonText: "Ok",
                          onButtonPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return CustomDialog(
                          icon: Icons.error_outline,
                          iconColor: Colors.red,
                          title: "Failed Operation",
                          description:
                              "Something went wrong, please added all filed.",
                          buttonText: "OK",
                          onButtonPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
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
