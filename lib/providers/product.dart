import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;
  bool isfavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isfavorite = false,
      this.quantity = 0});

  Future<void> toggleisfavorite(String token, String userid) async {
    isfavorite = !isfavorite;
    try {
      final link =
          'https://flutter-f44f7.firebaseio.com/userFavorite/$userid/$id.json?auth=$token';
      await http.put(link, body: json.encode(isfavorite));

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void increment() {
    this.quantity++;
    notifyListeners();
  }

  void decrement() {
    if (this.quantity != 0) this.quantity--;
    notifyListeners();
  }
}
