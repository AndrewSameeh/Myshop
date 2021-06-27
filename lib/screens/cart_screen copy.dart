// import 'package:flutter/material.dart';
// import '../providers/card_provider.dart';
// import 'package:provider/provider.dart';
// import '../widets/cart_item.dart' as ci;

// class CartScreen extends StatelessWidget {
//   static String routName = './CartScreen';
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Card(
//             margin: EdgeInsets.all(15),
//             child: Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       'Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Spacer(),
//                     Chip(
//                       label: Text(
//                         '\$${cart.totalAmount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           color: Theme.of(context)
//                               .primaryTextTheme
//                               .headline6
//                               .color,
//                         ),
//                       ),
//                       backgroundColor: Theme.of(context).primaryColor,
//                     ),
//                     OrderNow(cart: cart)
//                   ],
//                 )),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//               child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             itemBuilder: (cont, index) {
//               var mycart = cart.items[index];
//               return ci.CartItem(
//                   mycart.id, mycart.price, mycart.quantity, mycart.title);
//             },
//             itemCount: cart.items.length,
//           ))
//         ],
//       ),
//     );
//   }
// }

// class OrderNow extends StatefulWidget {
//   const OrderNow({
//     Key key,
//     @required this.cart,
//   }) : super(key: key);

//   final Cart cart;

//   @override
//   _OrderNowState createState() => _OrderNowState();
// }

// class _OrderNowState extends State<OrderNow> {
//   var _isloading = false;
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: widget.cart.totalAmount <= 0 || _isloading
//           ? null
//           : () async {
//               setState(() {
//                 _isloading = true;
//               });

//               widget.cart.orderNow();
//               //  await  Provider.of<Order>(context, listen: false).addOrder(
//               //     widget.cart.items,
//               //     widget.cart.totalAmount,
//               //   );
//               setState(() {
//                 _isloading = false;
//               });
//               widget.cart.clear();
//             },
//       child: _isloading
//           ? CircularProgressIndicator()
//           : Text(
//               'order now',
//               style: TextStyle(
//                   color: widget.cart.totalAmount <= 0 || _isloading
//                       ? Colors.grey
//                       : Theme.of(context).primaryColor),
//             ),
//       //textColor: Theme.of(context).primaryColor,
//     );
//   }
// }
