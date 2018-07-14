import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;

class AddNewPlayer extends StatefulWidget {
  @override
  _AddNewPlayerState createState() => new _AddNewPlayerState();
}

class _AddNewPlayerState extends State<AddNewPlayer> {

  // Controllers
  TextEditingController _playerNameController = new TextEditingController();
  TextEditingController _atBatsController = new TextEditingController();
  TextEditingController _singlesController = new TextEditingController();
  TextEditingController _doublesController = new TextEditingController();
  TextEditingController _triplesController = new TextEditingController();
  TextEditingController _homeRunsController = new TextEditingController();
  TextEditingController _runsBattedInController = new TextEditingController();
  TextEditingController _walksController = new TextEditingController();
  TextEditingController _strikeoutsController = new TextEditingController();
  TextEditingController _gamesPlayerController = new TextEditingController();
  TextEditingController _outsReceivedController = new TextEditingController();
  TextEditingController _outsFieldedController = new TextEditingController();

  // Variables
  String playerName;
  String position;
  String atBats;
  String singles;
  String doubles;
  String triples;
  String homeRuns;
  String runsBattedIn;
  String walks;
  String strikeouts;
  String gamesPlayed;
  String outsReceived;
  String outsFielded;

  // Set field position on DropdownButton tap
  void _chooseFieldPosition(value) {
    setState(() {
      position = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Player"),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Card(
                elevation: 4.0,
                child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(
                          labelText: "Player Name",
                          filled: true,
                          fillColor: Colors.black12,
                          suffixIcon: new IconButton(
                            icon: new Icon(Icons.clear),
                            onPressed: (){
                              _playerNameController.text = "";
                            }),
                        ),
                        controller: _playerNameController,
                      ),
                      new SizedBox(
                        height: 25.0,
                      ),
                      new DropdownButton(
                        items: globals.fieldPositions,
                        onChanged: _chooseFieldPosition,
                        hint: new Text("Choose Field Position"),
                        value: position,
                      ),
                      new SizedBox(
                        height: 15.0,
                      ),
                      new ExpansionTile(
                        title: new Text("Initial Stats (Optional)"),
                        children: <Widget>[
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _atBatsController,
                              decoration: new InputDecoration(
                                labelText: "At Bats",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _atBatsController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _singlesController,
                              decoration: new InputDecoration(
                                labelText: "Singles",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _singlesController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _doublesController,
                              decoration: new InputDecoration(
                                labelText: "Doubles",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _doublesController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _triplesController,
                              decoration: new InputDecoration(
                                labelText: "Triples",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _triplesController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _homeRunsController,
                              decoration: new InputDecoration(
                                labelText: "Home Runs",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _homeRunsController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _runsBattedInController,
                              decoration: new InputDecoration(
                                labelText: "Runs Batted In",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _runsBattedInController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _walksController,
                              decoration: new InputDecoration(
                                labelText: "Walks",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _walksController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _strikeoutsController,
                              decoration: new InputDecoration(
                                labelText: "Strikeouts",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _strikeoutsController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _gamesPlayerController,
                              decoration: new InputDecoration(
                                labelText: "Games Played",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _gamesPlayerController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _outsReceivedController,
                              decoration: new InputDecoration(
                                labelText: "Outs Received",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _outsReceivedController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 15.0,
                          ),
                          new SizedBox(
                            width: double.infinity,
                            child: new TextField(
                              keyboardType: TextInputType.number,
                              controller: _outsFieldedController,
                              decoration: new InputDecoration(
                                labelText: "Outs Fielded",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.clear),
                                  onPressed: (){
                                    _outsFieldedController.text = "";
                                  }),
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                        ],
                      ),
                      new SizedBox(
                        height: 25.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: () => Firestore.instance
                                    .runTransaction((transaction) async {
                                  // Get all the text from the fields
                                  playerName = _playerNameController.text;
                                  atBats = _atBatsController.text;
                                  singles = _singlesController.text;
                                  doubles = _doublesController.text;
                                  triples = _triplesController.text;
                                  homeRuns = _homeRunsController.text;
                                  runsBattedIn = _runsBattedInController.text;
                                  gamesPlayed = _gamesPlayerController.text;
                                  outsReceived = _outsReceivedController.text;
                                  outsFielded = _outsFieldedController.text;

                                  if(atBats == "" || atBats == null){
                                    atBats = "0";
                                  }

                                  if(singles == "" || singles == null){
                                    singles = "0";
                                  }

                                  if(doubles == "" || doubles == null){
                                    doubles = "0";
                                  }

                                  if(triples == "" || triples == null){
                                    triples = "0";
                                  }

                                  if(homeRuns == "" || homeRuns == null){
                                    homeRuns = "0";
                                  }

                                  if(runsBattedIn == "" || runsBattedIn == null){
                                    runsBattedIn = "0";
                                  }

                                  if(walks == "" || walks == null){
                                    walks = "0";
                                  }

                                  if(strikeouts == "" || strikeouts == null){
                                    strikeouts = "0";
                                  }

                                  if(gamesPlayed == "" || gamesPlayed == null){
                                    gamesPlayed = "0";
                                  }

                                  if(outsReceived == "" || outsReceived == null){
                                    outsReceived = "0";
                                  }

                                  if(outsFielded == "" || outsFielded == null){
                                    outsFielded = "0";
                                  }

                                  // Save the player to the database
                                  CollectionReference team = Firestore.instance.collection('Teams').document(globals.teamName).collection("Players");
                                  team.document(playerName).setData({
                                    "PlayerName" : playerName,
                                    "FieldPosition" : position,
                                    "AtBats" : atBats,
                                    "Singles" : singles,
                                    "Doubles" : doubles,
                                    "Triples" : triples,
                                    "HomeRuns" : homeRuns,
                                    "RunsBattedIn" : runsBattedIn,
                                    "Walks" : walks,
                                    "Strikeouts" : strikeouts,
                                    "GamesPlayed" : gamesPlayed,
                                    "OutsReceived" : outsReceived,
                                    "OutsFielded" : outsFielded
                                  });

                                  Navigator.pop(context);
                                }),
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
