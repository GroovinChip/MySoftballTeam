import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/editGameModal.dart';

class SeasonSchedule extends StatefulWidget {
  @override
  _SeasonScheduleState createState() => _SeasonScheduleState();
}

class _SeasonScheduleState extends State<SeasonSchedule> {

  CollectionReference gamesDB = Firestore.instance.collection("Teams").document(globals.teamName).collection("Seasons").document(DateTime.now().year.toString()).collection("Games");

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
          DataColumn(label: Text("Actions")),
        ];
        List<DataRow> rows = [];

        if(snapshot.hasData == true) {

          List<DocumentSnapshot> games = snapshot.data.documents;

          games.sort((a, b){
            DateTime game1 = globals.convertStringDateToDateTime(a['GameDate'], a['GameTime']);
            DateTime game2 = globals.convertStringDateToDateTime(b['GameDate'], b['GameTime']);
            return game1.compareTo(game2);
          });

          for(int index = 0; index < games.length; index++) {
            // Check each game date - if the date is in the past, do not display it
            DateTime gameDate = globals.convertStringDateToDateTime("${games[index]['GameDate']}", "${games[index]['GameTime']}");
            DateTime today = new DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              0
            );
            //print(dateToEval);
            if(gameDate.isBefore(today) == true){
              // do not create a Game row
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
                DataCell(
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: new Icon(Icons.edit),
                          onPressed: (){
                            globals.selectedGameDocument = games[index].documentID;
                            Navigator.of(context).push(new MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return new EditGameModal();
                                },
                                fullscreenDialog: true
                            ));
                          },
                          tooltip: "Edit Game Details",
                        ),
                        IconButton(
                          icon: new Icon(Icons.delete),
                          onPressed: (){
                            globals.selectedGameDocument = games[index].documentID;
                            showDialog(
                                context: context,
                                builder: (_) => SimpleDialog(
                                  title: Text("Delete Game"),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ListTile(
                                        title: Text("Are you sure you want to remove this game from the schedule?"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text("Yes"),
                                            onPressed: (){
                                              gamesDB.document(globals.selectedGameDocument).delete();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("No"),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            );
                          },
                          tooltip: "Delete Game",
                        ),
                      ],
                    ),
                  ),
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

        } else {
          return Center(child: Text("No Games in the Schedule"));
        }
      },
    );
  }
}
