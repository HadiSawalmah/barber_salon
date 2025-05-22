class BarberModel {
  String barberId;
  String barberName;
  String barberEmail;
  String barberPhone;
  String barberCountry;
  String barberImage;
  String barberFacebook;
  String barberAge;
  String role;
  double? monthRevenue;
  double? yearRevenue;
  int? bookingCount;

  BarberModel({
    required this.barberId,
    required this.barberName,
    required this.barberEmail,
    required this.barberPhone,
    required this.barberCountry,
    required this.barberImage,
    required this.barberFacebook,
    required this.barberAge,
    this.role = 'barber',
    this.monthRevenue,
    this.yearRevenue,
    this.bookingCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'barberId': barberId,
      'barberName': barberName,
      'barberEmail': barberEmail,
      'barberPhone': barberPhone,
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
      barberId: map['barberId'],
      barberName: map['barberName'],
      barberEmail: map['barberEmail'],
      barberPhone: map['barberPhone'],
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
