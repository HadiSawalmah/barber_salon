class ReservationModel {
  final String id;
  final String userId;
  final String userName;
  final String imageUser;
  final String serviceTitle;
  final double price;
  final String barberId;
  final String barberName;
  final String? barberImage;

  final String date;
  final String time;
  final String? status;

  ReservationModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.imageUser,
    required this.serviceTitle,
    required this.price,
    required this.barberId,
    required this.barberName,
    this.barberImage,

    required this.date,
    required this.time,
    this.status,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'serviceTitle': serviceTitle,
      'userName': userName,
      'price': price,
      'imageUser': imageUser,
      'barberId': barberId,
      'barberName': barberName,
      'barberImage': barberImage,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      imageUser: map['imageUser'],
      serviceTitle: map['serviceTitle'],
      price: map['price'],
      barberId: map['barberId'],
      barberName: map['barberName'],
      barberImage: map['barberImage'],

      date: map['date'],
      time: map['time'],
      status: map['status'] ?? 'pending',
    );
  }
}
