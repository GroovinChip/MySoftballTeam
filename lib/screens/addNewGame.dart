import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;

class AddNewGame extends StatefulWidget{
  @override
  _AddNewGameState createState() => _AddNewGameState();
}

class _AddNewGameState extends State<AddNewGame> {

  List<DropdownMenuItem> _homeOrAwayOptions = [
    DropdownMenuItem(child: Text("Home"), value: "Home",),
    DropdownMenuItem(child: Text("Away"), value: "Away",),
    DropdownMenuItem(child: Text("Bye"), value: "Bye",)
  ];

  TextEditingController _opposingTeamController = TextEditingController();
  TextEditingController _gameLocationController = TextEditingController();
  TextEditingController _gameDateController = TextEditingController();
  TextEditingController _gameTimeController = TextEditingController();
  String year;
  String month;
  DateTime gameDate;
  TimeOfDay gameTime;
  String _homeOrAway;

  void _chooseHomeOrAway(value) {
    setState(() {
      _homeOrAway = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Game"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 185.0,
                                  child: TextField(
                                    controller: _gameDateController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: "Game Date*",
                                      filled: true,
                                      fillColor: Colors.black12,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  child: Text("Pick Game Date"),
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
                                    _gameDateController.text = month + " " + gameDate.day.toString() + ", " + gameDate.year.toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 185.0,
                                  child: TextField(
                                    controller: _gameTimeController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: "Game Time*",
                                      filled: true,
                                      fillColor: Colors.black12,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  child: Text("Pick Game Time"),
                                  onPressed: () async {
                                    gameTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    _gameTimeController.text = gameTime.format(context);
                                  }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                            child: TextField(
                              controller: _opposingTeamController,
                              decoration: InputDecoration(
                                labelText: "Opposing Team*",
                                fillColor: Colors.black12,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: (){
                                    _opposingTeamController.text = "";
                                  }
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            controller: _gameLocationController,
                            decoration: InputDecoration(
                                labelText: "Game Location*",
                                fillColor: Colors.black12,
                                filled: true,
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: (){
                                      _gameLocationController.text = "";
                                    })
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      DropdownButton(
                        items: _homeOrAwayOptions,
                        onChanged: _chooseHomeOrAway,
                        hint: Text("Home or Away"),
                        value: _homeOrAway,
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: (){
                              if(_gameDateController.text != "" && _gameTimeController.text != "") {
                                if(_opposingTeamController.text != "" && _gameLocationController.text != "") {
                                  globals.gamesDB.add({
                                    "GameDate":_gameDateController.text,
                                    "GameTime":_gameTimeController.text,
                                    "OpposingTeam":_opposingTeamController.text,
                                    "GameLocation":_gameLocationController.text,
                                    "HomeOrAway":_homeOrAway
                                  });
                                  Navigator.pop(context);
                                }
                              }
                            },
                            color: Colors.indigo,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            splashColor: Colors.indigoAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
