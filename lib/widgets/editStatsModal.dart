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
  String position;
  String gamesPlayed;
  String atBats;
  String baseHits;
  String outsReceived;
  String assists;
  String outsFielded;

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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "Assists"
                          ),
                          controller: _assistsController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "At Bats"
                          ),
                          controller: _atBatsController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "Base Hits"
                          ),
                          controller: _baseHitsController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              labelText: "Games Played"
                          ),
                          controller: _gamesPlayerController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              labelText: "Outs Fielded"
                          ),
                          controller: _outsFieldedController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              labelText: "Outs Received"
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
                              onPressed: (){},
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
      ),
    );
  }
}
