import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop/Services/navigation_service.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/Project/Product_Provider.dart';
import 'package:my_shop/providers/card_provider.dart';
import 'package:provider/provider.dart';

import '../locator.dart';

class ProductList extends StatelessWidget {
  ProductList(
      {@required this.totalPages,
      @required this.products,
      @required this.callback,
      this.showFavorite: true,
      this.readOnly = false});

  final ScrollController _scrollController = ScrollController();

  final int totalPages;
  final List<Product> products;
  final bool showFavorite;
  final bool readOnly;
  final Function callback;
  void mycallback(double currentPage) {
    callback(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    double pixels = 0.0;
    _scrollController.addListener(() {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            pixels != _scrollController.position.pixels) {
          pixels = _scrollController.position.pixels;
          if (currentPage <= totalPages) {
            currentPage = currentPage + 1;
            this.callback(currentPage);
          }
        }
      });
    });
    return ListView.builder(
        controller: _scrollController,
        itemCount:
            (currentPage < totalPages) ? products.length + 1 : products.length,
        itemBuilder: (context, index) {
          return (index == products.length)
              ? Container(
                  margin: EdgeInsets.all(8),
                  child: Center(child: CircularProgressIndicator()))
              : ProductItem(
                  item: products[index],
                  callback: () => mycallback,
                  showFavorite: showFavorite,
                  readOnly: readOnly,
                );
        });
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key key,
      @required this.item,
      @required this.callback,
      this.showFavorite: true,
      this.readOnly = false})
      : super(key: key);
  final Function callback;
  final Product item;
  final bool showFavorite;
  final readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
            crossAxisAlignment:
                readOnly ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ManageImage(
                      item: item,
                      readOnly: readOnly,
                    ),
                  )),
              Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ManageItem(
                    item: item,
                    readOnly: readOnly,
                  ),
                ),
              ),
              showFavorite
                  ? Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: ChangeNotifierProvider.value(
                        value: item,
                        child: ManageFavorite(
                          callback: this.callback(),
                        ),
                      ))
                  : readOnly
                      ? Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Consumer<Cart>(
                            builder: (ctx, card, chikd) {
                              return Text(
                                card.getQuantity(item.id).toString() + "x",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              );
                            },
                          ))
                      : Center(),
            ]));
  }
}

class ManageImage extends StatelessWidget {
  const ManageImage({Key key, @required this.item, @required this.readOnly})
      : super(key: key);

  final Product item;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      item.image,
      loadingBuilder: (context, child, loadingProgress) {
        return loadingProgress == null
            ? Center(child: child)
            : LinearProgressIndicator();
      },
      errorBuilder: (ctx, _, __) {
        return Image.asset('assets/images/original.png');
      },
      fit: this.readOnly ? BoxFit.fitWidth : BoxFit.fill,
      height: this.readOnly ? 50 : 100,
    );
  }
}

class ManageFavorite extends StatelessWidget {
  const ManageFavorite({@required this.callback});
  final Function callback;
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arg = ModalRoute.of(context).settings.arguments;
    final bool isfavorite = arg != null && arg['isfavorite'] != null
        ? (arg['isfavorite'] as bool)
        : false;
    // final bool isfavorite = false;
    final productprovider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Consumer<Product>(builder: (ctx, product, chikd) {
      return IconButton(
          icon: Icon(
              product.isfavorite
                  ? Icons.favorite
                  : Icons.favorite_border, //  Icons.favorite_border,
              color: Colors.red),
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                      title: Center(
                        child: Icon(Icons.favorite, //  Icons.favorite_border,
                            color: Colors.orange,
                            size: 50),
                      ),
                      content: Container(
                          height: 60,
                          child: Column(children: [
                            Center(
                              child: product.isfavorite
                                  ? Text('Item Started!')
                                  : Text('Item Removed!'),
                            ),
                            Text(
                                'You can find your starred items in the side menu')
                          ])));
                });

            await product.setfavorite();

            if (isfavorite) {
              productprovider.deletproduct(product.id);
            }
            await Future.delayed(Duration(seconds: 2));
            locator<NavigationService>().pop();
            // Navigator.pop(context);
          });
    });
  }
}

class ManageItem extends StatelessWidget {
  const ManageItem({Key key, @required this.item, @required this.readOnly})
      : super(key: key);

  final Product item;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.description,
          style: GoogleFonts.lato(fontSize: 16),
          maxLines: 2,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          item.priceString,
          style: GoogleFonts.lato(
              fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w900),
          maxLines: 2,
        ),
        if (!readOnly)
          SizedBox(
            height: 10,
          ),
        if (!readOnly) ManageAddProductToCart(item: item),
      ],
    );
  }
}

class ManageAddProductToCart extends StatelessWidget {
  const ManageAddProductToCart({Key key, @required this.item})
      : super(key: key);

  final Product item;

  @override
  Widget build(BuildContext context) {
    final Cart cardProvider = Provider.of<Cart>(context, listen: false);
    return Row(children: <Widget>[
      Flexible(
        flex: 3,
        child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Row(children: <Widget>[
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Center(
                      child: IconButton(
                          icon: Icon(Icons.add_outlined,
                              color: Theme.of(context).primaryColor, size: 20),
                          onPressed: () {
                            cardProvider.addItem(item.id, item.description,
                                item.price, item.image, item.priceString);
                          }))),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1, color: Colors.grey),
                            left: BorderSide(width: 1, color: Colors.grey))),
                    child: Center(child: Consumer<Cart>(
                      builder: (ctx, card, chikd) {
                        return Text(
                          card.getQuantity(item.id).toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900),
                        );
                      },
                    )),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Center(
                      child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          onPressed: () {
                            cardProvider.removeItem(item.id);
                          }))),
            ])),
      ),
      Flexible(flex: 1, child: SizedBox()),
    ]);
  }
}
