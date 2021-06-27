// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/orders.dart';
// import '../widets/order_item.dart' as wo;
// import '../widets/app_drawer.dart';

// // class OrderScreen extends StatelessWidget {
// //   static String routName = './ordersScreen';
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
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
// //                       onPressed: null,
// //                       child: Text("Processing",
// //                           style: Theme.of(context).primaryTextTheme.headline6)),
// //                   TextButton(
// //                       onPressed: null,
// //                       child: Text("Finished",
// //                           style: Theme.of(context).primaryTextTheme.headline6)),
// //                 ],
// //               ),
// //             )),
// //         //  drawer: AppDrawer(),
// //         body: Padding(padding: EdgeInsets.only(top: 0), child: Center()));
// //   }
// // }

// class OrderScreen extends StatefulWidget {
//   static String routName = './ordersScreen';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   var isloading = true;
//   // @override
//   // void initState() {
//   //   // Provider.of<Order>(context, listen: false).fetchandsetOrders().then((_) {
//   //   //   setState(() {
//   //   //     isloading = false;
//   //   //   });
//   //   // });

//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //var orders = Provider.of<Order>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Your Orders'),
//         ),
//         drawer: AppDrawer(),
//         body: FutureBuilder(
//           future: Provider.of<Order>(context).fetchandsetOrders(),
//           builder: (ctx, datasnapshot) {
//             if (datasnapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (datasnapshot.error != null) {
//               print(datasnapshot.error);
//               return Text(datasnapshot.error);
//             } else {
//               return Consumer(
//                 builder: (ctx, orders, chikd) {
//                   return ListView.builder(
//                     itemBuilder: (ctx, index) =>
//                         wo.OrderItem(orders.orders[index]),
//                     itemCount: orders.orders.length,
//                   );
//                 },
//               );
//             }
//           },
//         ));
//   }
// }
