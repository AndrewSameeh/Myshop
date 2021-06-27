// import 'package:flutter/material.dart';
// import 'package:my_shop/Services/navigation_service.dart';
// import 'package:my_shop/locator.dart';
// import 'package:my_shop/models/utility/KeyValueItem.dart';
// import 'package:my_shop/providers/address_provider.dart';
// import 'package:provider/provider.dart';
// import '../providers/product.dart';
// import '../providers/products_provider.dart';
// import '../models/PharmacyDTO.dart';

// class EditPharmacyScreen extends StatefulWidget {
//   static const routName = './Pharmacy';
//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditPharmacyScreen> {
//   bool _isloading = false;
//   final _priceFouceNode = FocusNode();
//   final _descFouceNode = FocusNode();
//   // final _imageurlcontroller = TextEditingController();
//   final _imageFouceNode = FocusNode();
//   final _form = GlobalKey<FormState>();

//   var editPharmacy = Pharmacy(
//       address: '', city: null, governorate: null, id: 1, name: '', phone: '');
//   var editProduct = Product(
//     id: null,
//     title: '',
//     description: '',
//     price: 0,
//     imageUrl: '',
//   );
//   final TextEditingController governorateController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   AddressProvider addressProvider;
//   @override
//   void initState() async {
//     //_imageurlcontroller.addListener(_update);
//     addressProvider = Provider.of<AddressProvider>(context, listen: false);
//     await addressProvider.initAddressProvider();
//     super.initState();
//   }

//   bool _isInit = true;

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final pharmacyid = ModalRoute.of(context).settings.arguments as int;
//       if (pharmacyid != null) {
//         var editPharmacy = addressProvider.findByid(pharmacyid);
//         // _imageurlcontroller.text = editProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   void _update() {
//     // if (!_imageFouceNode.hasFocus) setState(() {});
//   }

//   @override
//   void dispose() {
//     //  _imageurlcontroller.removeListener(_update);
//     _priceFouceNode.dispose();
//     _descFouceNode.dispose();
//     // _imageurlcontroller.dispose();
//     //_imageFouceNode.dispose();
//     governorateController.dispose();
//     cityController.dispose();
//     super.dispose();
//   }

//   Future<void> _save() async {
//     var isvalid = _form.currentState.validate();

//     if (isvalid) {
//       setState(() {
//         _isloading = true;
//       });
//       _form.currentState.save();
//       var prod = Provider.of<Products>(context, listen: false);
//       if (editPharmacy.id != null) {
//         await prod.updateproduct(editProduct);
//         setState(() {
//           _isloading = false;
//         });
//         Navigator.of(context).pop();
//       } else {
//         try {
//           await prod.addProduct(editProduct);
//         } catch (error) {
//           await showDialog(
//               context: context,
//               builder: (ctx) {
//                 return AlertDialog(
//                   title: Text('An errpr '),
//                   content: Text('error'),
//                   actions: <Widget>[
//                     TextButton(
//                         onPressed: () {
//                           return Navigator.of(ctx).pop();
//                         },
//                         child: Text('okay'))
//                   ],
//                 );
//               });
//         } finally {
//           setState(() {
//             _isloading = false;
//           });
//           Navigator.of(context).pop();
//         }
//       }
//     }
//   }

//   void showMyDialog(List<KeyValueItem> values, Function onTap(int)) {
//     showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: Duration(milliseconds: 700),
//       context: context,
//       pageBuilder: (context, anim1, anim2) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: 300,
//             child: ListView.separated(
//               separatorBuilder: (_, __) => const Divider(),
//               itemCount: values.length,
//               itemBuilder: (BuildContext ctx, index) {
//                 return Card(
//                   child: InkWell(
//                     onTap: () {
//                       onTap(values[index].key);
//                       locator<NavigationService>().pop();
//                     },
//                     child: Center(
//                       child: Text(values[index].value),
//                     ),
//                   ),
//                 );
//               },
//             ), //SizedBox.expand(child: FlutterLogo()),
//             margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(0),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return SlideTransition(
//           position:
//               Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     governorateController.text = addressProvider.selectedGovernorate.value;
//     cityController.text = addressProvider.selectedGovernorate.value;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Pharmacy'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () => _save(),
//           )
//         ],
//       ),
//       body: _isloading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                   key: _form,
//                   child: ListView(
//                     children: <Widget>[
//                       TextFormField(
//                         initialValue: editPharmacy.name,
//                         decoration: InputDecoration(
//                           labelText: 'Title',
//                         ),
//                         validator: (val) {
//                           if (val.isEmpty) {
//                             return 'error';
//                           }
//                           return null;
//                         },
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(_priceFouceNode);
//                         },
//                         onSaved: (value) {
//                           // editProduct = Product(
//                           //     id: editProduct.id,
//                           //     title: value,
//                           //     description: editProduct.description,
//                           //     price: editProduct.price,
//                           //     imageUrl: editProduct.imageUrl,
//                           //     isfavorite: editProduct.isfavorite);
//                         },
//                       ),
//                       TextFormField(
//                         controller: governorateController,
//                         // initialValue: provider.selectedGovernorate.value,
//                         decoration: InputDecoration(
//                             labelText: 'Governorate',
//                             suffixIcon: Icon(Icons.arrow_forward)),
//                         onTap: () {
//                           showMyDialog(addressProvider.governorates, (id) {
//                             addressProvider.selectGoverenment(id);
//                             governorateController.text =
//                                 addressProvider.selectedGovernorate.value;
//                             return;
//                           });
//                         },
//                         // validator: (val) {
//                         //   if (val.isEmpty) {
//                         //     return 'Please enter price';
//                         //   }
//                         //   if (double.tryParse(val) <= 0) {
//                         //     return 'Please enter valid price';
//                         //   }
//                         //   return null;
//                         // },
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.number,
//                         focusNode: _priceFouceNode,
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(_descFouceNode);
//                         },
//                         onSaved: (value) {
//                           // editProduct = Product(
//                           //     id: editProduct.id,
//                           //     title: editProduct.title,
//                           //     description: editProduct.description,
//                           //     price: double.parse(value),
//                           //     imageUrl: editProduct.imageUrl,
//                           //     isfavorite: editProduct.isfavorite);
//                         },
//                       ),
//                       // Icon(Icons.arrow_forward)
//                       // ],
//                       //),
//                       TextFormField(
//                         controller: cityController,
//                         //  initialValue: provider.selectedCity.value,
//                         //   focusNode: _descFouceNode,

//                         decoration: InputDecoration(
//                             labelText: 'City',
//                             suffixIcon: Icon(Icons.arrow_forward)),
//                         // onFieldSubmitted: (_) {
//                         //   FocusScope.of(context).requestFocus(_imageFouceNode);
//                         // },
//                         onTap: () {
//                           showMyDialog(addressProvider.cities, (id) {
//                             addressProvider.selectCity(id);
//                             cityController.text =
//                                 addressProvider.selectedCity.value;
//                             //    FocusScope.of(context).unfocus();
//                             return;
//                           });
//                         },
//                         validator: (val) {
//                           if (val.isEmpty) {
//                             return 'error';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           editProduct = Product(
//                               id: editProduct.id,
//                               title: editProduct.title,
//                               description: value,
//                               price: editProduct.price,
//                               imageUrl: editProduct.imageUrl,
//                               isfavorite: editProduct.isfavorite);
//                         },
//                       ),
//                     ],
//                   )),
//             ),
//     );
//   }
// }
