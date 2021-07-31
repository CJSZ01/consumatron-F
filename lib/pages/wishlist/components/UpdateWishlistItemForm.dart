import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumatron/models/WishlistItem.dart';
import 'package:flutter/material.dart';

class UpdateWishlistItemForm extends StatefulWidget {
  const UpdateWishlistItemForm({Key? key, required this.documentId})
      : super(key: key);
  final String documentId;

  @override
  _UpdateWishlistItemFormState createState() => _UpdateWishlistItemFormState();
}

class _UpdateWishlistItemFormState extends State<UpdateWishlistItemForm> {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  WishlistItem newWishlistItem = WishlistItem(
      cost: '',
      name: '',
      priority: '',
      date: Timestamp.now(),
      isArchived: false);

  final wishlistItemsRef = FirebaseFirestore.instance
      .collection('wishlistItems')
      .withConverter<WishlistItem>(
        fromFirestore: (snapshot, _) => WishlistItem.fromJson(snapshot.data()!),
        toFirestore: (wishlistItem, _) => wishlistItem.toJson(),
      );

  Future<void> updateWishlistItem() {
    Navigator.pop(context);
    return wishlistItemsRef
        .doc(widget.documentId)
        .update(newWishlistItem.toJson())
        .then((value) => print("Wishlist item updated"))
        .catchError((error) => print("Failed to update wishlist item: $error"));
  }

  Future<void> removeWishlistItem() {
    Navigator.pop(context);
    return wishlistItemsRef
        .doc(widget.documentId)
        .delete()
        .then((value) => print("Wishlist item removed"))
        .catchError((error) => print("Failed to remove wishlist item: $error"));
  }

  Future<void> getWishlistItem() async {
    await wishlistItemsRef
        .doc(widget.documentId)
        .get()
        .then((snapshot) => newWishlistItem = snapshot.data()!);
  }

  void archive() {}

  @override
  void initState() {
    getWishlistItem();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWishlistItem(),
      builder: (context, snapshot) {
        print(newWishlistItem.name);
        return Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: newWishlistItem.name),
                  ),
                  maxLength: 128,
                  // decoration: InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert item name.';
                    }
                    return null;
                  },
                  onChanged: (value) => newWishlistItem.name = value,
                ),
                TextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: newWishlistItem.priority),
                  ),
                  maxLength: 2,
                  decoration: InputDecoration(hintText: 'Priority'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert item priority.';
                    } else if (!numericRegex.hasMatch(value)) {
                      return 'Insert only numbers';
                    }
                    return null;
                  },
                  onChanged: (value) => newWishlistItem.priority = value,
                ),
                TextFormField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(text: newWishlistItem.cost),
                  ),
                  maxLength: 8,
                  decoration: InputDecoration(hintText: 'Cost'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert item cost.';
                    } else if (!numericRegex.hasMatch(value)) {
                      return 'Insert only numbers';
                    }
                    return null;
                  },
                  onChanged: (value) => newWishlistItem.cost = value,
                ),
                Padding(padding: EdgeInsets.all(16)),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            updateWishlistItem();
                          }
                        },
                        child: Text('Submit')),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          archive();
                        },
                        child: Text('Archive')),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          removeWishlistItem();
                        },
                        child: Text('Remove')),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
