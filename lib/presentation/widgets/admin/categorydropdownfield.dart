import 'package:flutter/material.dart';

final List<String> _categories = [
  'Tools',
  'Products',
  'Maintenance',
  'hadisa',
  'Other',
];

class Categorydropdownfield extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const Categorydropdownfield({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  State<Categorydropdownfield> createState() => _CategorydropdownfieldState();
}

class _CategorydropdownfieldState extends State<Categorydropdownfield> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
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
              widget.onChanged(value);
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
