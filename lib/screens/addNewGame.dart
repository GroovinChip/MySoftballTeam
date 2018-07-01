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
  ];

  TextEditingController _opposingTeamController = new TextEditingController();
  TextEditingController _gameLocationController = new TextEditingController();
  TextEditingController _gameDateController = new TextEditingController();
  TextEditingController _gameTimeController = new TextEditingController();
  String _homeOrAway;

  void _chooseHomeOrAway(value) {
    print(value);
    _homeOrAway = value;
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
                                    String month;
                                    DateTime gameDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:
                                        DateTime(DateTime.now().year,
                                        DateTime.now().month, DateTime.now().day),
                                      lastDate: DateTime(3000));
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
                                    TimeOfDay gameTime = await showTimePicker(
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
                      new SizedBox(height: 25.0),
                      /*new Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: new ExpansionTile(
                          title: new Text("Post Game Options"),
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: new Text("Score:"),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: new Text("MyTeam:"),
                                ),
                                new SizedBox(
                                  width: 100.0,
                                  child: new Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: new TextField(
                                      keyboardType: TextInputType.number
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: new Text("Opposing Team:"),
                                  ),
                                  new SizedBox(
                                    width: 100.0,
                                    child: new Padding(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: new TextField(
                                        keyboardType: TextInputType.number
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: (){

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
