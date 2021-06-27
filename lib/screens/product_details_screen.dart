import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routName = '/ProductDetailScreen';
  @override
  Widget build(BuildContext context) {
    final Map<String, String> arg = ModalRoute.of(context).settings.arguments;
    int id = arg['id'] as int;
    final product = Provider.of<Products>(context, listen: false);
    final productdata = product.findByid(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(productdata.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: id,
                  child: Image.network(
                    productdata.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${productdata.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: Text(
                  productdata.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ));
  }
}
