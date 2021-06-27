import 'package:flutter/material.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/widets/pharmcy_Item.dart';
import 'package:provider/provider.dart';
import 'edit_Pharmacy_screen.dart';

class PharmacyListScreen extends StatelessWidget {
  static const routName = './PharmacyListScreen';

  @override
  Widget build(BuildContext context) {
    var addressprovider = Provider.of<AddressProvider>(context, listen: false);
    // final isdefult =
    //     (locator<NavigationService>().myarguments() as bool) ?? false;
    final isSelectFromCard =
        (ModalRoute.of(context).settings.arguments as bool) ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Address'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                    child: FutureBuilder(
                        future: addressprovider.initAddressProvider(),
                        builder: (ctx, datasnapshot) {
                          if (datasnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (datasnapshot.error != null) {
                            // print(datasnapshot.error);
                            return Center(); // Text(datasnapshot.error,.mess);
                          } else {
                            return Consumer<AddressProvider>(
                                builder: (ctx, product, chikd) {
                              return ListView.builder(
                                  itemCount: product.pharmacies.length,
                                  itemBuilder: (context, index) {
                                    return PharmacyItem(
                                      product.pharmacies[index],
                                      isSelectFromCart: isSelectFromCard,
                                    );
                                  });
                            });
                          }
                        })))
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EditPharmacyScreen.routName);
        },
        child: const Icon(Icons.add),
      ),
      //drawer: AppDrawer() //!isdefult ? AppDrawer() : null,
    );
  }
}
