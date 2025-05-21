class ServicesAdmin {
  String? id;
  String title;
  double price;
  String imageUrl;

  ServicesAdmin({
    this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'price': price, 'imageUrl': imageUrl};
  }

  factory ServicesAdmin.fromMap(Map<String, dynamic> map, String id) {
    return ServicesAdmin(
      id: id,
      title: map['title'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}
