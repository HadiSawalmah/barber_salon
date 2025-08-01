import 'package:cloud_firestore/cloud_firestore.dart';

class ExpencesAdminModel {
  String? id;
  String name;
  double price;
  String? category;
  DateTime? created;

  ExpencesAdminModel({
    this.id,
    required this.name,
    required this.price,
    this.category,
    this.created,
  });

  Map<String, dynamic> myMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'created': created != null ? Timestamp.fromDate(created!) : null,
    };
  }

  factory ExpencesAdminModel.fromMap(Map<String, dynamic> map, String id) {
    return ExpencesAdminModel(
      id: id,
      name: map['name'],
      price:
          map['price'] is String
              ? double.tryParse(map['price']) ?? 0.0
              : (map['price'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      created:
          map['created'] == null
              ? null
              : map['created'] is Timestamp
              ? (map['created'] as Timestamp).toDate()
              : map['created'] is String
              ? DateTime.tryParse(map['created'])
              : null,
    );
  }
}
