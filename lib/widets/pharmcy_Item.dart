import 'package:flutter/material.dart';
import 'package:my_shop/models/PharmacyDTO.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/screens/Pharmacy_List_screen.dart';
import 'package:my_shop/screens/edit_Pharmacy_screen.dart';
import 'package:provider/provider.dart';

class PharmacyItem extends StatefulWidget {
  final Pharmacy pharmacy;
  final isdefult;
  final isSelectFromCart;
  final isReadOnly;
  PharmacyItem(this.pharmacy,
      {this.isdefult = false,
      this.isSelectFromCart = false,
      this.isReadOnly = true});

  @override
  _PharmacyItemState createState() => _PharmacyItemState();
}

class _PharmacyItemState extends State<PharmacyItem> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: !loading
          ? Consumer<AddressProvider>(
              builder: (context, addressProvider, child) {
              var iconButton = IconButton(
                  onPressed: () => showMyDialog(addressProvider),
                  icon: Icon(
                    Icons.delete,
                  ));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isdefult)
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ListTile(
                    isThreeLine: true,
                    minVerticalPadding: 5,
                    leading: Icon(Icons.place),
                    title: Row(
                      children: [
                        Text(widget.pharmacy.name),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.pharmacy.phone ?? ""),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.pharmacy.city.value),
                        Text(widget.pharmacy.address)
                      ],
                    ),
                    trailing: widget.isdefult
                        ? IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  PharmacyListScreen.routName,
                                  arguments: true);
                            },
                            icon: Icon(Icons.arrow_forward))
                        : widget.isSelectFromCart
                            ? IconButton(
                                onPressed: () async {
                                  addressProvider
                                      .setSelectedPharmacy(widget.pharmacy.id);
                                  await Future.delayed(
                                      Duration(milliseconds: 500));
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(widget.pharmacy.id ==
                                        addressProvider.defultPharmacy.id
                                    ? Icons.check_circle_rounded
                                    : Icons.check_circle_outline_rounded))
                            : iconButton,
                  ),
                  if (!widget.isdefult) Divider(),
                  if (!widget.isdefult)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            right: BorderSide(width: 1, color: Colors.grey),
                          )),
                          child: TextButton.icon(
                            icon: Icon(Icons.edit_location_alt_outlined),
                            label: Text('Edit'),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  EditPharmacyScreen.routName,
                                  arguments: widget.pharmacy.id);
                            },
                          ),
                        )),
                        Expanded(
                            child: TextButton.icon(
                          icon: Icon(widget.pharmacy.isDefault
                              ? Icons.star
                              : Icons.star_border),
                          label: widget.pharmacy.isDefault
                              ? Text('Default')
                              : Text('Set as Default'),
                          onPressed: () {
                            if (!widget.pharmacy.isDefault)
                              addressProvider.setDefult(widget.pharmacy.id);
                          },
                        )),
                      ],
                    ),
                ],
              );
            })
          : Center(
              child: Text('Deleting....'),
            ),
    );
  }

  void showMyDialog(AddressProvider addressProvider) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Are You sure?'),
            content: Text('Are you  remove it'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  return Navigator.of(ctx).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });

                    Navigator.of(ctx).pop(true);

                    await addressProvider.deleteAddresss(widget.pharmacy);
                    // setState(() {
                    //   loading = false;
                    // });
                  },
                  child: loading ? CircularProgressIndicator() : Text('Yes')),
            ],
          );
        });
  }
}
