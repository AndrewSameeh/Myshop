// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product.dart';
// import './product_item.dart';
// import '../providers/products_provider.dart';

// class ProductGrid extends StatelessWidget {
//   final bool _showfv;
//   ProductGrid(this._showfv);
//   @override
//   Widget build(BuildContext context) {
//     final products = Provider.of<Products>(context);
//     final List<Product> loadedProduct =
//         _showfv ? products.favorateItems : products.items;
//     return GridView.builder(
//         padding: const EdgeInsets.all(10),
//         itemCount: loadedProduct.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10),
//         itemBuilder: (context, index) {
//           return ChangeNotifierProvider.value(
//             value: loadedProduct[index],
//             child: ProductItem(),
//           );
//         });
//   }
// }
