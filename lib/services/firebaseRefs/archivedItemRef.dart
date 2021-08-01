import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumatron/models/WishlistItem.dart';

final archivedItemsRef = FirebaseFirestore.instance
    .collection('archivedItems')
    .withConverter<WishlistItem>(
      fromFirestore: (snapshot, _) => WishlistItem.fromJson(snapshot.data()!),
      toFirestore: (wishlistItem, _) => wishlistItem.toJson(),
    );
