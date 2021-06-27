import 'package:flutter/cupertino.dart';
import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/models/CartDTO.dart';

import '../../Services/product_service.dart';
import '../../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  List<Product> get favorateProducts {
    return _products.where((product) => product.isfavorite).toList();
  }

  int totalCount;
  int get productCount {
    return _products != null ? _products.length : 0;
  }

  int totalPages;
  void getProductsFromCard(List<CartItem> items) {
    List<Product> cartProducts = items
        .map((item) => Product(
            id: item.id,
            description: item.title,
            price: item.price,
            priceString: item.priceString,
            image: item.image))
        .toList();
    _products = [...cartProducts];
    // notifyListeners();
  }

  Future<void> getProducts(
      {int pageNumber = 1,
      int brandId,
      bool isfavorite = false,
      String description = ''}) async {
    PagedList<Product> data = await ProductService()
        .getProducts(pageNumber, brandId, isfavorite, description);
    if (pageNumber != 1) {
      _products.addAll(data.data);
    } else {
      _products = [...data.data];
      totalPages = data.totalPages;
    }

    notifyListeners();
  }

  void deletproduct(int id) {
    _products.removeWhere((pro) => pro.id == id);
    notifyListeners();
  }
}
