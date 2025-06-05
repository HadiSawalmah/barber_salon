import 'package:flutter/material.dart';
import 'package:project_new/providers/admin/add_barber_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';

class AddBarber extends StatefulWidget {
  const AddBarber({super.key});
  @override
  State<AddBarber> createState() => _AddBarberState();
}

class _AddBarberState extends State<AddBarber> {
  final _username = TextEditingController();

  final _email = TextEditingController();

  final _phoneNumber = TextEditingController();

  final _country = TextEditingController();

  final _facebookAccount = TextEditingController();

  final _age = TextEditingController();

  final _uploadImage = TextEditingController();

  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddBarberProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarAdmin(title: "Add Barber"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),

        child: SingleChildScrollView(
          child: Column(
            children: [
              textfiled(
                "User Name :",
                "User Name",
                Colors.white,
                Colors.black,
                _username,
              ),
              textfiled("Email :", "Email", Colors.white, Colors.black, _email),
              textfiled(
                "Phone Number :",
                "Phone Number",
                Colors.white,
                Colors.black,
                _phoneNumber,
              ),
              textfiled(
                "City :",
                "Nablus",
                Colors.white,
                Colors.black,
                _country,
              ),
              textfiled(
                "Facebook A ccount :",
                "https://www.facebook.com/hadi.sawalmeh.147",
                Colors.white,
                Colors.black,
                _facebookAccount,
              ),
              textfiled("Age :", "18", Colors.white, Colors.black, _age),
              textfiled(
                "password :",
                "password",
                Colors.white,
                Colors.black,
                _password,
              ),

              SizedBox(height: 56),
              ButtonAdd(
                text: provider.isLoading ? "Adding..." : "Add",
                onPressed: () async {
                  await provider.addBarber(
                    context: context,
                    username: _username,
                    email: _email,
                    phoneNumber: _phoneNumber,
                    country: _country,
                    facebookAccount: _facebookAccount,
                    age: _age,
                    password: _password,
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
