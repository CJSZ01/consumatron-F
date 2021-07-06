// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:consumatron/models/WishlistItem.dart';

// class WishlistItemDAO {
//   CollectionReference wishlistItemsCollection =
//       FirebaseFirestore.instance.collection('wishlistItems');

//   Future<WishlistItem> getWishlistItemById() async {
//     String id = 'O0I0sr8aJXpDBzAYpmMF';

//     DocumentSnapshot snapshot = await wishlistItemsCollection.doc(id).get();
//     if (snapshot.exists)
//       WishlistItem wishlistItem = WishlistItem.fromSnapshot(snapshot.data());
//   }
// }
