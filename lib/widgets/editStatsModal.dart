import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EditStatsModal extends StatefulWidget {
  @override
  _EditStatsModalState createState() => _EditStatsModalState();
}

class _EditStatsModalState extends State<EditStatsModal> {

  // Controllers
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

  CollectionReference playersCollection = Firestore.instance.collection("Teams").document(globals.teamName).collection("Players");
  DocumentSnapshot player;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Update Stats"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: playersCollection.snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData == true) {
            List<DocumentSnapshot> players = snapshot.data.documents;
            for(int index = 0; index < players.length; index++){
              if(players[index].documentID == globals.selectedPlayerName){
                player = players[index];
              }
            }
            return new SingleChildScrollView(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Current At Bats: ${player['AtBats']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _atBatsController.text="";
                                    },
                                  )
                                ),
                                controller: _atBatsController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Singles: ${player['Singles']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _singlesController.text="";
                                      },
                                    )
                                ),
                                controller: _singlesController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Doubles: ${player['Doubles']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _doublesController.text="";
                                      },
                                    )
                                ),
                                controller: _doublesController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Triples: ${player['Triples']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _triplesController.text="";
                                      },
                                    )
                                ),
                                controller: _triplesController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Homes Runs: ${player['HomeRuns']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _homeRunsController.text="";
                                      },
                                    )
                                ),
                                controller: _homeRunsController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current RBIs: ${player['RunsBattedIn']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _runsBattedInController.text="";
                                      },
                                    )
                                ),
                                controller: _runsBattedInController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Walks: ${player['Walks']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _walksController.text="";
                                      },
                                    )
                                ),
                                controller: _walksController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    labelText: "Current Strikeouts: ${player['Strikeouts']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: new IconButton(
                                      icon: new Icon(Icons.clear),
                                      onPressed: (){
                                        _strikeoutsController.text="";
                                      },
                                    )
                                ),
                                controller: _strikeoutsController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Current Games Played: ${player['GamesPlayed']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _gamesPlayerController.text="";
                                    },
                                  )
                                ),
                                controller: _gamesPlayerController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Current Outs Fielded: ${player['OutsFielded']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _outsFieldedController.text="";
                                    },
                                  )
                                ),
                                controller: _outsFieldedController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Current Outs Received: ${player['OutsReceived']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _outsReceivedController.text="";
                                    },
                                  )
                                ),
                                controller: _outsReceivedController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new RaisedButton(
                                    onPressed: (){
                                      gamesPlayed = _gamesPlayerController.text;
                                      atBats = _atBatsController.text;
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

                                      playersCollection.document(globals.selectedPlayerName).updateData({
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
                                    },
                                    color: Colors.blue,
                                    child: new Text("Save", style: new TextStyle(color: Colors.white)),
                                    splashColor: Colors.lightBlueAccent,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
