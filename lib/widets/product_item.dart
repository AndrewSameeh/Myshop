// import 'package:flutter/material.dart';
// import 'package:my_shop/providers/auth_provider.dart';
// import '../screens/product_details_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/product.dart';
// import '../providers/card_provider.dart';

// class ProductItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productdata = Provider.of<Product>(context, listen: false);
//     final cart = Provider.of<Cart>(context, listen: false);
//     final auth = Provider.of<Auth>(context, listen: false);
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: GridTile(
//           child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushNamed(ProductDetailScreen.routName,
//                     arguments: {'id': productdata.id});
//               },
//               child: Hero(
//                 tag: productdata.id,
//                 child: FadeInImage(
//                   placeholder: AssetImage('assets/images/original.png'),
//                   image: NetworkImage(productdata.imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               )),
//           footer: GridTileBar(
//             leading: Consumer<Product>(
//               builder: (ctc, product, child) => IconButton(
//                   icon: Icon(
//                     product.isfavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Theme.of(context).accentColor,
//                   ),
//                   onPressed: () {
//                     productdata.toggleisfavorite(auth.token, auth.userId);
//                   }),
//             ),
//             backgroundColor: Colors.black87,
//             title: Text(
//               productdata.title,
//               textAlign: TextAlign.center,
//             ),
//             trailing: IconButton(
//                 icon: Icon(
//                   Icons.shopping_cart,
//                   color: Theme.of(context).accentColor,
//                 ),
//                 onPressed: () {
//                   cart.addItem(
//                     productdata.id,
//                     productdata.title,
//                     productdata.price,
//                     productdata.imageUrl,
//                     productdata.
//                   );
//                   Scaffold.of(context).hideCurrentSnackBar();
//                   Scaffold.of(context).showSnackBar(SnackBar(
//                     content: Text(
//                       'Add Item To chart',
//                     ),
//                     duration: Duration(seconds: 2),
//                     action: SnackBarAction(
//                       label: 'Undo',
//                       onPressed: () {
//                         cart.removeItem(productdata.id);
//                       },
//                     ),
//                   ));
//                 }),
//           ),
//         ));
//   }
// }
