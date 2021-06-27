import 'package:flutter/material.dart';
import 'package:my_shop/providers/Project/Product_Provider.dart';
import 'package:my_shop/providers/card_provider.dart';
import 'package:my_shop/widets/productList.dart';
import 'package:provider/provider.dart';

class OrderItems extends StatelessWidget {
  final Cart cart;
  OrderItems({
    @required this.cart,
  });
  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.getProductsFromCard(cart.items);

    return Column(children: [
      Expanded(child: Container(
          child: Consumer<ProductsProvider>(builder: (ctx, product, chikd) {
        return ProductList(
          totalPages: 1,
          products: product.products,
          callback: (currentPage) {},
          showFavorite: false,
        );
      }))),
    ]);
  }
}
