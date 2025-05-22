import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/firebase/firebase_storage_service.dart';
import '../../widgets/admin/drawer_admin.dart';
import '../../widgets/admin/textfiled.dart';

void main() {
  runApp(ProfileAdmin());
}

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

final _firstname = TextEditingController();
final _lastname = TextEditingController();
final _phone = TextEditingController();
final _email = TextEditingController();
final _dateOfBirth = TextEditingController();
String? _imageUrl;

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  void initState() {
    super.initState();
    loadAdminProfile();
  }

  Future<void> loadAdminProfile() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance
            .collection('admins')
            .doc('admin')
            .get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      _firstname.text = data['firstName'] ?? '';
      _lastname.text = data['lastName'] ?? '';
      _phone.text = data['phone'] ?? '';
      _email.text = data['email'] ?? '';
      _dateOfBirth.text = data['dateOfBirth'] ?? '';
      setState(() {
        _imageUrl = data['imageUrl'];
      });
    }
  }

  Future<void> updateAdminProfile() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .doc('Z8H2YWcUWUOv6yfM48Gt')
        .update({
          'firstName': _firstname.text,
          'lastName': _lastname.text,
          'phone': _phone.text,
          'email': _email.text,
          'dateOfBirth': _dateOfBirth.text,
          'imageUrl': _imageUrl ?? '',
        });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
  }

  Future<void> pickAndUploadImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File image = File(picked.path);
      String url = await uploadImageToCloudinary(image); // أو Firebase
      setState(() {
        _imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.grey[300],
        ),
        drawer: DrawerAdmin(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage:
                        _imageUrl != null
                            ? NetworkImage(_imageUrl!)
                            : AssetImage("assets/images/face.png")
                                as ImageProvider,
                  ),

                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: pickAndUploadImage,
                  ),
                ],
              ),
              Text(
                '${_firstname.text}   ${_lastname.text}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                _email.text,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 14),

              Textfiled(
                "First Name:",
                "whats your first name?",
                Colors.white,
                Colors.black,
                _firstname,
              ),
              Textfiled(
                "Last Name:",
                "and your last name?",
                Colors.white,
                Colors.black,
                _lastname,
              ),
              Textfiled(
                "Phone :",
                "phone number",
                Colors.white,
                Colors.black,
                _phone,
              ),
              Textfiled(
                "Email :",
                "blabla@gmail.com",
                Colors.white,
                Colors.black,
                _email,
              ),
              Textfiled(
                "Date Of Birth :",
                "2003",
                Colors.white,
                Colors.black,
                _dateOfBirth,
              ),

              SizedBox(height: 33),
              SizedBox(
                height: 55,
                width: 260,
                child: ElevatedButton(
                  onPressed: updateAdminProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFBB4E),
                  ),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
