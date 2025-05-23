import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_new/data/models/admin/expences_admin_model.dart';
import 'package:project_new/providers/add_expences_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/categorydropdownfield.dart';
import '../../widgets/admin/textfiled.dart';

class EditExpenseAdmin extends StatefulWidget {
  const EditExpenseAdmin({
    super.key,
    required this.expencesAdminModel,
    required this.expenseId,
  });
  final ExpencesAdminModel expencesAdminModel;
  final String expenseId;

  @override
  State<EditExpenseAdmin> createState() => _EditExpenseAdminState();
}

class _EditExpenseAdminState extends State<EditExpenseAdmin> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.expencesAdminModel.name,
    );
    _priceController = TextEditingController(
      text: widget.expencesAdminModel.price.toString(),
    );
    _selectedCategory = widget.expencesAdminModel.category;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddExpensesProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAdmin(title: "Edit Expences"),
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
                _nameController,
              ),
              SizedBox(height: 4),
              Textfiled(
                "Price :",
                "350",
                Colors.white,
                Colors.black,
                _priceController,
              ),
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
                text: provider.isLoading ? "updating..." : "update",
                onPressed: () {
                  provider.updateExpences(
                    context: context,
                    docId: widget.expencesAdminModel.id!,
                    name: _nameController.text,
                    price: _priceController.text,
                    category: _selectedCategory!,
                    onSuccess: () {
                      context.pop();
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
