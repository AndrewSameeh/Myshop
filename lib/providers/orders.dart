import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/Services/order_service.dart';
import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/models/CartDTO.dart';
import 'package:my_shop/models/OrderDTO.dart';

class Order with ChangeNotifier {
  String _token;
  String _userId;
  Order(this._token, this._userId);
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  int totalPages;
  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url =
        'https://flutter-f44f7.firebaseio.com/orders/$_userId.json?auth=$_token';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': DateTime.now().toIso8601String(),
          'products': cartItems
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price.toString(),
                    'quantity': cp.quantity
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            cartItems: cartItems,
            dateTime: DateTime.now()));
    notifyListeners();
  }

  Future<void> fetchandsetOrders({int pageNumber = 1}) async {
    try {
      PagedList<OrderItem> data = await OrderService().getOrders(pageNumber);
      if (pageNumber != 1) {
        _orders.addAll(data.data);
      } else {
        _orders = [...data.data];
        totalPages = data.totalPages;
      }

      notifyListeners();
      // final url =
      //     'https://flutter-f44f7.firebaseio.com/orders/$_userId.json?auth=$_token';
      // final response = await http.get(url);
      // final List<OrderItem> loadedorders = [];
      // final exstracted = json.decode(response.body) as Map<String, dynamic>;

      // if (exstracted == null) {
      //   return;
      // }
      // exstracted.forEach((orderId, orderdata) {
      //   loadedorders.add(OrderItem(
      //       id: orderId as int,
      //       amount: orderdata['amount'],
      //       dateTime: DateTime.parse(orderdata['dateTime']),
      //       cartItems: (orderdata['products'] as List<dynamic>).map((item) {
      //         return CartItem(
      //           id: item['id'],
      //           price: double.parse(item['price']),
      //           title: item['title'],
      //           quantity: item['quantity'],
      //         );
      //       }).toList()));
      // });
      // _orders = loadedorders;
      //  notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }
}
