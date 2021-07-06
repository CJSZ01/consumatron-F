import 'package:consumatron/pages/wishlist/screens/components/AddWishlistItemForm.dart';
import 'package:flutter/material.dart';

class AddWishlistItemDialog extends StatefulWidget {
  const AddWishlistItemDialog({Key? key}) : super(key: key);

  @override
  _AddWishlistItemDialogState createState() => _AddWishlistItemDialogState();
}

class _AddWishlistItemDialogState extends State<AddWishlistItemDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 512, vertical: 300),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(color: Colors.black, width: 8)),
          child: AddWishlistItemForm(),
        ),
      ),
    );
  }
}
