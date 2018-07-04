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
  TextEditingController _gamesPlayerController = new TextEditingController();
  TextEditingController _atBatsController = new TextEditingController();
  TextEditingController _baseHitsController = new TextEditingController();
  TextEditingController _outsReceivedController = new TextEditingController();
  TextEditingController _assistsController = new TextEditingController();
  TextEditingController _outsFieldedController = new TextEditingController();

  // Variables
  String gamesPlayed;
  String atBats;
  String baseHits;
  String outsReceived;
  String assists;
  String outsFielded;

  CollectionReference playersCollection = Firestore.instance.collection("Teams").document(globals.teamName).collection("Players");
  DocumentSnapshot player;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Update Stats"),
        actions: <Widget>[
          new FlatButton(onPressed: (){}, child: new Text("Save", style: new TextStyle(color: Colors.white),)),
        ],
      ),
      // TODO: Wrap SingleChildScrollView in StreamBuilder to load in existing stats into the TextFields
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
                                  labelText: "Current Assists: ${player['Assists']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _assistsController.text="";
                                    },
                                  )
                                ),
                                controller: _assistsController,
                                onChanged: (text) {
                                  //_assistsController.text = text;
                                  print(_assistsController.text);
                                },
                              ),
                            ),
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
                                  labelText: "Current Base Hits: ${player['BaseHits']}",
                                  filled: true,
                                  fillColor: Colors.black12,
                                  suffixIcon: new IconButton(
                                    icon: new Icon(Icons.clear),
                                    onPressed: (){
                                      _baseHitsController.text="";
                                    },
                                  )
                                ),
                                controller: _baseHitsController,
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
                                      baseHits = _baseHitsController.text;
                                      outsReceived = _outsReceivedController.text;
                                      assists = _assistsController.text;
                                      outsFielded = _outsFieldedController.text;

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


                                      playersCollection.document(globals.selectedPlayerName).updateData({
                                        "GamesPlayed" : gamesPlayed,
                                        "AtBats" : atBats,
                                        "BaseHits" : baseHits,
                                        "OutsReceived" : outsReceived,
                                        "Assists" : assists,
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
