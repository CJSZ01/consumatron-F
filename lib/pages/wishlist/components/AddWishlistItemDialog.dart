import 'package:flutter/material.dart';

import 'AddWishlistItemForm.dart';

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
