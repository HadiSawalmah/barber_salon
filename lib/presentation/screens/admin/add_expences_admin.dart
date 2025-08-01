import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/providers/admin/add_expences_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/categorydropdownfield.dart';
import '../../widgets/textfiled.dart';

import 'package:project_new/presentation/widgets/validators.dart';

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
    final provider = Provider.of<AddExpensesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarAdmin(title: "Add Expences"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(height: 136),

            CustomTextField(
              label: "Expences Name :",
              hint: "add expences",
              color: Colors.white,
              textColor: Colors.black,
              controller: _nameExpences,
              validator: Validators.text,
            ),
            SizedBox(height: 12),

            CustomTextField(
              label: "Price :",
              hint: "add price",
              color: Colors.white,
              textColor: Colors.black,
              controller: _price,

              validator: Validators.phone,
            ),

            SizedBox(height: 12),
            Categorydropdownfield(
              initialValue: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 237),

            
            ButtonAdd(
              text: provider.isLoading ? "Loading..." : "Add",
              onPressed: () {
                
                try {
                  if ( _nameExpences.text.isEmpty || _price.text.isEmpty || _selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please fill in all fields and select a category.",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                  provider.addExpense(
                   context: context,
                    name: _nameExpences.text,
                    price: _price.text,
                    category: _selectedCategory!,
                    onSuccess: () {
                      _nameExpences.clear();
                      _price.clear();
                      setState(() {
                        _selectedCategory = null;
                      });
                      context.pop();
                    },
                  );
                } catch (e) {
                  debugPrint("🔥 Error while adding expense: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("An unexpected error occurred."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
