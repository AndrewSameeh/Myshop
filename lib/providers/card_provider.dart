import 'package:flutter/material.dart';
import 'package:my_shop/Services/order_service.dart';
import 'package:my_shop/models/CartDTO.dart';

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  double get totalAmount {
    double amount = 0;
    _items.forEach((item) => amount = amount + item.totalAmount);
    return amount;
  }

  List<CartItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items != null
        ? _items.fold(
            0, (previousValue, element) => previousValue + element.quantity)
        : 0;
  }

  void addItem(int productId, String title, double price, String image,
      String priceString) {
    var item = getItemById(productId);
    if (item != null) {
      item.quantity = item.quantity + 1;
    } else {
      _items.add(CartItem(
        id: productId,
        title: title,
        price: price,
        priceString: priceString,
        quantity: 1,
        image: image,
      ));
    }
    notifyListeners();
  }

  void deleteItem(int productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }

  int getQuantity(int productId) {
    var item = getItemById(productId);
    if (item == null) {
      return 0;
    }
    return item.quantity;
  }

  CartItem getItemById(int id) {
    return _items.firstWhere((element) => element.id == id, orElse: () => null);
  }

  void removeItem(int productId) {
    var item = getItemById(productId);
    if (item == null) {
      return;
    }
    if (item.quantity > 1) {
      item.quantity = item.quantity - 1;
    } else {
      _items.removeWhere((element) => element.id == productId);
    }
    notifyListeners();
  }

  Future orderNow(int addressId) async {
    await OrderService().addOrder(items, addressId);
    clear();
    notifyListeners();
  }
}
