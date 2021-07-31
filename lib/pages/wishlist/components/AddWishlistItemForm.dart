import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumatron/models/WishlistItem.dart';
import 'package:flutter/material.dart';

class AddWishlistItemForm extends StatefulWidget {
  const AddWishlistItemForm({Key? key}) : super(key: key);

  @override
  _AddWishlistItemFormState createState() => _AddWishlistItemFormState();
}

class _AddWishlistItemFormState extends State<AddWishlistItemForm> {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  final wishlistItemsRef = FirebaseFirestore.instance
      .collection('wishlistItems')
      .withConverter<WishlistItem>(
        fromFirestore: (snapshot, _) => WishlistItem.fromJson(snapshot.data()!),
        toFirestore: (wishlistItem, _) => wishlistItem.toJson(),
      );

  WishlistItem newWishlistItem = new WishlistItem(
      cost: '',
      name: '',
      priority: '',
      date: Timestamp.now(),
      isArchived: false);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            maxLength: 128,
            decoration: InputDecoration(hintText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insert item name.';
              }
              return null;
            },
            onChanged: (value) => newWishlistItem.name = value,
          ),
          TextFormField(
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
                      await wishlistItemsRef.add(newWishlistItem);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit')),
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
    );
  }
}
