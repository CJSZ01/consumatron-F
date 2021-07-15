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
    return AlertDialog(
      content: AddWishlistItemForm(),
      backgroundColor: Colors.green,
    );
  }
}
