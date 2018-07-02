import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;

class AddNewGame extends StatefulWidget{
  @override
  _AddNewGameState createState() => new _AddNewGameState();
}

class _AddNewGameState extends State<AddNewGame> {

  //CollectionReference scheduleDB = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Games"); needs Season

  List<DropdownMenuItem> _homeOrAwayOptions = [
    new DropdownMenuItem(child: new Text("Home"), value: "Home",),
    new DropdownMenuItem(child: new Text("Away"), value: "Away",),
    new DropdownMenuItem(child: new Text("Bye"), value: "Bye",)
  ];

  TextEditingController _opposingTeamController = new TextEditingController();
  TextEditingController _gameLocationController = new TextEditingController();
  TextEditingController _gameDateController = new TextEditingController();
  TextEditingController _gameTimeController = new TextEditingController();
  String year;
  String month;
  DateTime gameDate;
  TimeOfDay gameTime;
  String _homeOrAway;

  void _chooseHomeOrAway(value) {
    print(value);
    setState(() {
      _homeOrAway = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Game"),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
              child: new Card(
                elevation: 4.0,
                child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(
                                  width: 185.0,
                                  child: new TextField(
                                    controller: _gameDateController,
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Game Date*",
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
                                new SizedBox(
                                  width: 185.0,
                                  child: new TextField(
                                    controller: _gameTimeController,
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Game Time*",
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
                                    _gameTimeController.text = gameTime.format(context);
                                  }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                            child: new TextField(
                              controller: _opposingTeamController,
                              decoration: new InputDecoration(
                                labelText: "Opposing Team*",
                                fillColor: Colors.black12,
                                filled: true,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _opposingTeamController.text = "";
                                  }
                                ),
                              ),
                            ),
                          ),
                          TextField(
                            controller: _gameLocationController,
                            decoration: new InputDecoration(
                                labelText: "Game Location*",
                                fillColor: Colors.black12,
                                filled: true,
                                suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _gameLocationController.text = "";
                                    })
                            ),
                          ),
                        ],
                      ),
                      new SizedBox(height: 15.0),
                      new DropdownButton(
                        items: _homeOrAwayOptions,
                        onChanged: _chooseHomeOrAway,
                        hint: new Text("Home or Away"),
                        value: _homeOrAway,
                      ),
                      new SizedBox(height: 25.0),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: (){
                              if(_gameDateController.text != "" && _gameTimeController.text != "") {
                                if(_opposingTeamController.text != "" && _gameLocationController.text != "") {
                                  CollectionReference gamesDB = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Seasons").document(year).collection("Games");
                                  gamesDB.add({
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
                            color: Colors.blue,
                            child: new Text(
                              "Save",
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
            ),
          ],
        ),
      ),
    );
  }
}
