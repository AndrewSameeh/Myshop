import 'package:flutter/material.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/screens/confirmOrderScreen.dart';
import 'package:my_shop/widets/orderItems.dart';
import '../providers/card_provider.dart';
import 'package:provider/provider.dart';
import 'edit_Pharmacy_screen.dart';

class CartScreen extends StatelessWidget {
  static String routName = './CartScreen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    final int x = cart.items.length;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        bottomNavigationBar: Consumer<Cart>(builder: (ctx, myc, chikd) {
          return myc.itemCount > 0 ? Checkout() : SizedBox();
        }),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(5),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        Chip(
                          label: Consumer<Cart>(builder: (ctx, myc, chikd) {
                            return Text(
                              'EGP ${myc.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    .color,
                              ),
                            );
                          }),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        //  OrderNow(cart: cart)
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Consumer<Cart>(
                      child: OrderItems(cart: cart),
                      builder: (ctx, myc, child) {
                        if (cart.items.length == x)
                          return child;
                        else {
                          // x = cart.items.length;
                          return OrderItems(cart: myc);
                        }
                      })),
            ],
          ),
        ));
  }
}

class Checkout extends StatefulWidget {
  const Checkout({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isloading = false;
  AddressProvider addressProvider;
  @override
  void initState() {
    addressProvider = Provider.of<AddressProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 40,
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
          onPressed: isloading
              ? null
              : () async {
                  setState(() {
                    isloading = true;
                  });
                  if (addressProvider.pharmacies.length == 0) {
                    await addressProvider.initAddressProvider();
                  }
                  setState(() {
                    isloading = false;
                  });
                  if (addressProvider.pharmacies.length == 0) {
                    Navigator.of(context)
                        .pushNamed(EditPharmacyScreen.routName);
                  } else {
                    Navigator.of(context).pushNamed(ConfirmOrder.routName);
                  }
                },
          child: isloading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text('Check out'),
        ),
      ),
    );
  }
}

class OrderNow extends StatefulWidget {
  const OrderNow({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.totalAmount <= 0 || _isloading
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });

              // widget.cart.orderNow();

              setState(() {
                _isloading = false;
              });
              widget.cart.clear();
            },
      child: _isloading
          ? CircularProgressIndicator()
          : Text(
              'order now',
              style: TextStyle(
                  color: widget.cart.totalAmount <= 0 || _isloading
                      ? Colors.grey
                      : Theme.of(context).primaryColor),
            ),
      //textColor: Theme.of(context).primaryColor,
    );
  }
}
