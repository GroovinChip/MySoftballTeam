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
    return StreamBuilder<List<QuerySnapshot>>(
      stream: StreamZip([players.snapshots(), stats.snapshots()]),
      builder: (context, snapshot){
        List<DataColumn> columns = [
          DataColumn(
            label: Text("Players"),
            onSort: (int columnIndex, bool ascending){
              print("Column " + columnIndex.toString() + " tapped");
            }
          ),
        ];
        List<DataRow> rows = [];

        if(snapshot.hasData) {
          final players_stream = snapshot.data[0];
          final stats_stream = snapshot.data[1];

          List<DocumentSnapshot> playersInStream = players_stream.documents;
          List<DocumentSnapshot> statsInStream = stats_stream.documents;

          // Create the columns
          for(int statsIndex = 0; statsIndex < statsInStream.length; statsIndex++) {
            columns.add(DataColumn(
              label: Text(statsInStream[statsIndex].documentID),
              onSort: (int columnIndex, bool sortDirection){
                print(sortDirection);
                sortAscending = sortDirection;
              },
              ),
            );
          }

          // Load the players and their data as rows
          for(int playerIndex = 0; playerIndex < playersInStream.length; playerIndex++) {
            rows.add(
              DataRow(
                cells: [
                  DataCell(
                    Text(playersInStream[playerIndex].documentID), 
                    onTap: (){}
                  ),
                  DataCell(
                    Text(playersInStream[playerIndex]["AtBats"]),
                    onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["Doubles"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["GamesPlayed"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["HomeRuns"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["OutsFielded"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["OutsReceived"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["RunsBattedIn"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["Singles"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["Strikeouts"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["Triples"]),
                      onTap: (){}
                  ),
                  DataCell(
                      Text(playersInStream[playerIndex]["Walks"]),
                      onTap: (){}
                  ),
                ],
              )
            );
          }

          return ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                    child: DataTable(
                      columns: columns,
                      rows: rows,
                      sortAscending: sortAscending,
                    )
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
