import 'package:flutter/material.dart';
import '../../widgets/admin/textfiled.dart';
import '../../widgets/barber/title_with_underline.dart';
import '../../widgets/user/appbar_user.dart';
import '../../widgets/user/button_user_openingpage.dart';
import '../../widgets/user/details_card.dart';


class ConfirmData extends StatefulWidget {
  const ConfirmData({super.key});

  @override
  State<ConfirmData> createState() => _ConfirmDataState();
}

class _ConfirmDataState extends State<ConfirmData> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  List<String> servicesList = [
    "Beard & Mustache",
    "Face Waxing",
    "Face Masks",
    "Massage chair",
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppbarUser(title: "Confirmation Of data !"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TitleWithUnderline(title: "Details", width: 65, size: 20),
                DetailsCard(servies: servicesList),
                SizedBox(height: 10),
                TitleWithUnderline(title: "Your Data", width: 90, size: 20),
                SizedBox(height: 10),
                Column(
                  children: [
                    Textfiled(
                      "User Name :",
                      "User Name",
                      Color(0xffD6D4CA),
                      Colors.white,
                      _username,
                    ),
                    Textfiled(
                      "Email :",
                      "...@gmail.com",
                      Color(0xffD6D4CA),
                      Colors.white,
                      _email,
                    ),
                    Textfiled(
                      "Phone Number :",
                      "05........",
                      Color(0xffD6D4CA),
                      Colors.white,
                      _phone,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonOpeningpage(
                      width: 300,
                      text: "Confirm",
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
