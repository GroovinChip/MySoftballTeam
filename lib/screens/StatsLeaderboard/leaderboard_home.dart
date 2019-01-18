import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/screens/StatsLeaderboard/leaderboard.dart';
import 'package:my_softball_team/screens/StatsLeaderboard/leaderboard_header.dart';

CollectionReference root = Firestore.instance.collection("Teams");
CollectionReference stats = Firestore.instance
    .collection("Teams")
    .document(globals.teamName)
    .collection("Stats");

class LeaderboardHome extends StatefulWidget {
  @override
  _LeaderboardHomeState createState() => _LeaderboardHomeState();
}

class _LeaderboardHomeState extends State<LeaderboardHome> {
  String statSort;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: globals.usersDB.snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                DocumentSnapshot user;
                for(int i = 0; i < snapshot.data.documents.length; i++) {
                  if(snapshot.data.documents[i].documentID == globals.loggedInUser.uid) {
                    user = snapshot.data.documents[i];
                  }
                }
                statSort = user['StatTableSort'];
                return LeaderboardHeader(
                  defaultSelection: user['StatTableSort'],
                  onSelectionChange: (value) {
                    setState(() {

                    });
                  },
                );
              }
            },
          ),
        ),
        Leaderboard(
          statSort: statSort,
        ),
      ],
    );
  }
}