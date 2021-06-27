import 'package:flutter/material.dart';
import 'package:my_shop/providers/Project/Product_Provider.dart';
import 'package:my_shop/providers/card_provider.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/widets/badge.dart';
import 'package:my_shop/widets/productList.dart';
import 'package:provider/provider.dart';
import '../widets/app_drawer.dart';

class SearchProductsScreen extends StatefulWidget {
  static const routName = './SearchProducts';

  @override
  _SearchProductsScreenState createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productprovider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text("Search Product"), actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(productprovider));
              }),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
            ),
          )
        ]),
        body: Center());
  }
}

class DataSearch extends SearchDelegate<String> {
  ProductsProvider productprovider;
  final list = ["dfdf", "qwe", "qweweq", "cccc"];
  DataSearch(this.productprovider)
      : super(
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(

          // filled: true,
          // fillColor: Colors.white,
          prefixStyle: TextStyle(backgroundColor: Colors.white)

          // hintStyle: theme.textTheme.headline5.copyWith(
          //   color: Colors.white,
          //   //  fontWeight: FontWeight.w100,
          // ),
          ),
      //     textTheme: theme.textTheme.copyWith(

      // headline6:
      //     theme.textTheme.headline5.copyWith(color: Colors.white)));
    );
  }
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   @override
  //   final ThemeData theme = Theme.of(context);
  //   return theme.copyWith(
  //     inputDecorationTheme: theme.inputDecorationTheme.copyWith(
  //         filled: true,
  //         fillColor: Colors.red,
  //         hintStyle: theme.textTheme.headline5.copyWith(
  //           color: Colors.white70,
  //           //  fontWeight: FontWeight.w100,
  //         ),
  //         counterStyle: theme.textTheme.headline5.copyWith(
  //           color: Colors.white70,
  //           //  fontWeight: FontWeight.w100,
  //         )),
  //     primaryColor: theme.primaryColor,
  //     primaryIconTheme: theme.primaryIconTheme,
  //     primaryColorBrightness: theme.primaryColorBrightness,
  //     primaryTextTheme: theme.primaryTextTheme,
  //     textTheme: theme.textTheme.copyWith(
  //         headline5: theme.textTheme.headline5.copyWith(color: Colors.white)),
  //   );
  // }

  @override
  void close(BuildContext context, String result) {
    print(result);
    super.close(context, result);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? SizedBox()
          : IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = "";
              })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty)
      close(context, null);
    else {
      // Navigator.of(context)
      //     .popAndPushNamed(ProductScreen.routName, arguments: {'id': 45});
      // locator<NavigationService>().navigateTopopAndPushNamed(
      //     ProductScreen.routName,
      //     arguments: {'id': 45});
    }
    //close(context, null);
    int totalPages = 0;

    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
                  child: FutureBuilder(
                      future: productprovider.getProducts(description: query),
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
                          return Consumer<ProductsProvider>(
                              builder: (ctx, product, chikd) {
                            totalPages = product.totalPages;
                            return ProductList(
                                totalPages: totalPages,
                                products: product.products,
                                callback: (currentPage) {
                                  productprovider.getProducts(
                                      pageNumber: currentPage,
                                      description: query);
                                });
                          });
                        }
                      })))
        ]));
  }

  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return new AppBar();

  //   // return super.buildBottom(context);
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mylist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return Column(children: [
      SizedBox(child: Text('Search History')),
      Expanded(
        //height: 60,
        child: ListView.builder(
          itemBuilder: (ctx, index) => Column(children: [
            ListTile(
              leading: Icon(Icons.search),
              title: Text(mylist[index]),
              onTap: () {
                query = mylist[index];
                showResults(context);
              },
            ),
            Divider()
          ]),
          itemCount: mylist.length,
        ),
      ),
    ]);
  }
}
