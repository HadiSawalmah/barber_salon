import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/barber/barber_model.dart';
import '../../../providers/admin/add_barber_provider.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/textfiled.dart';

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
                "Facebook Account :",
                "Facebook",
                Colors.white,
                Colors.black,
                _facebookAccount,
              ),
              textfiled("Age :", "18", Colors.white, Colors.black, _age),
              textfiled(
                "Upload Image :",
                "Image URL",
                Colors.white,
                Colors.black,
                _uploadImage,
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
