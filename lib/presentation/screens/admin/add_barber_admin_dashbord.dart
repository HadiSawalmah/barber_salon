import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/models/barber_model.dart';
import '../../widgets/admin/appbar_admin.dart';
import '../../widgets/admin/button_add_admin.dart';
import '../../widgets/admin/textfiled.dart';

void main() {
  runApp(AddBarber());
}

class AddBarber extends StatefulWidget {
  const AddBarber({super.key});
  @override
  State<AddBarber> createState() => _AddBarberState();
}

class _AddBarberState extends State<AddBarber> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _country = TextEditingController();

  final TextEditingController _facebookAccount = TextEditingController();

  final TextEditingController _age = TextEditingController();

  final TextEditingController _uploadImage = TextEditingController();

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

                    final newBarber = BarberModel(
                      barberId: barberId,
                      barberName: _username.text,
                      barberEmail: _email.text,
                      barberPhone: _phoneNumber.text,
                      barberCountry: _country.text,
                      barberImage:
                          _uploadImage.text, // لاحقًا تستبدله ب upload حقيقي
                      barberFacebook: _facebookAccount.text,
                      barberAge: _age.text,
                    );

                    await FirebaseFirestore.instance
                        .collection('barbers')
                        .doc(barberId)
                        .set(newBarber.toMap());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تمت إضافة الحلاق بنجاح ✅")),
                    );

                    // مسح الحقول بعد الإدخال
                    _username.clear();
                    _email.clear();
                    _phoneNumber.clear();
                    _country.clear();
                    _uploadImage.clear();
                    _facebookAccount.clear();
                    _age.clear();
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
