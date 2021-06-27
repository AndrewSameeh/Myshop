import 'package:flutter/cupertino.dart';

class CartItem {
  final int id;
  final String title;
  int quantity;
  final double price;
  final String image;
  final String priceString;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.image,
      @required this.priceString});
  double get totalAmount {
    return quantity * price;
  }

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
  Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
        'ItemId': instance.id,
        'Quantity': instance.quantity,
        'Price': instance.price,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['ItemId'] as int,
        title: json['EnglishName'] as String,
        quantity: json['Quantity'] as int,
        price: json['Price'] as double,
        priceString: json['PriceString'] as String,
        image: '');
  }
}
