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
  TextEditingController _atBatsController = TextEditingController();
  TextEditingController _singlesController = TextEditingController();
  TextEditingController _doublesController = TextEditingController();
  TextEditingController _triplesController = TextEditingController();
  TextEditingController _homeRunsController = TextEditingController();
  TextEditingController _runsBattedInController = TextEditingController();
  TextEditingController _walksController = TextEditingController();
  TextEditingController _strikeoutsController = TextEditingController();
  TextEditingController _gamesPlayerController = TextEditingController();
  TextEditingController _outsReceivedController = TextEditingController();
  TextEditingController _outsFieldedController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Update Stats",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
            atBats = "${player['AtBats']}";
            singles = "${player['Singles']}";
            doubles = "${player['Doubles']}";
            triples = "${player['Triples']}";
            homeRuns = "${player['HomeRuns']}";
            runsBattedIn = "${player['RunsBattedIn']}";
            walks = "${player['Walks']}";
            strikeouts = "${player['Strikeouts']}";
            gamesPlayed = "${player['GamesPlayed']}";
            outsReceived = "${player['OutsReceived']}";
            outsFielded = "${player['OutsFielded']}";
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Current At Bats: ${player['AtBats']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Singles: ${player['Singles']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Doubles: ${player['Doubles']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Triples: ${player['Triples']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Home Runs: ${player['HomeRuns']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current RBIs: ${player['RunsBattedIn']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Walks: ${player['Walks']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Current Strikeouts: ${player['Strikeouts']}",
                                    filled: true,
                                    fillColor: Colors.black12,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Current Games Played: " + gamesPlayed,
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Current Outs Fielded: ${player['OutsFielded']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
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
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Current Outs Received: ${player['OutsReceived']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: (){
                                      /*gamesPlayed = _gamesPlayerController.text;
                                      atBats = _atBatsController.text;
                                      singles = _singlesController.text;
                                      doubles = _doublesController.text;
                                      triples = _triplesController.text;
                                      homeRuns = _homeRunsController.text;
                                      runsBattedIn = _runsBattedInController.text;
                                      walks = _walksController.text;
                                      strikeouts = _strikeoutsController.text;
                                      outsReceived = _outsReceivedController.text;
                                      outsFielded = _outsFieldedController.text;*/

                                      if(atBats == "" || atBats == null){
                                        atBats = "0";
                                      } else if(_atBatsController.text.length > 0) {
                                        atBats= _atBatsController.text;
                                      }

                                      if(singles == "" || singles == null){
                                        singles = "0";
                                      } else if(_singlesController.text.length > 0) {
                                        singles = _singlesController.text;
                                      }

                                      if(doubles == "" || doubles == null){
                                        doubles = "0";
                                      } else if(_doublesController.text.length > 0) {
                                        doubles = _doublesController.text;
                                      }

                                      if(triples == "" || triples == null){
                                        triples = "0";
                                      } else if(_triplesController.text.length > 0) {
                                        triples = _triplesController.text;
                                      }

                                      if(homeRuns == "" || homeRuns == null){
                                        homeRuns = "0";
                                      } else if(_homeRunsController.text.length > 0) {
                                        homeRuns = _homeRunsController.text;
                                      }

                                      if(runsBattedIn == "" || runsBattedIn == null){
                                        runsBattedIn = "0";
                                      } else if(_runsBattedInController.text.length > 0) {
                                        runsBattedIn = _runsBattedInController.text;
                                      }

                                      if(walks == "" || walks == null){
                                        walks = "0";
                                      } else if(_walksController.text.length > 0) {
                                        walks = _walksController.text;
                                      }

                                      if(strikeouts == "" || strikeouts == null){
                                        strikeouts = "0";
                                      } else if(_strikeoutsController.text.length > 0) {
                                        strikeouts = _strikeoutsController.text;
                                      }

                                      if(gamesPlayed == "" || gamesPlayed == null){
                                        gamesPlayed = "0";
                                      } else if(_gamesPlayerController.text.length > 0) {
                                        gamesPlayed = _gamesPlayerController.text;
                                      }

                                      if(outsReceived == "" || outsReceived == null){
                                        outsReceived = "0";
                                      } else if(_outsReceivedController.text.length > 0) {
                                        outsReceived = _outsReceivedController.text;
                                      }

                                      if(outsFielded == "" || outsFielded == null){
                                        outsFielded = "0";
                                      } else if(_outsFieldedController.text.length > 0) {
                                        outsFielded = _outsFieldedController.text;
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
                                    color: Colors.indigo,
                                    child: Text(
                                      "Update", 
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
