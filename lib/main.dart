import 'package:flutter/material.dart';
import 'package:my_shop/locator.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/screens/Search_product_screen%20copy.dart';
import 'package:my_shop/screens/confirmOrderScreen.dart';
import 'Services/navigation_service.dart';
import 'providers/products_provider.dart';
import 'screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'providers/card_provider.dart';
import 'screens/cart_screen.dart';
import 'providers/orders.dart';
import 'screens/orders_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/Search_product_screen.dart';
import 'screens/test.dart';
import 'screens/brands_Screen.dart';
import 'screens/Product_Screen.dart';
import 'providers/Project/Product_Provider.dart';
import 'screens/edit_Pharmacy_screen.dart';
import './screens/Pharmacy_List_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('build');

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (ctx, aut, prev) => Products(aut.token, aut.userId),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProductsProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => AddressProvider(),
          ),
          ChangeNotifierProxyProvider<Auth, Order>(
            create: null,
            update: (ctx, aut, prev) => Order(aut.token, aut.userId),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, data, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Myshop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: //Test(),
                data.isAuth
                    ? Test()
                    : FutureBuilder(
                        future: data.autoLogin(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen()),
            navigatorKey: locator<NavigationService>().navigationKey,
            routes: {
              //  ProductOverviewScreen.routName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
              CartScreen.routName: (ctx) => CartScreen(),
              OrderScreen.routName: (ctx) => OrderScreen(),
              SearchProductsScreen.routName: (ctx) => SearchProductsScreen(),
              Test.routName: (ctx) => Test(),
              BrandsScreen.routName: (ctx) => BrandsScreen(),
              ProductScreen.routName: (ctx) => ProductScreen(),
              EditPharmacyScreen.routName: (ctx) => EditPharmacyScreen(),
              PharmacyListScreen.routName: (ctx) => PharmacyListScreen(),
              SearchProductsScreenCopy.routName: (ctx) =>
                  SearchProductsScreenCopy(),
              ConfirmOrder.routName: (ctx) => ConfirmOrder(),
            },
          ),
        ));
  }
}
