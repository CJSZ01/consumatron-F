import 'package:consumatron/models/WishlistItem.dart';
import 'package:consumatron/services/firebaseRefs/archivedItemRef.dart';
import 'package:consumatron/services/firebaseRefs/wishlistItemRef.dart';
import 'package:flutter/material.dart';

class UpdateArchivedItemDialog extends StatefulWidget {
  final documentId;
  const UpdateArchivedItemDialog({Key? key, required this.documentId})
      : super(key: key);

  @override
  _UpdateArchivedItemDialogState createState() =>
      _UpdateArchivedItemDialogState();
}

class _UpdateArchivedItemDialogState extends State<UpdateArchivedItemDialog> {
  WishlistItem? archivedItem;
  @override
  void initState() {
    getArchivedItem().then((value) => archivedItem = value);
    super.initState();
  }

  Future<WishlistItem?> getArchivedItem() async {
    await archivedItemsRef.doc(widget.documentId).get().then((value) {
      archivedItem = value.data();
      return value.data();
    });
  }

  Future<void> removeArchivedItem() {
    return archivedItemsRef
        .doc(widget.documentId)
        .delete()
        .then((value) => print("Archived item removed"))
        .catchError((error) => print("Failed to remove archived item: $error"));
  }

  restoreArchivedItem() async {
    await wishlistItemsRef.add(archivedItem!);

    await removeArchivedItem().whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArchivedItem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(archivedItem!.name);
            return AlertDialog(
              title: Text(widget.documentId),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        restoreArchivedItem();
                      },
                      child: Text('Restore')),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        await removeArchivedItem()
                            .whenComplete(() => Navigator.pop(context));
                      },
                      child: Text('Permanently Delete')),
                  Spacer(),
                ],
              ),
              backgroundColor: Colors.green,
            );
          } else if (snapshot.hasError) {
            return Text('Error retrieving archived item.');
          } else {
            return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              content: LinearProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        });
  }
}
