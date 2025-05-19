class BarberModel {
  String barberId;
  String barberName;
  String barberEmail;
  String barberPhone;
  String barberCountry;
  String barberImage;
  String barberFacebook;
  String barberAge;

  BarberModel({
    required this.barberId,
    required this.barberName,
    required this.barberEmail,
    required this.barberPhone,
    required this.barberCountry,
    required this.barberImage,
    required this.barberFacebook,
    required this.barberAge,
  });

  // تحويل من كائن إلى خريطة (عشان نخزنها)
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
    };
  }

  // تحويل من خريطة إلى كائن (لما نجيب البيانات من Firestore)
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
    );
  }
}
