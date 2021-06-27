import 'package:flutter/material.dart';
import 'package:my_shop/Services/navigation_service.dart';
import 'package:my_shop/locator.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';
import 'package:my_shop/screens/brands_Screen.dart';
import 'package:my_shop/widets/app_drawer.dart';
import 'package:my_shop/widets/mycart.dart';
import '../Services/utility_service.dart';
import 'Product_Screen.dart';

class Test extends StatelessWidget {
  static const routName = './test';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyShop'), actions: [MyCart()]),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Featured Brands',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      locator<NavigationService>()
                          .navigateTo(BrandsScreen.routName);
                      //Navigator.of(context).pushNamed(BrandsScreen.routName);
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder<List<KeyValueItem>>(
                      future: UtiltiyService().getBrands(9),
                      builder: (ctx, datasnapshot) {
                        if (datasnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (datasnapshot.error != null) {
                          print(datasnapshot.error);
                          return Text(datasnapshot.error.toString());
                        } else {
                          return GridView.builder(
                              // padding: const EdgeInsets.all(10),
                              itemCount: datasnapshot.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 4 / 3,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1),
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          ProductScreen.routName,
                                          arguments: {
                                            'id': datasnapshot.data[index].key
                                          });
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
                                        child: FadeInImage(
                                          placeholder: AssetImage(
                                              'assets/images/original.png'),
                                          image: NetworkImage(
                                            datasnapshot.data[index].value,
                                          ),
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

    //    Center(
    //     child: FlatButton(
    //         onPressed: () {
    //           ServiceUtiltiy().getBrands();
    //         },
    //         child: Text("hi")),
    //   ),
    // ));
  }
}
