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

          for(int index = 0; index < games.length; index++) {
            // Check each game date - if the date is in the past, do not display it
            String date = "${games[index]['GameDate']}";
            List<String> temp = date.split(' ');
            DateTime dateToEval;
            String year = temp[2];
            String month;
            String day;
            switch(temp[0]){
              case "January":
                month = "01";
                break;
              case "February":
                month = "02";
                break;
              case "March":
                month = "03";
                break;
              case "April":
                month = "04";
                break;
              case "May":
                month = "05";
                break;
              case "June":
                month = "06";
                break;
              case "July":
                month = "07";
                break;
              case "August":
                month = "08";
                break;
              case "September":
                month = "09";
                break;
              case "October":
                month = "10";
                break;
              case "November":
                month = "11";
                break;
              case "December":
                month = "12";
                break;
            }

            switch(temp[1]){
              case "1,":
                day = "01";
                break;
              case "2,":
                day = "02";
                break;
              case "3,":
                day = "03";
                break;
              case "4,":
                day = "04";
                break;
              case "5,":
                day = "05";
                break;
              case "6,":
                day = "06";
                break;
              case "7,":
                day = "07";
                break;
              case "8,":
                day = "08";
                break;
              case "9,":
                day = "09";
                break;
              case "10,":
                day = "10";
                break;
              case "11,":
                day = "11";
                break;
              case "12,":
                day = "12";
                break;
              case "13,":
                day = "13";
                break;
              case "14,":
                day = "14";
                break;
              case "15,":
                day = "15";
                break;
              case "16,":
                day = "16";
                break;
              case "17,":
                day = "17";
                break;
              case "18,":
                day = "18";
                break;
              case "19,":
                day = "19";
                break;
              case "20,":
                day = "20";
                break;
              case "21,":
                day = "21";
                break;
              case "22,":
                day = "22";
                break;
              case "23,":
                day = "23";
                break;
              case "24,":
                day = "24";
                break;
              case "25,":
                day = "25";
                break;
              case "26,":
                day = "26";
                break;
              case "27,":
                day = "27";
                break;
              case "28,":
                day = "28";
                break;
              case "29,":
                day = "29";
                break;
              case "30,":
                day = "30";
                break;
              case "31,":
                day = "31";
                break;
            }

            String toParseAsDate = year + month + day;
            dateToEval = DateTime.parse(toParseAsDate);
            DateTime today = new DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              0
            );
            //print(dateToEval);
            if(dateToEval.isBefore(today) == true){
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
