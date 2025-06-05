import 'package:project_new/data/models/user/user_model.dart';

class Admin extends UserModel {
  final String dateOfBirth;
  final String? imageUrl;

  Admin({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.role,
    super.userimage,
    required this.dateOfBirth,
    this.imageUrl,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'dateOfBirth': dateOfBirth,
      'imageUrl': imageUrl,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      dateOfBirth: map['dateOfBirth'],
      imageUrl: map['imageUrl'],
    );
  }
}
