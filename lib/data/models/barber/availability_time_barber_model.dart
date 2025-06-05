class AvailabilityModel {
  String id;
  String barberId;
  DateTime date;
  List<Map<String, dynamic>>? availability;

  AvailabilityModel({
    required this.id,
    required this.barberId,
    required this.date,
    required this.availability,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barberId': barberId,
      'date': date.toIso8601String(),
      'availability': availability,
    };
  }

  factory AvailabilityModel.fromMap(Map<String, dynamic> map) {
    return AvailabilityModel(
      id: map['id'],
      barberId: map['barberId'],
      date: DateTime.parse(map['date']),
      availability: List<Map<String, dynamic>>.from(map['availability'] ?? []),
    );
  }
}
