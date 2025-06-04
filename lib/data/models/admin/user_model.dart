class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String role;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role = 'user',
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'userName': name,
      'userEmail': email,
      'userPhone': phone,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['userId'],
      name: map['userName'],
      email: map['userEmail'],
      phone: map['userPhone'],
      role: map['role'] ?? 'user',
    );
  }
}
