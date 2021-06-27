import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/OrderDTO.dart' as o;
import 'dart:math';

class OrderItem extends StatefulWidget {
  final o.OrderItem order;
  OrderItem(this.order);
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('EGP ${widget.order.amount}   '),
                Text(widget.order.orderStatus)
              ],
            ),
            subtitle: Text(
                DateFormat('dd/mm/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min((widget.order.cartItems.length * 20.0) + 20, 100),
              child: ListView(
                  children: widget.order.cartItems
                      .map((pro) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  pro.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${pro.quantity}x EGP ${pro.price}',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}
