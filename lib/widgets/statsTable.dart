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

  List<DataColumn> columns = [
    new DataColumn(label: new Text("Players")),
  ];
  List<DataRow> rows = [];
  List<DataCell> cells = [];

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<List<QuerySnapshot>>(
      stream: new StreamZip([players.snapshots(), stats.snapshots()]),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          final players_stream = snapshot.data[0];
          final stats_stream = snapshot.data[1];

          List<DocumentSnapshot> playersInStream = players_stream.documents;
          List<DocumentSnapshot> statsInStream = stats_stream.documents;

          for(int playerIndex = 0; playerIndex < playersInStream.length; playerIndex++) {
            //rows.add(new DataRow(cells: [new DataCell(new Text(playersInStream[playerIndex].documentID), onTap: (){})]));
          }

          for(int statsIndex = 0; statsIndex < statsInStream.length; statsIndex++) {
            columns.add(new DataColumn(label: new Text(statsInStream[statsIndex].documentID)));
            //cells.add(new DataCell(new Text("Placeholder")));
            //rows.add(new DataRow(cells: cells));
          }

          print("Cells: " + cells.length.toString());
          print("Rows" + rows.length.toString());
          print("Columns: " + columns.length.toString());

          /*List<DocumentSnapshot> teamPlayers = snapshot.data.documents;
          // Iterate through the players to set the first cell of every row as the player name
          for(int index = 0; index < teamPlayers.length; index++){
            for(int row = 0; row < rows.length; row++){
              if(teamPlayers[index].documentID == rows[row].toString()) {

              } else {
                rows.add(new DataRow(cells: [new DataCell(new Text(teamPlayers[index].documentID), onTap: (){})]));
              }
            }

          }*/

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
