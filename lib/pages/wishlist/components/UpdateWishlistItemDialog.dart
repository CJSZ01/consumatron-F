import 'package:flutter/material.dart';

import 'UpdateWishlistItemForm.dart';

class UpdateWishlistItemDialog extends StatefulWidget {
  final String documentId;
  const UpdateWishlistItemDialog({Key? key, required this.documentId})
      : super(key: key);

  @override
  _UpdateWishlistItemDialogState createState() =>
      _UpdateWishlistItemDialogState();
}

class _UpdateWishlistItemDialogState extends State<UpdateWishlistItemDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.documentId);

    return AlertDialog(
      title: Text(widget.documentId),
      content: UpdateWishlistItemForm(documentId: widget.documentId),
      backgroundColor: Colors.green,
    );
  }
}
