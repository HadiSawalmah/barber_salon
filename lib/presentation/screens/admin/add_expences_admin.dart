import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/providers/admin/add_expences_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/categorydropdownfield.dart';
import '../../widgets/textfiled.dart';

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
              textfiled(
                "Name Expences :",
                "buy machine",
                Colors.white,
                Colors.black,
                _nameExpences,
              ),
              SizedBox(height: 4),
              textfiled("Price :", "350", Colors.white, Colors.black, _price),
              SizedBox(height: 4),
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
                        context.pop();
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
