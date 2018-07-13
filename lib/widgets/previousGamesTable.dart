import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;

class PreviousGamesTable extends StatefulWidget {
  @override
  _PreviousGamesTableState createState() => _PreviousGamesTableState();
}

class _PreviousGamesTableState extends State<PreviousGamesTable> {

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Games"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: globals.gamesDB.snapshots(),
        builder: (context, snapshot){
          List<DataColumn> columns = [
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Time")),
            DataColumn(label: Text("Location")),
            DataColumn(label: Text("Opposing Team")),
            DataColumn(label: Text("Home or Away")),
            //DataColumn(label: Text("Actions")),
          ];
          List<DataRow> rows = [];

          if(snapshot.hasData == false) {
            return Center(child: Text("No Games Found"));
          } else {
            List<DocumentSnapshot> games = snapshot.data.documents;

            games.sort((a, b){
              DateTime game1 = globals.convertStringDateToDateTime(a['GameDate'], a['GameTime']);
              DateTime game2 = globals.convertStringDateToDateTime(b['GameDate'], b['GameTime']);
              return game1.compareTo(game2);
            });

            for(int index = 0; index < games.length; index++){
              // Check each game date - if the date is before today, create a row
              DateTime gameDate = globals.convertStringDateToDateTime("${games[index]['GameDate']}", "${games[index]['GameTime']}");
              if(gameDate.isBefore(today) == false) {
                // Do no create row
              } else {
                rows.add(DataRow(cells: [
                  DataCell(
                      Text("${games[index]['GameDate']}")
                  ),
                  DataCell(
                      Text("${games[index]['GameTime']}")
                  ),
                  DataCell(
                      Text("${games[index]['GameLocation']}")
                  ),
                  DataCell(
                      Text("${games[index]['OpposingTeam']}")
                  ),
                  DataCell(
                      Text("${games[index]['HomeOrAway']}")
                  ),
                ]));
              }
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
          }
        },
      ),
    );
  }
}
