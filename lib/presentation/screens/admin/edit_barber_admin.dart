import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/barber/barber_model.dart';
import '../../../providers/admin/add_barber_provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';

import 'package:project_new/presentation/widgets/validators.dart';

class EditBarber extends StatefulWidget {
  final BarberModel barber;
  const EditBarber({super.key, required this.barber});

  @override
  State<EditBarber> createState() => _EditBarberState();
}

class _EditBarberState extends State<EditBarber> {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  late TextEditingController _country;
  late TextEditingController _facebookAccount;
  late TextEditingController _age;
  late TextEditingController _uploadImage;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: widget.barber.name);
    _email = TextEditingController(text: widget.barber.email);
    _phoneNumber = TextEditingController(text: widget.barber.phone);
    _country = TextEditingController(text: widget.barber.barberCountry);
    _facebookAccount = TextEditingController(
      text: widget.barber.barberFacebook,
    );
    _age = TextEditingController(text: widget.barber.barberAge);
    _uploadImage = TextEditingController(text: widget.barber.barberImage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddBarberProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarAdmin(title: "Edit Barber"),
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
              

                CustomTextField(
                  label: "Photo :",
                  hint: "your photo",
                  color: Colors.white,
                  textColor: Colors.black,
                  controller: _uploadImage,
                ),

              SizedBox(height: 56),
              ButtonAdd(
                text: provider.isLoading ? "Saving..." : "Save Changes",
                onPressed: () async {
                  await provider.editBarber(
                    context: context,
                    barberId: widget.barber.id,
                    username: _username,
                    email: _email,
                    phoneNumber: _phoneNumber,
                    country: _country,
                    uploadImage: _uploadImage,
                    facebookAccount: _facebookAccount,
                    age: _age,
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
