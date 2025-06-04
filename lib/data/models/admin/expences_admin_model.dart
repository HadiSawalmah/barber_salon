import 'package:cloud_firestore/cloud_firestore.dart';

class ExpencesAdminModel {
  String? id;
  String name;
  double price;
  String category;
  DateTime created;

  ExpencesAdminModel({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.created,
  });

  Map<String, dynamic> myMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'created': created,
    };
  }

  factory ExpencesAdminModel.fromMap(Map<String, dynamic> map, String id) {
    return ExpencesAdminModel(
      id: id,
      name: map['name'],
      price: (map['price'] ?? 0).toDouble(),
      category: map['category'],
      created: (map['created'] as Timestamp).toDate(),
    );
  }
}
