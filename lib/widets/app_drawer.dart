import 'package:flutter/material.dart';
import 'package:my_shop/screens/Product_Screen.dart';
import 'package:my_shop/screens/Search_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/test.dart';
import '../screens/Pharmacy_List_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    // print(screensize.height);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hellow Friend'),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 0.7 * screensize.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //     Divider(),
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text('Shop'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('orders '),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(OrderScreen.routName);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Brand'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(Test.routName);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('My Favorite'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(
                          ProductScreen.routName,
                          arguments: {'isfavorite': true});
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text('ُAddress'),
                    onTap: () {
                      // locator<NavigationService>().navigateTopushReplacementNamed(
                      //     PharmacyListScreen.routName,
                      //     arguments: {'isfavorite': true});
                      Navigator.of(context)
                          .popAndPushNamed(PharmacyListScreen.routName);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search'),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SearchProductsScreen.routName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
