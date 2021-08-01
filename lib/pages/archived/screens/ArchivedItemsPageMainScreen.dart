import 'package:consumatron/pages/archived/components/ArchivedItemsTable.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArchivedItemsPageStartScreen extends StatefulWidget {
  const ArchivedItemsPageStartScreen({Key? key}) : super(key: key);

  @override
  _ArchivedItemsPageStartScreenState createState() =>
      _ArchivedItemsPageStartScreenState();
}

class _ArchivedItemsPageStartScreenState
    extends State<ArchivedItemsPageStartScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          Padding(padding: EdgeInsets.only(left: 32)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Container(child: ArchivedItemsTable()),
          ],
        ),
      ),
    );
  }
}
