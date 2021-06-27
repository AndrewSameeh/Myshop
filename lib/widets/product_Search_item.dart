// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/card_provider.dart';

// class ProductSearchItem extends StatelessWidget {
//   final id;
//   final String title;
//   final String imageUrl;
//   final double price;

//   ProductSearchItem(
//     this.id,
//     this.title,
//     this.imageUrl,
//     this.price,
//   );
//   @override
//   Widget build(BuildContext context) {
//     print('andrew');
//     //final productdata = Provider.of<Product>(context, listen: false);
//     final cart = Provider.of<Cart>(context, listen: false);
//     //final auth = Provider.of<Auth>(context, listen: false);
//     return ListTile(
//       title: Text(this.title),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(this.imageUrl),
//       ),
//       trailing: Container(
//         width: 200,
//         child: Row(
//           children: <Widget>[
//             IconButton(
//                 icon: Icon(
//                   Icons.add_box,
//                   color: Theme.of(context).primaryColor,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   cart.addItem(this.id, this.title, this.price, this.imageUrl,this);
//                 }),
//             Container(
//               child: Consumer<Cart>(
//                 builder: (_, cart, __) => Text(
//                   cart.items[this.id] != null
//                       ? cart.items[this.id].quantity.toString()
//                       : '0',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             IconButton(
//                 icon: Icon(
//                   Icons.indeterminate_check_box,
//                   color: Theme.of(context).primaryColor,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   // productdata.decrement();
//                   cart.removeItem(
//                     this.id,
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//   //   return ClipRRect(
//   //       borderRadius: BorderRadius.circular(10),
//   //       child: GridTile(
//   //         child: GestureDetector(
//   //             onTap: () {
//   //               Navigator.of(context).pushNamed(ProductDetailScreen.routName,
//   //                   arguments: {'id': productdata.id});
//   //             },
//   //             child: Hero(
//   //               tag: productdata.id,
//   //               child: FadeInImage(
//   //                 placeholder: AssetImage('assets/images/original.png'),
//   //                 image: NetworkImage(productdata.imageUrl),
//   //                 fit: BoxFit.cover,
//   //               ),
//   //             )),
//   //         footer: GridTileBar(
//   //           leading: Consumer<Product>(
//   //             builder: (ctc, product, child) => IconButton(
//   //                 icon: Icon(
//   //                   product.isfavorite ? Icons.favorite : Icons.favorite_border,
//   //                   color: Theme.of(context).accentColor,
//   //                 ),
//   //                 onPressed: () {
//   //                   productdata.toggleisfavorite(auth.token, auth.userId);
//   //                 }),
//   //           ),
//   //           backgroundColor: Colors.black87,
//   //           title: Text(
//   //             productdata.title,
//   //             textAlign: TextAlign.center,
//   //           ),
//   //           trailing: IconButton(
//   //               icon: Icon(
//   //                 Icons.shopping_cart,
//   //                 color: Theme.of(context).accentColor,
//   //               ),
//   //               onPressed: () {
//   //                 cart.addItem(
//   //                   productdata.id,
//   //                   productdata.title,
//   //                   productdata.price,
//   //                 );
//   //                 Scaffold.of(context).hideCurrentSnackBar();
//   //                 Scaffold.of(context).showSnackBar(SnackBar(
//   //                   content: Text(
//   //                     'Add Item To chart',
//   //                   ),
//   //                   duration: Duration(seconds: 2),
//   //                   action: SnackBarAction(
//   //                     label: 'Undo',
//   //                     onPressed: () {
//   //                       cart.removeItem(productdata.id);
//   //                     },
//   //                   ),
//   //                 ));
//   //               }),
//   //         ),
//   //       ));
//   // }
// }
