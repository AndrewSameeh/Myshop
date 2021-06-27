// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/card_provider.dart';

// class CartItem extends StatelessWidget {
//   final int productId;
//   final double price;
//   final int quantity;
//   final String title;
//   CartItem(this.productId, this.price, this.quantity, this.title);
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(productId),
//       background: Container(
//         color: Theme.of(context).errorColor,
//         child: Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 40,
//         ),
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.only(right: 20),
//         margin: EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       confirmDismiss: (_) {
//         return showDialog(
//             context: context,
//             builder: (ctx) {
//               return AlertDialog(
//                 title: Text('Are You sure?'),
//                 content: Text('Are you  remove it'),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () {
//                       return Navigator.of(ctx).pop(false);
//                     },
//                     child: Text('No'),
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         return Navigator.of(ctx).pop(true);
//                       },
//                       child: Text('Yes')),
//                 ],
//               );
//             });
//       },
//       onDismissed: (direction) {
//         Provider.of<Cart>(
//           context,
//           listen: false,
//         ).deleteItem(productId);
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: ListTile(
//             leading: CircleAvatar(
//                 child: Padding(
//                     padding: EdgeInsets.all(5),
//                     child: FittedBox(
//                       child: Text('\$$price'),
//                     ))),
//             title: Text(title),
//             subtitle: Text('Tootal:  \$${(price * quantity)}'),
//             trailing: Text('$quantity x'),
//           ),
//         ),
//       ),
//     );
//   }
// }
