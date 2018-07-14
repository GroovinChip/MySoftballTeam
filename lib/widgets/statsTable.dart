import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:my_softball_team/globals.dart' as globals;

class StatsTable extends StatefulWidget {
  @override
  _StatsTableState createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {

  CollectionReference root = Firestore.instance.collection("Teams");
  CollectionReference players = Firestore.instance.collection("Teams").document(globals.teamName).collection("Players");
  CollectionReference stats = Firestore.instance.collection("Teams").document(globals.teamName).collection("Stats");
  bool sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<List<QuerySnapshot>>(
      stream: new StreamZip([players.snapshots(), stats.snapshots()]),
      builder: (context, snapshot){
        List<DataColumn> columns = [
          new DataColumn(
            label: new Text("Players"),
            onSort: (int columnIndex, bool ascending){
              print("Column " + columnIndex.toString() + " tapped");
            }
          ),
        ];
        List<DataRow> rows = [];
        List<DataCell> cells = [];

        if(snapshot.hasData) {
          final players_stream = snapshot.data[0];
          final stats_stream = snapshot.data[1];

          List<DocumentSnapshot> playersInStream = players_stream.documents;
          List<DocumentSnapshot> statsInStream = stats_stream.documents;

          // Create the columns
          for(int statsIndex = 0; statsIndex < statsInStream.length; statsIndex++) {
            columns.add(new DataColumn(
              label: new Text(statsInStream[statsIndex].documentID),
              onSort: (int columnIndex, bool sortDirection){
                print(sortDirection);
                sortAscending = sortDirection;
                print("Column " + columnIndex.toString() + " tapped");
              },
              ),
            );
          }

          // Load the players and their data as rows
          for(int playerIndex = 0; playerIndex < playersInStream.length; playerIndex++) {
            rows.add(
              new DataRow(
                cells: [
                  new DataCell(
                    new Text(playersInStream[playerIndex].documentID), 
                    onTap: (){}
                  ),
                  new DataCell(
                    new Text(playersInStream[playerIndex]["AtBats"]),
                    onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["Singles"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["Doubles"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["Triples"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["HomeRuns"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["RunsBattedIn"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["Walks"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["Strikeouts"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["GamesPlayed"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["OutsFielded"]),
                      onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["OutsReceived"]),
                      onTap: (){}
                  ),
                ],
              )
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SingleChildScrollView(
                    child: new Container(
                        child: new DataTable(
                          columns: columns,
                          rows: rows,
                          sortAscending: sortAscending,
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
