import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/models/admin/barber_model.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/textfiled.dart';
import '../../widgets/alert_dialog.dart';

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
                Textfiled(
                  "User Name :",
                  "User Name",
                  Colors.white,
                  Colors.black,
                  _username,
                ),
                Textfiled(
                  "Email :",
                  "Email",
                  Colors.white,
                  Colors.black,
                  _email,
                ),
                Textfiled(
                  "Phone Number :",
                  "Phone Number",
                  Colors.white,
                  Colors.black,
                  _phoneNumber,
                ),
                Textfiled(
                  "City :",
                  "Nablus",
                  Colors.white,
                  Colors.black,
                  _country,
                ),
                Textfiled(
                  "Facebook A ccount :",
                  "https://www.facebook.com/hadi.sawalmeh.147",
                  Colors.white,
                  Colors.black,
                  _facebookAccount,
                ),
                Textfiled("Age :", "18", Colors.white, Colors.black, _age),
                Textfiled(
                  "password :",
                  "",
                  Colors.white,
                  Colors.black,
                  _password,
                ),
                Textfiled(
                  "Upload Photo :",
                  "Upload Image",
                  Colors.white,
                  Colors.black,
                  _uploadImage,
                ),

                SizedBox(height: 56),
                ButtonAdd(
                  text: "Add",
                  onPressed: () async {
                    final barberId =
                        DateTime.now().millisecondsSinceEpoch
                            .toString(); // id مميز
                    if (_username.text.isNotEmpty &&
                        _email.text.isNotEmpty &&
                        _phoneNumber.text.isNotEmpty &&
                        _country.text.isNotEmpty &&
                        _uploadImage.text.isNotEmpty &&
                        _facebookAccount.text.isNotEmpty &&
                        _age.text.isNotEmpty &&
                        _password.text.isNotEmpty) {
                      BarberModel newBarber = BarberModel(
                        barberId: barberId,
                        barberName: _username.text,
                        barberEmail: _email.text,
                        barberPhone: _phoneNumber.text,
                        barberCountry: _country.text,
                        barberImage: _uploadImage.text,
                        barberFacebook: _facebookAccount.text,
                        barberAge: _age.text,
                      );
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: _email.text.trim(),
                            password: _password.text.trim(),
                          );

                      await FirebaseFirestore.instance
                          .collection('barbers')
                          .doc(barberId)
                          .set(newBarber.toMap());

                      _username.clear();
                      _email.clear();
                      _phoneNumber.clear();
                      _country.clear();
                      _uploadImage.clear();
                      _facebookAccount.clear();
                      _age.clear();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CustomDialog(
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                            title: "Added Successfully",
                            description: "barber have been added successfully.",
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
      ),
    );
  }
}
