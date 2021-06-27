import 'package:flutter/material.dart';
import 'package:my_shop/widets/mycart.dart';
import 'package:my_shop/widets/productList.dart';
import 'package:provider/provider.dart';
import '../providers/Project/Product_Provider.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  static const routName = './ProductScreen';

  void callback(int currentPage) {
    productprovider.getProducts(
        pageNumber: currentPage, brandId: brandId, isfavorite: isfavorite);
  }

  ProductsProvider productprovider;
  bool isfavorite = false;
  int brandId = 0;
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arg = ModalRoute.of(context).settings.arguments;

    brandId = arg['id'] ?? 0;
    isfavorite = (arg['isfavorite'] as bool) ?? false;
    productprovider = Provider.of<ProductsProvider>(context, listen: false);
    int totalPages = 0;

    return Scaffold(
        appBar: AppBar(
          title: isfavorite ? Text('My Favorite') : Text('Product'),
          actions: [MyCart()],
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                      child: FutureBuilder(
                          future: productprovider.getProducts(
                              brandId: brandId, isfavorite: isfavorite),
                          builder: (ctx, datasnapshot) {
                            if (datasnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (datasnapshot.error != null) {
                              // print(datasnapshot.error);
                              return Center(); // Text(datasnapshot.error,.mess);
                            } else {
                              return Consumer<ProductsProvider>(
                                  builder: (ctx, product, chikd) {
                                totalPages = product.totalPages;
                                return ProductList(
                                    totalPages: totalPages,
                                    products: product.products,
                                    callback: callback);
                              });
                            }
                          })))
            ])));
  }
}
