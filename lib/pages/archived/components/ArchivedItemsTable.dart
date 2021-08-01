import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'UpdateArchivedItemDialog.dart';

class ArchivedItemsTable extends StatefulWidget {
  const ArchivedItemsTable({Key? key}) : super(key: key);

  @override
  _ArchivedItemsTableState createState() => _ArchivedItemsTableState();
}

class _ArchivedItemsTableState extends State<ArchivedItemsTable> {
  String order = 'name';
  bool descending = false;

  Future<void> _showUpdateArchivedItemAlertDialog(String documentId) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateArchivedItemDialog(
            documentId: documentId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _archivedItemsStream = FirebaseFirestore
        .instance
        .collection('archivedItems')
        .orderBy(order, descending: descending)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _archivedItemsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              showCheckboxColumn: false,
              dataRowColor: MaterialStateProperty.all(Colors.black54),
              dataTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              columns: [
                DataColumn(
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      order = 'name';
                      descending = !descending;
                    });
                  },
                  label: Text(
                    'name',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      order = 'cost';
                      descending = !descending;
                    });
                  },
                  numeric: true,
                  label: Text(
                    'cost',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      order = 'priority';
                      descending = !descending;
                    });
                  },
                  numeric: true,
                  label: Text(
                    'priority',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      order = 'date';
                      descending = !descending;
                    });
                  },
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

                      _showUpdateArchivedItemAlertDialog(documents.id);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
