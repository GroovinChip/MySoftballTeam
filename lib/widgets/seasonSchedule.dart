import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;

class SeasonSchedule extends StatefulWidget {
  @override
  _SeasonScheduleState createState() => _SeasonScheduleState();
}

class _SeasonScheduleState extends State<SeasonSchedule> {

  CollectionReference gamesDB = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Seasons").document(DateTime.now().year.toString()).collection("Games");

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: gamesDB.snapshots(),
      builder: (context, snapshot) {
        List<DataColumn> columns = [
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Time")),
          DataColumn(label: Text("Location")),
          DataColumn(label: Text("Opposing Team")),
          DataColumn(label: Text("Home or Away")),
        ];
        List<DataRow> rows = [];

        if(snapshot.hasData == true) {

          if(snapshot.data.documents.length == 0){
            return Center(
              child: RaisedButton(
                child: new Text("Get Games"),
                onPressed: (){
                  setState(() {

                  });
                },
              ),
            );
          }

          List<DocumentSnapshot> games = snapshot.data.documents;

          for(int index = 0; index < games.length; index++) {
            //DocumentSnapshot game = game[index];
            rows.add(DataRow(cells: [
              DataCell(
                Text("${games[index]['GameDate']}"),
                onTap: (){

                }
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
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
