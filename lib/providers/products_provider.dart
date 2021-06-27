import 'dart:convert';

import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  String token;
  String _userId;
  Products(this.token, this._userId);
  List<Product> _items = [];

  Future<void> loaddata({bool filterbyuser = false}) async {
    // try {
    //   String filter =
    //       filterbyuser ? '&orderBy="userId"&equalTo="$_userId"' : '';
    //   String url =
    //       'https://flutter-f44f7.firebaseio.com/products.json?auth=$token&$filter';
    //   final response = await http.get(url);

    //   final favoriteurl =
    //       'https://flutter-f44f7.firebaseio.com/userFavorite/$_userId.json?auth=$token';
    //   final favoriteResponse = await http.get(favoriteurl);
    //   final favoriteResponsedata = json.decode(favoriteResponse.body);
    //   final List<Product> loadedProducts = [];
    //   final data = json.decode(response.body) as Map<String, dynamic>;

    //   if (data != null) {
    //     data.forEach((prodId, prodData) {
    //       double price = prodData['price'] as double;
    //       loadedProducts.add(Product(
    //         id: prodId,
    //         title: prodData['title'],
    //         description: prodData['description'],
    //         price: price,
    //         isfavorite: favoriteResponsedata == null
    //             ? false
    //             : favoriteResponsedata[prodId] ?? false,
    //         imageUrl: prodData['imageUrl'],
    //       ));
    //     });
    //   }
    //   _items = loadedProducts;
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    // }
  }

  List<Product> get items {
    return [..._items]; //copy of object
  }

  List<Product> get favorateItems {
    return _items.where((product) => product.isfavorite).toList();
  }

  Future<void> addProduct(Product product) {
    var x = json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      // 'isfavorite': product.isfavorite
      'userId': _userId
    });
    String url =
        'https://flutter-f44f7.firebaseio.com/products.json?auth=$token';
    return http.post(url, body: x).then((response) {
      final prod = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(prod);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> updateproduct(Product product) async {
    final index = _items.indexWhere((pro) => pro.id == product.id);
    try {
      if (index >= 0) {
        final link =
            'https://flutter-f44f7.firebaseio.com/products/${product.id}.json?auth=$token';
        await http.patch(link,
            body: json.encode({
              'title': product.title,
              'price': product.price.toString(),
              //'isfavorite': product.isfavorite,
              'description': product.description,
              'imageUrl': product.imageUrl
            }));

        _items[index] = product;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Product findByid(int id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void deletproduct(int id) {
    _items.removeWhere((pro) => pro.id == id);
    notifyListeners();
  }
}
