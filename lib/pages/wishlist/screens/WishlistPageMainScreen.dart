import 'package:consumatron/pages/wishlist/screens/components/AddWishlistItemDialog.dart';
import 'package:consumatron/pages/wishlist/screens/components/WishlistTable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistPageStartScreen extends StatefulWidget {
  const WishlistPageStartScreen({Key? key}) : super(key: key);

  @override
  _WishlistPageStartScreenState createState() =>
      _WishlistPageStartScreenState();
}

class _WishlistPageStartScreenState extends State<WishlistPageStartScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _showAddWishlistItemAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddWishlistItemDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black87,
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {
                    _showAddWishlistItemAlertDialog();
                  },
                  child: Text(
                    'New Wishlit Item',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
            ),
            Container(child: WishlistTable()),
          ],
        ),
      ),
    );
  }
}
