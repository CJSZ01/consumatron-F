import 'package:consumatron/pages/wishlist/components/AddWishlistItemDialog.dart';
import 'package:consumatron/pages/wishlist/components/WishlistTable.dart';
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
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          Padding(padding: EdgeInsets.only(left: 32)),
          TextButton(
              onPressed: () {
                _showAddWishlistItemAlertDialog();
              },
              child: Text(
                'New Wishlit Item',
                style: Theme.of(context).textTheme.bodyText2,
              )),
          Padding(padding: EdgeInsets.all(16)),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'archivedItemsPage');
              },
              child: Text(
                'Archived Items',
                style: Theme.of(context).textTheme.bodyText2,
              )),
          Spacer(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Container(child: WishlistTable()),
          ],
        ),
      ),
    );
  }
}
