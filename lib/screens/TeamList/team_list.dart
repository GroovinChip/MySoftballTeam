import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/screens/TeamList/player_card.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

CollectionReference teamCollection = Firestore.instance.collection("Teams")
    .document(globals.teamName)
    .collection("Players");

class _TeamListState extends State<TeamList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: teamCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: PlayerCard(
                  playerSnap: ds,
                ),
              );
            });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

