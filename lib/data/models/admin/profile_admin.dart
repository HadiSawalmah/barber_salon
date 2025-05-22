class Admin {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dateOfBirth;
  final String? imageUrl;

  Admin({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'imageUrl': imageUrl,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
