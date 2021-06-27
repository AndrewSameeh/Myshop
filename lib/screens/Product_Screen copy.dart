// import 'package:flutter/material.dart';
// import 'package:my_shop/Services/navigation_service.dart';
// import 'package:my_shop/locator.dart';
// import 'package:my_shop/models/product.dart';
// import 'package:my_shop/providers/card_provider.dart';
// import 'package:my_shop/widets/mycart.dart';
// import 'package:provider/provider.dart';
// import '../providers/Project/Product_Provider.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductScreen extends StatelessWidget {
//   static const routName = './ProductScreen';

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController _scrollController = ScrollController();
//     final Map<String, Object> arg = ModalRoute.of(context).settings.arguments;
//     int currentPage = 1;
//     final int brandId = arg['id'] ?? 0;
//     final bool isfavorite = (arg['isfavorite'] as bool) ?? false;
//     double pixels = 0.0;
//     final productprovider =
//         Provider.of<ProductsProvider>(context, listen: false);
//     int totalPages = 0;
//     _scrollController.addListener(() {
//       _scrollController.addListener(() {
//         if (_scrollController.position.pixels ==
//                 _scrollController.position.maxScrollExtent &&
//             pixels != _scrollController.position.pixels) {
//           pixels = _scrollController.position.pixels;
//           if (currentPage <= totalPages) {
//             currentPage = currentPage + 1;
//             productprovider.getProducts(
//               pageNumber:   currentPage, brandId, isfavorite);
//           }
//         }
//       });
//     });

//     return Scaffold(
//         appBar: AppBar(
//           title: isfavorite ? Text('My Favorite') : Text('Product'),
//           actions: [MyCart()],
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(8),
//             child: Column(children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                   child: Container(
//                       child: FutureBuilder(
//                           future: productprovider.getProductsByBrand(
//                               currentPage, brandId, isfavorite),
//                           builder: (ctx, datasnapshot) {
//                             if (datasnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             } else if (datasnapshot.error != null) {
//                               // print(datasnapshot.error);
//                               return Center(); // Text(datasnapshot.error,.mess);
//                             } else {
//                               return Consumer<ProductsProvider>(
//                                   builder: (ctx, product, chikd) {
//                                 totalPages = product.totalPages;
//                                 return ListView.builder(
//                                     controller: _scrollController,
//                                     itemCount: (currentPage < totalPages)
//                                         ? product.productCount + 1
//                                         : product.productCount,
//                                     itemBuilder: (context, index) {
//                                       return (index == product.productCount)
//                                           ? Container(
//                                               margin: EdgeInsets.all(8),
//                                               child: Center(
//                                                   child:
//                                                       CircularProgressIndicator()))
//                                           : ProductItem(
//                                               item: product.products[index]);
//                                     });
//                               });
//                             }
//                           })))
//             ])));
//   }
// }

// class ProductItem extends StatelessWidget {
//   const ProductItem({
//     Key key,
//     @required this.item,
//   }) : super(key: key);

//   final Product item;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.all(2),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey, width: 1),
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//         ),
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Flexible(
//                   flex: 3,
//                   fit: FlexFit.tight,
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ManageImage(item: item))),
//               Flexible(
//                 flex: 7,
//                 fit: FlexFit.tight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ManageItem(item: item),
//                 ),
//               ),
//               Flexible(
//                   flex: 1,
//                   fit: FlexFit.loose,
//                   child: ChangeNotifierProvider.value(
//                     value: item,
//                     child: ManageFavorite(),
//                   )),
//             ]));
//   }
// }

// class ManageImage extends StatelessWidget {
//   const ManageImage({Key key, @required this.item}) : super(key: key);

//   final Product item;

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       item.image,
//       loadingBuilder: (context, child, loadingProgress) {
//         return loadingProgress == null
//             ? Center(child: child)
//             : LinearProgressIndicator();
//       },
//       errorBuilder: (ctx, _, __) {
//         return Image.asset('assets/images/original.png');
//       },
//       fit: BoxFit.fill,
//       height: 100,
//     );
//   }
// }

// class ManageFavorite extends StatelessWidget {
//   const ManageFavorite({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, Object> arg = ModalRoute.of(context).settings.arguments;
//     final bool isfavorite = (arg['isfavorite'] as bool) ?? false;
//     final productprovider =
//         Provider.of<ProductsProvider>(context, listen: false);
//     return Consumer<Product>(builder: (ctx, product, chikd) {
//       return IconButton(
//           icon: Icon(
//               product.isfavorite
//                   ? Icons.favorite
//                   : Icons.favorite_border, //  Icons.favorite_border,
//               color: Colors.red),
//           onPressed: () async {
//             showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (ctx) {
//                   return AlertDialog(
//                       title: Center(
//                         child: Icon(Icons.favorite, //  Icons.favorite_border,
//                             color: Colors.orange,
//                             size: 50),
//                       ),
//                       content: Container(
//                           height: 60,
//                           child: Column(children: [
//                             Center(
//                               child: product.isfavorite
//                                   ? Text('Item Started!')
//                                   : Text('Item Removed!'),
//                             ),
//                             Text(
//                                 'You can find your starred items in the side menu')
//                           ])));
//                 });

//             if (isfavorite && product.isfavorite) {
//               productprovider.deletproduct(product.id);
//             }
//             product.setfavorite();
//             await Future.delayed(Duration(seconds: 2));
//             locator<NavigationService>().pop();
//             // Navigator.pop(context);
//           });
//     });
//   }
// }

// class ManageItem extends StatelessWidget {
//   const ManageItem({
//     Key key,
//     @required this.item,
//   }) : super(key: key);

//   final Product item;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           item.description,
//           style: GoogleFonts.lato(fontSize: 16),
//           maxLines: 2,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Text(
//           item.priceString,
//           style: GoogleFonts.lato(
//               fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w900),
//           maxLines: 2,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         ManageAddProductToCart(item: item),
//       ],
//     );
//   }
// }

// class ManageAddProductToCart extends StatelessWidget {
//   const ManageAddProductToCart({Key key, @required this.item})
//       : super(key: key);

//   final Product item;

//   @override
//   Widget build(BuildContext context) {
//     final Cart cardProvider = Provider.of<Cart>(context, listen: false);
//     return Row(children: <Widget>[
//       Flexible(
//         flex: 3,
//         child: Container(
//             height: 40,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                 border: Border.all(color: Colors.grey, width: 1)),
//             child: Row(children: <Widget>[
//               Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Center(
//                       child: IconButton(
//                           icon: Icon(Icons.add_outlined,
//                               color: Theme.of(context).primaryColor, size: 20),
//                           onPressed: () {
//                             cardProvider.addItem(
//                                 item.id, item.description, 12.0);
//                           }))),
//               Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Container(
//                     height: 40,
//                     decoration: BoxDecoration(
//                         border: Border(
//                             right: BorderSide(width: 1, color: Colors.grey),
//                             left: BorderSide(width: 1, color: Colors.grey))),
//                     child: Center(child: Consumer<Cart>(
//                       builder: (ctx, card, chikd) {
//                         return Text(
//                           card.getQuantity(item.id).toString(),
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.lato(
//                               fontSize: 18,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w900),
//                         );
//                       },
//                     )),
//                   )),
//               Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Center(
//                       child: IconButton(
//                           alignment: Alignment.center,
//                           icon: Icon(
//                             Icons.remove,
//                             color: Theme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             cardProvider.removeItem(item.id);
//                           }))),
//             ])),
//       ),
//       Flexible(flex: 1, child: SizedBox()),
//     ]);
//   }
// }
