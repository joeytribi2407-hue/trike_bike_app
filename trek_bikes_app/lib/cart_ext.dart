import 'package:trek_bikes_app/cart.dart';

class CartExt extends Cart {
  final String name;
  final String imageUrl;
  final double price;
  CartExt({
    required super.id,
    required super.memberId,
    required super.bikeId,
    required super.quantity,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
  @override
  Map<String, Object?> toMap() {
    // TODO: implement toMap
    var map = super.toMap();
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['price'] = price;
    return map;
  }

  factory CartExt.fromMap(Map<String, dynamic> map) {
    return CartExt(
      id: map['id'],
      memberId: map['memberId'],
      bikeId: map['bikeId'],
      quantity: map['quantity'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}