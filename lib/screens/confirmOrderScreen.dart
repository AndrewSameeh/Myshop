import 'package:flutter/material.dart';
import 'package:my_shop/providers/Project/Product_Provider.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/providers/card_provider.dart';
import 'package:my_shop/widets/pharmcy_Item.dart';
import 'package:my_shop/widets/productList.dart';
import 'package:provider/provider.dart';
import 'package:rich_alert/rich_alert.dart';

class ConfirmOrder extends StatelessWidget {
  static String routName = './ConfirmOrder';
  @override
  Widget build(BuildContext context) {
    final myddressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    myddressProvider.getDefultPharmacy();
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      bottomNavigationBar: Consumer<Cart>(builder: (ctx, myc, chikd) {
        return myc.itemCount > 0
            ? OrderNow(() async {
                await myc.orderNow(myddressProvider.defultPharmacy.id);
              })
            : SizedBox();
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<AddressProvider>(builder: (ctx, addressProvider, chikd) {
              return PharmacyItem(
                addressProvider.defultPharmacy,
                isdefult: true,
              );
            }),
            Expanded(
              child: Container(child:
                  Consumer<ProductsProvider>(builder: (ctx, product, chikd) {
                return ProductList(
                  totalPages: 1,
                  products: product.products,
                  callback: (currentPage) {},
                  showFavorite: false,
                  readOnly: true,
                );
              })),
            )
          ],
        ),
      ),
    );
  }
}

class OrderNow extends StatefulWidget {
  final Function ordernow;

  const OrderNow(this.ordernow);

  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 40,
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
          onPressed: isloading
              ? null
              : () async {
                  setState(() {
                    isloading = true;
                  });
                  await widget.ordernow();

                  setState(() {
                    isloading = false;
                  });
                  showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (BuildContext context) {
                        return RichAlert();
                      });
                },
          child: isloading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text('Confirm Order'),
        ),
      ),
    );
  }
}

class RichAlert extends StatelessWidget {
  const RichAlert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichAlertDialog(
      //uses the custom alert dialog
      alertTitle: richTitle("Order Sent Successfully"),
      alertSubtitle: richSubtitle(""),
      alertType: RichAlertType.SUCCESS,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            elevation: MaterialStateProperty.all<double>(2.0),
          ),
          child: Text(
            "Go To Hom",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ],
    );
  }
}
