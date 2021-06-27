// import 'package:flutter/material.dart';
// import 'package:my_shop/providers/Project/Product_Provider.dart';
// import 'package:my_shop/providers/products_provider.dart';
// import 'package:my_shop/screens/cart_screen.dart';

// import '../widets/product_grid.dart';
// import '../widets/badge.dart';
// import 'package:provider/provider.dart';
// import '../providers/card_provider.dart';
// import '../widets/app_drawer.dart';
// import '../screens/Search_product_screen.dart';

// enum Filteroptions { favorite, all }

// class ProductOverviewScreen extends StatefulWidget {
//   static String routName = '/ProductOverviewScreen';
//   @override
//   _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
// }

// class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
//   bool showfavourateOnly = false;
//   bool _init = true;
//   bool _load = false;
//   @override
//   void didChangeDependencies() {
//     if (_init) {
//       setState(() {
//         _load = true;
//       });
//       Provider.of<Products>(context).loaddata().then((_) {
//         setState(() {
//           _load = false;
//         });
//       });
//     }
//     _init = false;
//     super.didChangeDependencies();
//   }

//   //final TextEditingController _textController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     ProductsProvider productprovider =
//         Provider.of<ProductsProvider>(context, listen: false);
//     // final productData = Provider.of<Products>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(70.0),
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
//             child: Center(
//                 child: Row(
//               children: [
//                 Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width - 100.0,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.rectangle,
//                     borderRadius: new BorderRadius.all(Radius.circular(25)),
//                   ),
//                   child: TextField(
//                     // textInputAction: TextInputAction.search,
//                     // controller: _textController,
//                     readOnly: true,
//                     onTap: () {
//                       showSearch(
//                           context: context,
//                           delegate: DataSearch(productprovider));
//                     },
//                     // onChanged: (value) {
//                     //   if (_textController.text.length == 0 ||
//                     //       _textController.text.length == 1) {
//                     //     setState(() {});
//                     //   }
//                     // },
//                     // onSubmitted: (value) {
//                     //   search();
//                     // },
//                     // style: new TextStyle(
//                     //   color: Colors.black,
//                     // ),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         //  suffixIcon: _textController.text.isNotEmpty
//                         // ? IconButton(
//                         //     icon: Icon(Icons.clear,
//                         //         color: _textController.text.length > 0
//                         //             ? Colors.green
//                         //             : Colors.red),
//                         //     onPressed: () {
//                         //       setState(() {
//                         //         _textController.clear();
//                         //       });
//                         //     })
//                         // : null,
//                         prefixIcon: IconButton(
//                           icon: Icon(Icons.search),
//                           onPressed: () {
//                             // search();
//                           },
//                         ),
//                         hintText: "Search ",
//                         hintStyle: new TextStyle(color: Colors.black38)),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Icon(
//                   Icons.photo_camera,
//                   color: Colors.white,
//                   size: 50.0,
//                 ),
//               ],
//             )),
//           ),
//         ),
//         title: Text('MyShop'),
//         actions: <Widget>[
//           PopupMenuButton(
//               onSelected: (selectedvalu) {
//                 if (selectedvalu == Filteroptions.favorite) {
//                   setState(() {
//                     showfavourateOnly = true;
//                   });
//                 } else {
//                   setState(() {
//                     showfavourateOnly = false;
//                   });
//                 }
//               },
//               itemBuilder: (_) => [
//                     PopupMenuItem(
//                       child: Text('Show favorate'),
//                       value: Filteroptions.favorite,
//                     ),
//                     PopupMenuItem(
//                       child: Text(
//                         'Show All',
//                       ),
//                       value: Filteroptions.all,
//                     )
//                   ]),
//           Consumer<Cart>(
//             builder: (_, cart, ch) =>
//                 Badge(child: ch, value: cart.itemCount.toString()),
//             child: IconButton(
//               icon: Icon(Icons.shopping_cart),
//               onPressed: () {
//                 Navigator.of(context).pushNamed(CartScreen.routName);
//               },
//             ),
//           )
//         ],
//       ),
//       drawer: AppDrawer(),
//       body: _load
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ProductGrid(showfavourateOnly),
//     );
//   }

//   // void search() {
//   //   if (_textController.text.isNotEmpty) {
//   //     FocusScope.of(context).unfocus();
//   //     Navigator.of(context).pushNamed(SearchProductsScreen.routName);
//   //     _textController.clear();
//   //   }
//   // }
// }
