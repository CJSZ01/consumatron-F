import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UpdateWishlistItemDialog.dart';

class WishlistTable extends StatefulWidget {
  const WishlistTable({Key? key}) : super(key: key);

  @override
  _WishlistTableState createState() => _WishlistTableState();
}

class _WishlistTableState extends State<WishlistTable> {
  final Stream<QuerySnapshot> _wishlistItemsStream = FirebaseFirestore.instance
      .collection('wishlistItems')
      .orderBy('name', descending: false)
      .snapshots();

  Future<void> _showUpdateWishlistItemAlertDialog(String documentId) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateWishlistItemDialog(
            documentId: documentId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _wishlistItemsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return DataTable(
          showCheckboxColumn: false,
          dataRowColor: MaterialStateProperty.all(Colors.black54),
          dataTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.primary),
          columns: [
            DataColumn(
              onSort: (columnIndex, ascending) {
                setState(() {});
              },
              label: Text(
                'name',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            DataColumn(
              numeric: true,
              label: Text(
                'cost',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            DataColumn(
              numeric: true,
              label: Text(
                'priority',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            DataColumn(
              numeric: true,
              label: Text(
                'date added',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
          rows: snapshot.data!.docs.map((DocumentSnapshot documents) {
            Map<String, dynamic> data =
                documents.data() as Map<String, dynamic>;
            var creationDate = data['date'].toDate();
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    data['name'],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataCell(
                  Text(
                    data['cost'],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataCell(
                  Text(
                    data['priority'],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataCell(
                  Text(
                    creationDate.toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
              onSelectChanged: (value) {
                if (value!) {
                  //Why does this work???

                  _showUpdateWishlistItemAlertDialog(documents.id);
                }
              },
            );
          }).toList(),
        );
      },
    );
  }
}
