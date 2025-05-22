class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPhone;
  String role;
  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    this.role = 'user',
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      userPhone: map['userPhone'],
      role: map['role'] ?? 'user',
    );
  }
}
