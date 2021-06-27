import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/widets/badge.dart';
import 'package:my_shop/providers/card_provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({
    Key key,
  }) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print('init');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('status' + state.toString());
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (_, cart, ch) =>
          Badge(child: ch, value: cart.itemCount.toString()),
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routName);
        },
      ),
    );
  }
}
