import 'package:flutter/material.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/textfiled.dart';

void main() {
  runApp(AddExpencesAdmin());
}

class AddExpencesAdmin extends StatefulWidget {
  const AddExpencesAdmin({super.key});

  @override
  State<AddExpencesAdmin> createState() => _AddExpencesAdminState();
}

class _AddExpencesAdminState extends State<AddExpencesAdmin> {
  final List<String> _categories = [
    'Tools',
    'Products',
    'Maintenance',
    'hadisa',
    'Other',
  ];

  String? _selectedCategory;

  final TextEditingController _nameExpences = TextEditingController();
  final TextEditingController _price = TextEditingController();
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
              categoryDropdownField(),
              SizedBox(height: 237),
              ButtonAdd(text: "Add", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryDropdownField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(width: 12),
              Text(
                "*",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 4),
              Text(
                "Category :",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            hint: Text("Select category"),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            items:
                _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,

                    child: Text(category),
                  );
                }).toList(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
