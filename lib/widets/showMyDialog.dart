import 'package:flutter/material.dart';
import 'package:my_shop/Services/navigation_service.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';
import '../locator.dart';

class ShowMyDialogs {
  void showMyDialog(BuildContext context, String title,
      List<KeyValueItem> values, int selectedId, Function onTap(int)) {
    if (values.isEmpty || values.length == 1) return;
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: Column(children: [
              // Center(
              //   child: Text(title),
              // ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
                child: Row(children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  Material(
                    child: IconButton(
                        icon: Icon(Icons.close_sharp),
                        onPressed: () => locator<NavigationService>().pop()),
                  )
                ]),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  //  separatorBuilder: (_, __) => const Divider(),
                  itemCount: values.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Material(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.grey),
                        )),
                        child: InkWell(
                          onTap: () {
                            onTap(values[index].key);
                            locator<NavigationService>().pop();
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                values[index].value,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: values[index].key == selectedId
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]), //SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
