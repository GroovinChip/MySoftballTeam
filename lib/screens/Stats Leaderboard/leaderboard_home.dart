import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'leaderboard_header.dart';
import 'leaderboard.dart';

CollectionReference root = Firestore.instance.collection("Teams");
CollectionReference stats = Firestore.instance
    .collection("Teams")
    .document(globals.teamName)
    .collection("Stats");

class StatsTable extends StatefulWidget {
  @override
  _StatsTableState createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  bool sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: LeaderboardHeader(),
        ),
        Leaderboard(),
      ],
    );
  }
}