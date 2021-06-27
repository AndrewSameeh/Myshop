// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/orders.dart';
// import '../widets/order_item.dart' as wo;
// import '../widets/app_drawer.dart';

// class OrderScreen extends StatefulWidget {
//   static String routName = './ordersScreen';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen>
//     with AutomaticKeepAliveClientMixin<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Your Orders'),
//             bottom: TabBar(
//               indicatorColor: Colors.white,
//               tabs: [
//                 Tab(icon: Icon(Icons.directions_car)),
//                 Tab(icon: Icon(Icons.directions_transit)),
//                 Tab(icon: Icon(Icons.directions_bike)),
//               ],
//             ),
//           ),
//           drawer: AppDrawer(),
//           body: TabBarView(
//             children: [
//               OrderList(),
//               OrderList(),
//               OrderList(),
//             ],
//           ),
//         ));
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class OrderList extends StatelessWidget {
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     Order orderProvider = Provider.of<Order>(context, listen: false);
//     int currentPage = 1;
//     double pixels = 0.0;
//     int totalPages;
//     _scrollController.addListener(() {
//       _scrollController.addListener(() {
//         if (_scrollController.position.pixels ==
//                 _scrollController.position.maxScrollExtent &&
//             pixels != _scrollController.position.pixels) {
//           pixels = _scrollController.position.pixels;
//           if (currentPage <= totalPages) {
//             currentPage = currentPage + 1;
//             orderProvider.fetchandsetOrders(pageNumber: currentPage);
//           }
//         }
//       });
//     });
//     return FutureBuilder(
//       future: Provider.of<Order>(context, listen: false).fetchandsetOrders(),
//       builder: (ctx, datasnapshot) {
//         if (datasnapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (datasnapshot.error != null) {
//           print(datasnapshot.error);
//           return Text(datasnapshot.error);
//         } else {
//           return Consumer<Order>(
//             builder: (ctx, orders, chikd) {
//               totalPages = orders.totalPages;
//               return ListView.builder(
//                 controller: _scrollController,
//                 itemBuilder: (ctx, index) {
//                   return (index == orders.orders.length)
//                       ? Container(
//                           margin: EdgeInsets.all(8),
//                           child: Center(child: CircularProgressIndicator()))
//                       : wo.OrderItem(orders.orders[index]);
//                 },
//                 itemCount: (currentPage < totalPages)
//                     ? orders.orders.length + 1
//                     : orders.orders.length,
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// enum OrderStatus {
//   All,
//   Pending,
// }

// // } Scaffold(
// //         appBar: AppBar(
// //             title: Text('Your Orders'),
// //             bottom: PreferredSize(
// //               preferredSize: Size.square(30.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   TextButton(
// //                       onPressed: null,
// //                       child: Text("All Orders",
// //                           style: Theme.of(context).primaryTextTheme.headline6)),
// //                   TextButton(
// //                     onPressed: null,
// //                     child: Text("Processing",
// //                         style: Theme.of(context)
// //                             .primaryTextTheme
// //                             .headline6
// //                             .copyWith(
// //                                 decoration: TextDecoration.underline,
// //                                 color: Colors.grey)),
// //                   ),
// //                   TextButton(
// //                       onPressed: null,
// //                       child: Text("Finished",
// //                           style: Theme.of(context).primaryTextTheme.headline6)),
// //                 ],
// //               ),
// //             )),
// //         drawer: AppDrawer(),
// //         body: FutureBuilder(
// //           future:
// //               Provider.of<Order>(context, listen: false).fetchandsetOrders(),
// //           builder: (ctx, datasnapshot) {
// //             if (datasnapshot.connectionState == ConnectionState.waiting) {
// //               return Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             } else if (datasnapshot.error != null) {
// //               print(datasnapshot.error);
// //               return Text(datasnapshot.error);
// //             } else {
// //               return Consumer<Order>(
// //                 builder: (ctx, orders, chikd) {
// //                   totalPages = orders.totalPages;
// //                   return ListView.builder(
// //                     controller: _scrollController,
// //                     itemBuilder: (ctx, index) {
// //                       return (index == orders.orders.length)
// //                           ? Container(
// //                               margin: EdgeInsets.all(8),
// //                               child: Center(child: CircularProgressIndicator()))
// //                           : wo.OrderItem(orders.orders[index]);
// //                     },
// //                     itemCount: (currentPage < totalPages)
// //                         ? orders.orders.length + 1
// //                         : orders.orders.length,
// //                   );
// //                 },
// //               );
// //             }
// //           },
// //         ));
// //   }
// // }

// // class OrderScreen extends StatefulWidget {
// //   static String routName = './ordersScreen';

// //   @override
// //   _OrderScreenState createState() => _OrderScreenState();
// // }

// // class _OrderScreenState extends State<OrderScreen> {
// //   var isloading = true;
// //   // @override
// //   // void initState() {
// //   //   // Provider.of<Order>(context, listen: false).fetchandsetOrders().then((_) {
// //   //   //   setState(() {
// //   //   //     isloading = false;
// //   //   //   });
// //   //   // });

// //   //   super.initState();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     //var orders = Provider.of<Order>(context);
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text('Your Orders'),
// //         ),
// //         drawer: AppDrawer(),
// //         body: FutureBuilder(
// //           future: Provider.of<Order>(context).fetchandsetOrders(),
// //           builder: (ctx, datasnapshot) {
// //             if (datasnapshot.connectionState == ConnectionState.waiting) {
// //               return Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             } else if (datasnapshot.error != null) {
// //               print(datasnapshot.error);
// //               return Text(datasnapshot.error);
// //             } else {
// //              return Consumer(
// //                 builder: (ctx, orders, chikd) {
// //                   return ListView.builder(
// //                     itemBuilder: (ctx, index) =>
// //                         wo.OrderItem(orders.orders[index]),
// //                     itemCount: orders.orders.length,
// //                   );
// //                 },
// //               );
// //             }
// //           },
// //         ));
// //   }
// // }
// //}
