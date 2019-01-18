import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/screens/SeasonSchedule/edit_game.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class GameCard extends StatefulWidget{
  final String gameID;
  final String homeOrAway;
  final String teamName;
  final String opposingTeam;
  final String gameDate;
  final String gameTime;
  final String gameLocation;
  final bool isPreviousGame;

  GameCard({
    this.gameID,
    this.homeOrAway,
    this.teamName,
    this.opposingTeam,
    this.gameDate,
    this.gameTime,
    this.gameLocation,
    this.isPreviousGame
  });

  @override
  GameCardState createState() {
    return GameCardState();
  }
}

class GameCardState extends State<GameCard> {
  String fullText;
  TextEditingController ownTeamScoreController = TextEditingController();
  TextEditingController opposingTeamScoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    switch (widget.homeOrAway) {
      case "Home":
        fullText = widget.teamName + " VS " + widget.opposingTeam;
        break;
      case "Away":
        fullText = widget.opposingTeam + " VS " + widget.teamName;
        break;
      case "Bye":
        fullText = widget.homeOrAway;
        break;
    }
    return Card(
      elevation: 2.0,
      //shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 6.0, top: 8.0),
            child: Text(
              fullText,
              style: TextStyle(
                fontSize: widget.isPreviousGame == false ? 22.0 : 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
            child: Text(
                widget.gameTime + " on " + widget.gameDate
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
                widget.gameLocation
            ),
          ),
          // Check if this game is a previous game - if so, do not show the action row
          (widget.isPreviousGame == false) ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_outline),
                tooltip: "Delete game",
                onPressed: () {
                  globals.selectedGameDocument = widget.gameID;
                  showDialog(
                  context: context,
                  builder: (_) =>
                    SimpleDialog(
                      title: Text("Delete Game"),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ListTile(
                            title: Text(
                                "Are you sure you want to remove this game from the schedule?"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                child: Text("No", style: TextStyle(color: Theme.of(context).accentColor),),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("Yes", style: TextStyle(color: Theme.of(context).accentColor),),
                                onPressed: () {
                                  globals.gamesDB.document(
                                      globals.selectedGameDocument)
                                      .delete();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(GroovinMaterialIcons.edit_outline),
                tooltip: "Edit game details",
                onPressed: () {
                  globals.selectedGameDocument = widget.gameID;
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return EditGame();
                      },
                      fullscreenDialog: true
                  ));
                },
              ),
              IconButton(
                icon: Icon(OMIcons.driveEta),
                tooltip: "Drive to Game",
                onPressed: () {
                  globals.selectedGameDocument = widget.gameID;
                  launch("https://www.google.com/maps/search/?api=1&query=" + widget.gameLocation);
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList").snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData == false) {
                    return IconButton(
                      icon: Icon(OMIcons.email),
                      tooltip: "Send game reminder",
                      onPressed: () async {

                      },
                    );
                  } else {
                    List<String> emailAddresses = [];
                    for(int i = 0; i < snapshot.data.documents.length; i++){
                      DocumentSnapshot ds = snapshot.data.documents[i];
                      emailAddresses.add(ds.documentID);
                    }
                    String s = "";
                    emailAddresses.forEach((value) {
                      s += value + "; ";
                    });
                    return IconButton(
                      icon: Icon(OMIcons.email),
                      tooltip: "Send game reminder",
                      onPressed: () async {
                        final Email email = Email(
                          body: '',
                          subject: 'Game Today!',
                          recipients: emailAddresses,
                        );
                        await FlutterEmailSender.send(email);
                      },
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(GroovinMaterialIcons.trophy_variant_outline),
                  tooltip: "Record score",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                        SimpleDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Record Score")
                            ],
                          ),
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24.0),
                                      child: Text(widget.teamName),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24.0),
                                      child: SizedBox(
                                        width: 25.0,
                                        child: TextField(
                                          controller: ownTeamScoreController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24.0),
                                      child: Text(widget.opposingTeam),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24.0),
                                      child: SizedBox(
                                        width: 25.0,
                                        child: TextField(
                                          controller: opposingTeamScoreController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text("Save", style: TextStyle(color: Colors.indigo),),
                                      onPressed: () {
                                        int ownScore = int.parse(ownTeamScoreController.text);
                                        int opposingScore = int.parse(opposingTeamScoreController.text);
                                        String winOrLoss;
                                        if(ownScore > opposingScore){
                                          winOrLoss = "Win";
                                        } else {
                                          winOrLoss = "Loss";
                                        }
                                        if(ownScore == opposingScore){
                                          winOrLoss = "Unknown"; //TODO figure something out with this
                                        }
                                        globals.gamesDB.document(widget.gameID).updateData({
                                          "WinOrLoss":winOrLoss
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                    );
                  },
                ),
              ),
            ],
          ) : Container(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
          ),
        ],
      ),
    );
  }
}
