// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product.dart';
// import '../providers/products_provider.dart';

// class EditProductScreen extends StatefulWidget {
//   static const routName = './EditProduct';
//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   bool _isloading = false;
//   final _priceFouceNode = FocusNode();
//   final _descFouceNode = FocusNode();
//   final _imageurlcontroller = TextEditingController();
//   final _imageFouceNode = FocusNode();
//   final _form = GlobalKey<FormState>();

//   var editProduct = Product(
//     id: null,
//     title: '',
//     description: '',
//     price: 0,
//     imageUrl: '',
//   );
//   @override
//   void initState() {
//     _imageurlcontroller.addListener(_update);
//     super.initState();
//   }

//   bool _isInit = true;

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productid = ModalRoute.of(context).settings.arguments as int;
//       if (productid != null) {
//         editProduct =
//             Provider.of<Products>(context, listen: false).findByid(productid);
//         _imageurlcontroller.text = editProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   void _update() {
//     if (!_imageFouceNode.hasFocus) setState(() {});
//   }

//   @override
//   void dispose() {
//     _imageurlcontroller.removeListener(_update);
//     _priceFouceNode.dispose();
//     _descFouceNode.dispose();
//     _imageurlcontroller.dispose();
//     _imageFouceNode.dispose();
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
//       if (editProduct.id != null) {
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
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
//                         initialValue: editProduct.title,
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
//                           editProduct = Product(
//                               id: editProduct.id,
//                               title: value,
//                               description: editProduct.description,
//                               price: editProduct.price,
//                               imageUrl: editProduct.imageUrl,
//                               isfavorite: editProduct.isfavorite);
//                         },
//                       ),
//                       TextFormField(
//                         initialValue: editProduct.price.toString(),
//                         decoration: InputDecoration(
//                           labelText: 'Price',
//                         ),
//                         validator: (val) {
//                           if (val.isEmpty) {
//                             return 'Please enter price';
//                           }
//                           if (double.tryParse(val) <= 0) {
//                             return 'Please enter valid price';
//                           }
//                           return null;
//                         },
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.number,
//                         focusNode: _priceFouceNode,
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(_descFouceNode);
//                         },
//                         onSaved: (value) {
//                           editProduct = Product(
//                               id: editProduct.id,
//                               title: editProduct.title,
//                               description: editProduct.description,
//                               price: double.parse(value),
//                               imageUrl: editProduct.imageUrl,
//                               isfavorite: editProduct.isfavorite);
//                         },
//                       ),
//                       TextFormField(
//                         initialValue: editProduct.description,
//                         focusNode: _descFouceNode,
//                         maxLines: 3,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(
//                           labelText: 'Description',
//                         ),
//                         onFieldSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(_imageFouceNode);
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
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[
//                           Container(
//                             width: 100,
//                             height: 100,
//                             margin: EdgeInsets.only(top: 8, right: 10),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             child: _imageurlcontroller.text.isEmpty
//                                 ? Text('Enter URL')
//                                 : FittedBox(
//                                     child: Image.network(
//                                       _imageurlcontroller.text,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                           ),
//                           Expanded(
//                             child: TextFormField(
//                               focusNode: _imageFouceNode,
//                               decoration: InputDecoration(
//                                 labelText: 'Image Url',
//                               ),
//                               validator: (val) {
//                                 if (val.isEmpty) {
//                                   return 'error';
//                                 }
//                                 return null;
//                               },
//                               keyboardType: TextInputType.url,
//                               textInputAction: TextInputAction.done,
//                               controller: _imageurlcontroller,
//                               onFieldSubmitted: (_) {
//                                 _save();
//                               },
//                               onSaved: (value) {
//                                 editProduct = Product(
//                                     id: editProduct.id,
//                                     title: editProduct.title,
//                                     description: editProduct.description,
//                                     price: editProduct.price,
//                                     imageUrl: value,
//                                     isfavorite: editProduct.isfavorite);
//                               },
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   )),
//             ),
//     );
//   }
// }
