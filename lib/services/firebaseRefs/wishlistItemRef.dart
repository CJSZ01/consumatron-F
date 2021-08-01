import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumatron/models/WishlistItem.dart';

final wishlistItemsRef = FirebaseFirestore.instance
    .collection('wishlistItems')
    .withConverter<WishlistItem>(
      fromFirestore: (snapshot, _) => WishlistItem.fromJson(snapshot.data()!),
      toFirestore: (wishlistItem, _) => wishlistItem.toJson(),
    );
