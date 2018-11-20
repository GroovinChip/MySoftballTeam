import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:outline_material_icons/outline_material_icons.dart';

class AddNewPlayer extends StatefulWidget {
  @override
  _AddNewPlayerState createState() => _AddNewPlayerState();
}

class _AddNewPlayerState extends State<AddNewPlayer> {

  // Controllers
  TextEditingController _playerNameController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Player",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme
            .of(context)
            .canvasColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Player Name",
                      prefixIcon: Icon(OMIcons.person),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _playerNameController.text = "";
                          }),
                    ),
                    controller: _playerNameController,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  OutlineDropdownButton(
                    items: globals.fieldPositions,
                    onChanged: _chooseFieldPosition,
                    hint: Text("Choose Field Position"),
                    value: position,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ExpansionTile(
                    title: Text("Initial Stats (Optional)"),
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _atBatsController,
                          decoration: InputDecoration(
                            labelText: "At Bats",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _atBatsController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _singlesController,
                          decoration: InputDecoration(
                            labelText: "Singles",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _singlesController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _doublesController,
                          decoration: InputDecoration(
                            labelText: "Doubles",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _doublesController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _triplesController,
                          decoration: InputDecoration(
                            labelText: "Triples",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _triplesController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _homeRunsController,
                          decoration: InputDecoration(
                            labelText: "Home Runs",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _homeRunsController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _runsBattedInController,
                          decoration: InputDecoration(
                            labelText: "Runs Batted In",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _runsBattedInController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _walksController,
                          decoration: InputDecoration(
                            labelText: "Walks",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _walksController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _strikeoutsController,
                          decoration: InputDecoration(
                            labelText: "Strikeouts",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _strikeoutsController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _gamesPlayerController,
                          decoration: InputDecoration(
                            labelText: "Games Played",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _gamesPlayerController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _outsReceivedController,
                          decoration: InputDecoration(
                            labelText: "Outs Received",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _outsReceivedController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _outsFieldedController,
                          decoration: InputDecoration(
                            labelText: "Outs Fielded",
                            /*filled: true,
                            fillColor: Colors.black12,*/
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _outsFieldedController.text = "";
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Save"),
        icon: Icon(Icons.save),
        onPressed: () =>
            Firestore.instance.runTransaction((transaction) async {
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

              if (atBats == "" || atBats == null) {
                atBats = "0";
              }

              if (singles == "" || singles == null) {
                singles = "0";
              }

              if (doubles == "" || doubles == null) {
                doubles = "0";
              }

              if (triples == "" || triples == null) {
                triples = "0";
              }

              if (homeRuns == "" || homeRuns == null) {
                homeRuns = "0";
              }

              if (runsBattedIn == "" || runsBattedIn == null) {
                runsBattedIn = "0";
              }

              if (walks == "" || walks == null) {
                walks = "0";
              }

              if (strikeouts == "" || strikeouts == null) {
                strikeouts = "0";
              }

              if (gamesPlayed == "" || gamesPlayed == null) {
                gamesPlayed = "0";
              }

              if (outsReceived == "" || outsReceived == null) {
                outsReceived = "0";
              }

              if (outsFielded == "" || outsFielded == null) {
                outsFielded = "0";
              }

              // Save the player to the database
              CollectionReference team = Firestore.instance.collection('Teams')
                  .document(globals.teamName)
                  .collection("Players");
              team.document(playerName).setData({
                "PlayerName": playerName,
                "FieldPosition": position,
                "AtBats": atBats,
                "Singles": singles,
                "Doubles": doubles,
                "Triples": triples,
                "HomeRuns": homeRuns,
                "RunsBattedIn": runsBattedIn,
                "Walks": walks,
                "Strikeouts": strikeouts,
                "GamesPlayed": gamesPlayed,
                "OutsReceived": outsReceived,
                "OutsFielded": outsFielded
              });

              Navigator.pop(context);
            }),
      ),
    );
  }
}