import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EditGameModal extends StatefulWidget {
  @override
  _EditGameModalState createState() => _EditGameModalState();
}

class _EditGameModalState extends State<EditGameModal> {

  List<DropdownMenuItem> _homeOrAwayOptions = [
    DropdownMenuItem(child: Text("Home"), value: "Home"),
    DropdownMenuItem(child: Text("Away"), value: "Away"),
    DropdownMenuItem(child: Text("Bye"), value: "Bye")
  ];

  List<DropdownMenuItem> _winOrLossOptions = [
    DropdownMenuItem(child: Text("Win"), value: "Win"),
    DropdownMenuItem(child: Text("Loss"), value: "Loss")
  ];

  TextEditingController _editGameDateController = new TextEditingController();
  TextEditingController _editGameTimeController = new TextEditingController();
  TextEditingController _editGameLocationController = new TextEditingController();
  TextEditingController _editOpposingTeamController = new TextEditingController();
  String year;
  String month;
  DateTime gameDate;
  TimeOfDay gameTime;
  String _homeOrAway;
  String winOrLoss;

  void _chooseHomeOrAway(value) {
    setState(() {
      _homeOrAway = value;
    });
  }

  void _recordWinOrLoss(value) {
    setState(() {
      winOrLoss = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Game"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: globals.gamesDB.snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData == true){
            List<DocumentSnapshot> games = snapshot.data.documents;
            for(int index = 0; index < games.length; index++) {
              if(games[index].documentID == globals.selectedGameDocument){
                DocumentSnapshot game = games[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Edit Game Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new SizedBox(
                                        width: 185.0,
                                        child: new TextField(
                                          controller: _editGameDateController,
                                          enabled: false,
                                          decoration: new InputDecoration(
                                            labelText: "${game['GameDate']}",
                                            filled: true,
                                            fillColor: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      new RaisedButton(
                                        child: new Text("Pick Game Date"),
                                        onPressed: () async {
                                          gameDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate:
                                              DateTime(DateTime.now().year,
                                                  DateTime.now().month, DateTime.now().day),
                                              lastDate: DateTime(DateTime.now().year, 12, 31)
                                          );
                                          year = gameDate.year.toString();
                                          switch(gameDate.month){
                                            case 1:
                                              month = "January";
                                              break;
                                            case 2:
                                              month = "February";
                                              break;
                                            case 3:
                                              month = "March";
                                              break;
                                            case 4:
                                              month = "April";
                                              break;
                                            case 5:
                                              month = "May";
                                              break;
                                            case 6:
                                              month = "June";
                                              break;
                                            case 7:
                                              month = "July";
                                              break;
                                            case 8:
                                              month = "August";
                                              break;
                                            case 9:
                                              month = "September";
                                              break;
                                            case 10:
                                              month = "October";
                                              break;
                                            case 11:
                                              month = "November";
                                              break;
                                            case 12:
                                              month = "December";
                                              break;
                                            default:
                                              break;
                                          }
                                          _editGameDateController.text = month + " " + gameDate.day.toString() + ", " + gameDate.year.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new SizedBox(
                                        width: 185.0,
                                        child: new TextField(
                                          controller: _editGameTimeController,
                                          enabled: false,
                                          decoration: new InputDecoration(
                                            labelText: "${game['GameTime']}",
                                            filled: true,
                                            fillColor: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      new RaisedButton(
                                          child: new Text("Pick Game Time"),
                                          onPressed: () async {
                                            gameTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            _editGameTimeController.text = gameTime.format(context);
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _editOpposingTeamController,
                                    decoration: new InputDecoration(
                                      labelText: "${game['OpposingTeam']}",
                                      fillColor: Colors.black12,
                                      filled: true,
                                      suffixIcon: new IconButton(
                                          icon: new Icon(Icons.clear),
                                          onPressed: (){
                                            _editOpposingTeamController.text = "";
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _editGameLocationController,
                                    decoration: new InputDecoration(
                                        labelText: "${game['GameLocation']}",
                                        fillColor: Colors.black12,
                                        filled: true,
                                        suffixIcon: new IconButton(
                                            icon: new Icon(Icons.clear),
                                            onPressed: (){
                                              _editGameLocationController.text = "";
                                            })
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  DropdownButton(
                                    items: _homeOrAwayOptions,
                                    onChanged: _chooseHomeOrAway,
                                    hint: Text("${game['HomeOrAway']}"),
                                    value: _homeOrAway,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    items: _winOrLossOptions,
                                    onChanged: _recordWinOrLoss,
                                    hint: Text("Record Win or Loss"),
                                    value: winOrLoss,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    new RaisedButton(
                                      onPressed: (){
                                        if(_editGameDateController.text == ""){
                                          _editGameDateController.text = "${game['GameDate']}";
                                        }
                                        if(_editGameTimeController.text == ""){
                                          _editGameTimeController.text = "${game['GameTime']}";
                                        }
                                        if(_editOpposingTeamController.text == ""){
                                          _editOpposingTeamController.text = "${game['OpposingTeam']}";
                                        }
                                        if(_editGameLocationController.text == ""){
                                          _editGameLocationController.text = "${game['GameLocation']}";
                                        }
                                        if(_homeOrAway == ""){
                                          _homeOrAway = "${game['HomeOrAway']}";
                                        }
                                        if(winOrLoss == ""){
                                          winOrLoss = "unknown";
                                        }

                                        // TODO: Record win/loss in a Record document

                                        globals.gamesDB.document(globals.selectedGameDocument).updateData(
                                          {
                                            "GameDate":_editGameDateController.text,
                                            "GameTime":_editGameTimeController.text,
                                            "OpposingTeam":_editOpposingTeamController.text,
                                            "GameLocation":_editGameLocationController.text,
                                            "HomeOrAway":_homeOrAway,
                                            "WinOrLoss":winOrLoss
                                          }
                                        );

                                        Navigator.pop(context);
                                      },
                                      color: Colors.blue,
                                      child: new Text(
                                        "Update",
                                        style: new TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      splashColor: Colors.lightBlueAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
