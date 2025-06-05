import 'package:flutter/material.dart';
import 'package:project_new/providers/add_barber_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';
import 'package:project_new/presentation/widgets/validators.dart';
import '../../widgets/textfiled_password.dart';

void main() {
  runApp(AddBarber());
}

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarAdmin(title: "Add Barber"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),

          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  label: "User Name :",
                  hint: "User Name",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _username,

                  validator: Validators.text,
                ),
                CustomTextField(
                  label: "Email :",
                  hint: "Email ",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _email,

                  validator: Validators.email,
                ),
                CustomTextField(
                  label: "Phone Number :",
                  hint: "Phone Number ",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _phoneNumber,

                  validator: Validators.phone,
                ),
                CustomTextField(
                  label: "City :",
                  hint: "City ",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _country,

                  validator: Validators.text,
                ),

                CustomTextField(
                  label: " Facebook Account:",
                  hint: "facebook",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _facebookAccount,
                  validator: Validators.facebookUrl,
                ),

                CustomTextField(
                  label: " Age :",
                  hint: "Age",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _age,
                  validator: Validators.phone,
                ),
                PasswordTextField(
                  label: " Password:",
                  hint: "Enter password",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _password,
                  validator: Validators.password,
                ),

                CustomTextField(
                  label: "Photo :",
                  hint: "your photo",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _uploadImage,
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
                      uploadImage: _uploadImage,
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
      ),
    );
  }
}
