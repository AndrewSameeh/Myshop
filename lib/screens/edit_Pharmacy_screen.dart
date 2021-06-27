import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/providers/address_provider.dart';
import 'package:my_shop/widets/showMyDialog.dart';
import 'package:provider/provider.dart';
import '../models/PharmacyDTO.dart';

class EditPharmacyScreen extends StatefulWidget {
  static const routName = './Pharmacy';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditPharmacyScreen> {
  bool _isloading = false;
  final _priceFouceNode = FocusNode();
  final _descFouceNode = FocusNode();
  // final _imageurlcontroller = TextEditingController();
  final _form = GlobalKey<FormState>();
  final showMyDialogs = ShowMyDialogs();
  var editPharmacy = Pharmacy(
      address: '',
      city: null,
      governorate: null,
      id: null,
      name: '',
      phone: '');

  final TextEditingController governorateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  AddressProvider addressProvider;
  @override
  void initState() {
    //_imageurlcontrller.addListener(_update);
    addressProvider = Provider.of<AddressProvider>(context, listen: false);
    //addressProvider.initAddressProvider();
    super.initState();
  }

  bool _isInit = true;
  int pharmacyid;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      pharmacyid = ModalRoute.of(context).settings.arguments as int;
      if (pharmacyid != null) {
        addressProvider.findByid(pharmacyid);
        // _imageurlcontroller.text = editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //  _imageurlcontroller.removeListener(_update);
    _priceFouceNode.dispose();
    _descFouceNode.dispose();
    // _imageurlcontroller.dispose();
    //_imageFouceNode.dispose();
    governorateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    var isvalid = _form.currentState.validate();

    if (isvalid) {
      setState(() {
        _isloading = true;
      });
      _form.currentState.save();

      var addressprovider =
          Provider.of<AddressProvider>(context, listen: false);
      if (editPharmacy.id != null) {
        await addressprovider.updateAddress(editPharmacy);
        setState(() {
          _isloading = false;
        });
        Navigator.of(context).pop();
      } else {
        try {
          await addressprovider.addAddress(editPharmacy);
        } catch (error) {
          await showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text('An errpr '),
                  content: Text('error'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          return Navigator.of(ctx).pop();
                        },
                        child: Text('okay'))
                  ],
                );
              });
        } finally {
          setState(() {
            _isloading = false;
          });
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    editPharmacy = addressProvider.selectedPharmacy;
    governorateController.text = addressProvider.selectedGovernorate.value;
    cityController.text = addressProvider.selectedCity.value;
    return Scaffold(
      appBar: AppBar(
        title:
            pharmacyid != null ? Text('Edit Pharmacy') : Text('Add Pharmacy'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _save(),
          )
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      new ListTile(
                        //  leading: const Icon(Icons.label),
                        minLeadingWidth: 0,
                        minVerticalPadding: 10,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Pharmacy Name',
                          style: TextStyle(fontSize: 18),
                          // style: Theme.of(context).textTheme.subtitle2,
                        ),
                        subtitle: TextFormField(
                            initialValue: editPharmacy.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Add Pharmacy Name',
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              editPharmacy = Pharmacy(
                                id: editPharmacy.id,
                                name: value,
                                phone: editPharmacy.phone,
                                governorate: editPharmacy.governorate,
                                city: editPharmacy.city,
                                address: editPharmacy.address,
                              );
                            }),
                      ),
                      ListTile(
                        minLeadingWidth: 0,
                        minVerticalPadding: 10,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Governorate',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: TextFormField(
                          readOnly: true,
                          controller: governorateController,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.arrow_forward_ios)),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showMyDialogs.showMyDialog(
                                context,
                                'Select Governorate',
                                addressProvider.governorates,
                                addressProvider.selectedGovernorate.key, (id) {
                              addressProvider.selectGoverenment(id);

                              return;
                            });
                            governorateController.text =
                                addressProvider.selectedGovernorate.value;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // editPharmacy = Pharmacy(
                            //   id: editPharmacy.id,
                            //   name: editPharmacy.name,
                            //   phone: editPharmacy.phone,
                            //   governorate: value as int,
                            //   city: editPharmacy.city,
                            //   address: editPharmacy.address,
                            // );
                          },
                        ),
                      ),
                      ListTile(
                        minLeadingWidth: 0,
                        minVerticalPadding: 10,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'City',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: TextFormField(
                          controller: cityController,
                          readOnly: true,
                          decoration: InputDecoration(
                              //  labelText: 'City',
                              suffixIcon: Icon(Icons.arrow_forward_ios)),
                          onTap: () {
                            showMyDialogs.showMyDialog(
                                context,
                                'Select City',
                                addressProvider.cities,
                                addressProvider.selectedCity.key, (id) {
                              addressProvider.selectCity(id);
                              cityController.text =
                                  addressProvider.selectedCity.value;
                              return;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // editPharmacy = Pharmacy(
                            //   id: editPharmacy.id,
                            //   name: editPharmacy.name,
                            //   phone: editPharmacy.phone,
                            //   governorate: editPharmacy.governorate,
                            //   city: addressProvider.getCityKeyFromValue(value),
                            //   address: editPharmacy.address,
                            // );
                          },
                        ),
                      ),
                      MyListTile(
                        title: 'Address',
                        subtitle: TextFormField(
                          initialValue: editPharmacy.address,
                          decoration: InputDecoration(hintText: 'Address'),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            editPharmacy = Pharmacy(
                              id: editPharmacy.id,
                              name: editPharmacy.name,
                              phone: editPharmacy.phone,
                              governorate: editPharmacy.governorate,
                              city: editPharmacy.city,
                              address: value,
                            );
                          },
                        ),
                      ),
                      MyListTile(
                        title: 'Phone',
                        subtitle: TextFormField(
                          decoration: InputDecoration(hintText: 'Phone'),
                          keyboardType: TextInputType.phone,
                          initialValue: editPharmacy.phone,
                          maxLength: 11,
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Required';
                            }
                            if (val.length != 11) {
                              return 'invalid Number';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            editPharmacy = Pharmacy(
                              id: editPharmacy.id,
                              name: editPharmacy.name,
                              phone: value,
                              governorate: editPharmacy.governorate,
                              city: editPharmacy.city,
                              address: editPharmacy.address,
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 10,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        subtitle: subtitle);
  }
}
