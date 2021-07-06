import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistItem {
  String cost;
  String name;
  String priority;
  Timestamp date;

  WishlistItem(
      {required this.cost,
      required this.name,
      required this.priority,
      required this.date});

  WishlistItem.fromSnapshot(Map<String, dynamic> snapshot)
      : cost = snapshot['cost'],
        priority = snapshot['priority'],
        date = snapshot['date'],
        name = snapshot['name'];

  Map<String, Object?> toJson() {
    return {
      'cost': cost,
      'priority': priority,
      'name': name,
      'date': date,
    };
  }

  WishlistItem.fromJson(Map<String, Object?> json)
      : this(
          cost: json['cost']! as String,
          name: json['name']! as String,
          priority: json['priority']! as String,
          date: json['date']! as Timestamp,
        );

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
