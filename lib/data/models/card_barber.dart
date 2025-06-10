class Barber {
  final String name;
  final String phone;
  final String city;
  final int age;
  final String email;
  final String facebook;
  final double monthPercent;
  final double yearPercent;
  final int bookingCount;

  Barber({
    required this.name,
    required this.phone,
    required this.city,
    required this.age,
    required this.email,
    required this.facebook,
    required this.monthPercent,
    required this.yearPercent,
    required this.bookingCount,
  });

  factory Barber.fromMap(Map<String, dynamic> data) {
    return Barber(
      name: data['name'],
      phone: data['phone'],
      city: data['city'],
      age: data['age'],
      email: data['email'],
      facebook: data['facebook'],
      monthPercent: data['monthPercent'],
      yearPercent: data['yearPercent'],
      bookingCount: data['bookingCount'],
    );
  }
}
