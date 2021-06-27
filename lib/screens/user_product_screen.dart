// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/products_provider.dart';
// import '../widets/user_product_item.dart';
// import '../widets/app_drawer.dart';
// import '../screens/edit_product_screen.dart';

// class UserProductsScreen extends StatelessWidget {
//   static const String routName = './UserProduct';
//   Future<void> refresh(BuildContext context) async {
//     await Provider.of<Products>(context, listen: false)
//         .loaddata(filterbyuser: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final productdate = Provider.of<Products>(context);
//     return Scaffold(
//         drawer: AppDrawer(),
//         appBar: AppBar(
//           title: const Text('Your Products'),
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   Navigator.of(context).pushNamed(EditProductScreen.routName);
//                 }),
//           ],
//         ),
//         body: FutureBuilder(
//           future: refresh(context),
//           builder: (ctx, snapshot) =>
//               snapshot.connectionState == ConnectionState.waiting
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : RefreshIndicator(
//                       onRefresh: () => refresh(context),
//                       child: Consumer<Products>(
//                         builder: (ctx, productdate, _) => Padding(
//                           padding: EdgeInsets.all(8),
//                           child: ListView.builder(
//                             itemBuilder: (_, index) {
//                               return Column(
//                                 children: <Widget>[
//                                   UserProductItem(
//                                       productdate.items[index].id,
//                                       productdate.items[index].title,
//                                       productdate.items[index].imageUrl),
//                                   Divider()
//                                 ],
//                               );
//                             },
//                             itemCount: productdate.items.length,
//                           ),
//                         ),
//                       )),
//         ));
//   }
// }
