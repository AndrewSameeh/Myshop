import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Services/product_service.dart';

class Product with ChangeNotifier {
  final int id;
  final String description;
  final String image;
  final String priceString;
  final price;
  bool isfavorite;
  Product(
      {this.id,
      this.description,
      this.image,
      this.priceString = '',
      this.price,
      this.isfavorite = false});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['Id'] as int,
        description: json['Description'] as String,
        image: json['ImageURL'] as String,
        priceString: json['PriceString'] as String,
        isfavorite: json['Isfavorite'] as bool,
        price: json['Price'] as double);
  }
  setfavorite() async {
    isfavorite = !isfavorite;
    notifyListeners();
    await ProductService().favorite(id, isfavorite);
    // final String url = sprintf(SetFavorite, ["$id", "$isfavorite"]);
    // locator<UtiltiyService>().getListFromhttpAuthorizationPost(
    //     SetFavorite, KeyValueItem(key: id, value: isfavorite.toString()));
  }
}
