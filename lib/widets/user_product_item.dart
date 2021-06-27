import 'package:flutter/material.dart';

class UserProductItem extends StatefulWidget {
  final id;
  final String title;
  final String imageUrl;
  final int value;
  UserProductItem(this.id, this.title, this.imageUrl, {this.value = 0});

  @override
  _UserRoductItemState createState() => _UserRoductItemState();
}

class _UserRoductItemState extends State<UserProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      trailing: Container(
        width: 200,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add_box,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    //         widget.value = widget.value + 1;
                  });

                  // Navigator.of(context).pushNamed(EditProductScreen.routName,
                  //     arguments: widget.id);
                }),
            Container(
              child: Text(
                '${widget.value}',
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.indeterminate_check_box,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    //  widget.value = widget.value - 1;
                  });

                  // Provider.of<Products>(context, listen: false)
                  //     .deletproduct(widget.id);
                }),
          ],
        ),
      ),
    );
  }
}
