import 'package:flutter/cupertino.dart';

import 'CartDTO.dart';

class OrderItem {
  final int id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime dateTime;
  final String orderStatus;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.cartItems,
      @required this.dateTime,
      this.orderStatus});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['OrderId'] as int,
      amount: json['Amount'] as double,
      dateTime: DateTime.parse(json['OrderDate']),
      orderStatus: json['OrderStatusString'] as String,
      cartItems:
          (json['Items'] as List).map((e) => CartItem.fromJson(e)).toList(),
    );
  }
}
