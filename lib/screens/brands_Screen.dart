import 'package:flutter/material.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';

import 'package:my_shop/widets/mycart.dart';
import '../Services/utility_service.dart';
import 'Product_Screen.dart';

class BrandsScreen extends StatelessWidget {
  static const routName = './Brands';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyShop'), actions: [MyCart()]),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                      future: UtiltiyService().getBrands(30),
                      builder: (ctx, datasnapshot) {
                        if (datasnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (datasnapshot.error != null) {
                          print(datasnapshot.error);
                          return Center(); //Text(datasnapshot.error);
                        } else {
                          List<KeyValueItem> data =
                              datasnapshot.data as List<KeyValueItem>;
                          return GridView.builder(
                              // padding: const EdgeInsets.all(10),
                              itemCount: datasnapshot.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          ProductScreen.routName,
                                          arguments: {'id': data[index].key});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          data[index].value,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            return loadingProgress == null
                                                ? Center(child: child)
                                                : Text("loadingProgress");
                                          },
                                          errorBuilder: (ctx, _, __) {
                                            return Text("errorBuilder");
                                          },
                                        ),
                                      ),
                                    ));
                              });
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
