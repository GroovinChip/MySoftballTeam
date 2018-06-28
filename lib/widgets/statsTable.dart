import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:my_softball_team/globals.dart' as globals;

class StatsTable extends StatefulWidget {
  @override
  _StatsTableState createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {

  //CollectionReference teamStats = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Stats");
  CollectionReference root = Firestore.instance.collection("Teams");
  CollectionReference players = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Players");
  CollectionReference stats = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Stats");

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<List<QuerySnapshot>>(
      stream: new StreamZip([players.snapshots(), stats.snapshots()]),
      builder: (context, snapshot){
        List<DataColumn> columns = [
          new DataColumn(label: new Text("Players")),
        ];
        List<DataRow> rows = [];
        List<DataCell> cells = [];
        List<LocalKey> rowKeys = [];

        if(snapshot.hasData) {
          final players_stream = snapshot.data[0];
          final stats_stream = snapshot.data[1];

          List<DocumentSnapshot> playersInStream = players_stream.documents;
          List<DocumentSnapshot> statsInStream = stats_stream.documents;

          // Create the columns
          for(int statsIndex = 0; statsIndex < statsInStream.length; statsIndex++) {
            columns.add(new DataColumn(label: new Text(statsInStream[statsIndex].documentID)));
            //cells.add(new DataCell(new Text("Test")));
            //cells.add(new DataCell(new Text("Placeholder")));
            //rows.add(new DataRow(cells: cells));
          }

          // Load the players and their data
          for(int playerIndex = 0; playerIndex < playersInStream.length; playerIndex++) {
            rows.add(
              new DataRow(
                cells: [
                  new DataCell(
                    new Text(playersInStream[playerIndex].documentID), 
                    onTap: (){}
                  ),
                  new DataCell(
                    new Text(playersInStream[playerIndex]["Assists"]),
                    onTap: (){}
                  ),
                  new DataCell(
                    new Text(playersInStream[playerIndex]["AtBats"]),
                    onTap: (){}
                  ),
                  new DataCell(
                      new Text(playersInStream[playerIndex]["BaseHits"]),
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
                ]
              )
            );
          }

          return ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SingleChildScrollView(
                child: new Container(
                    child: new DataTable(
                      columns: columns,
                      rows: rows,
                    )
                ),
              ),
            ],
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
