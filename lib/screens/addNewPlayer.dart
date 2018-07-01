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
  TextEditingController _gamesPlayerController = new TextEditingController();
  TextEditingController _atBatsController = new TextEditingController();
  TextEditingController _baseHitsController = new TextEditingController();
  TextEditingController _outsReceivedController = new TextEditingController();
  TextEditingController _assistsController = new TextEditingController();
  TextEditingController _outsFieldedController = new TextEditingController();

  // Variables
  String playerName;
  String position;
  String gamesPlayed;
  String atBats;
  String baseHits;
  String outsReceived;
  String assists;
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
                              controller: _baseHitsController,
                              decoration: new InputDecoration(
                                labelText: "Base Hits",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _baseHitsController.text = "";
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
                              controller: _assistsController,
                              decoration: new InputDecoration(
                                labelText: "Assists",
                                filled: true,
                                fillColor: Colors.black12,
                                suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _assistsController.text = "";
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
                                  gamesPlayed = _gamesPlayerController.text;
                                  atBats = _atBatsController.text;
                                  baseHits = _baseHitsController.text;
                                  outsReceived = _outsReceivedController.text;
                                  assists = _assistsController.text;
                                  outsFielded = _outsFieldedController.text;

                                  if(playerName == ""){
                                    playerName = "0";
                                  }

                                  if(gamesPlayed == ""){
                                    gamesPlayed = "0";
                                  }

                                  if(atBats == ""){
                                    atBats = "0";
                                  }

                                  if(baseHits == ""){
                                    baseHits = "0";
                                  }

                                  if(outsReceived == ""){
                                    outsReceived = "0";
                                  }

                                  if(assists == ""){
                                    assists = "0";
                                  }

                                  if(outsFielded == ""){
                                    outsFielded = "0";
                                  }

                                  // Save the player to the database
                                  CollectionReference team = Firestore.instance.collection('Teams').document(globals.teamTame).collection("Players");
                                  //CollectionReference stats = Firestore.instance.collection('Teams').document(globals.teamTame).collection("Stats");
                                  team.document(playerName).setData({
                                    "PlayerName" : playerName,
                                    "FieldPosition" : position,
                                    "GamesPlayed" : gamesPlayed,
                                    "AtBats" : atBats,
                                    "BaseHits" : baseHits,
                                    "OutsReceived" : outsReceived,
                                    "Assists" : assists,
                                    "OutsFielded" : outsFielded
                                  });

                                  /*stats.document("Games Played").setData({"PlayerName":playerName, "GamesPlayedCount":gamesPlayed});
                                  stats.document("At Bats").setData({"PlayerName":playerName, "AtBatsCount":gamesPlayed});
                                  stats.document("Base Hits").setData({"PlayerName":playerName, "BaseHitsCount":gamesPlayed});
                                  stats.document("Outs Received").setData({"PlayerName":playerName, "OutsReceivedCount":gamesPlayed});
                                  stats.document("Assists").setData({"PlayerName":playerName, "AssistsCount":gamesPlayed});
                                  stats.document("Outs Fielded").setData({"PlayerName":playerName, "OutsFieldedCount":gamesPlayed});*/
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
