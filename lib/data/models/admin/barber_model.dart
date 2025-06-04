import 'package:project_new/data/models/admin/user_model.dart';

class BarberModel extends UserModel {
  String barberCountry;
  String barberImage;
  String barberFacebook;
  String barberAge;
  double? monthRevenue;
  double? yearRevenue;
  int? bookingCount;

  BarberModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required this.barberCountry,
    required this.barberImage,
    required this.barberFacebook,
    required this.barberAge,
    this.monthRevenue,
    this.yearRevenue,
    this.bookingCount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'barberId': id,
      'barberName': name,
      'barberEmail': email,
      'barberPhone': phone,
      'barberCountry': barberCountry,
      'barberImage': barberImage,
      'barberFacebook': barberFacebook,
      'barberAge': barberAge,
      'role': role,
      'monthRevenue': monthRevenue,
      'yearRevenue': yearRevenue,
      'bookingCount': bookingCount,
    };
  }

  factory BarberModel.fromMap(Map<String, dynamic> map) {
    return BarberModel(
      id: map['barberId'],
      name: map['barberName'],
      email: map['barberEmail'],
      phone: map['barberPhone'],
      barberCountry: map['barberCountry'],
      barberImage: map['barberImage'],
      barberFacebook: map['barberFacebook'],
      barberAge: map['barberAge'],
      monthRevenue: (map['monthRevenue'] ?? 0).toDouble(),
      yearRevenue: (map['yearRevenue'] ?? 0).toDouble(),
      bookingCount: (map['bookingCount'] ?? 0),
      role: map['role'] ?? 'barber',
    );
  }
}
