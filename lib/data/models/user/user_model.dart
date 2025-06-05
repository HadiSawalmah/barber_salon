class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String? userimage;
  String role;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.userimage,
    this.role = 'user',
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'userName': name,
      'userEmail': email,
      'userPhone': phone,
      'userImage': userimage ?? '',
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['userId'],
      name: map['userName'],
      email: map['userEmail'],
      phone: map['userPhone'],
      userimage: map['userimage'] ?? '',
      role: map['role'] ?? 'user',
    );
  }
}
