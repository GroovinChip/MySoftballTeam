import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_softball_team/globals.dart' as globals;

class Leaderboard extends StatefulWidget {
  final String statSort;

  const Leaderboard({
    this.statSort,
  });

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  CollectionReference players = Firestore.instance
      .collection("Teams")
      .document(globals.teamName)
      .collection("Players");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuerySnapshot>>(
      stream: StreamZip([
        globals.usersDB.snapshots(),
        players.orderBy(widget.statSort, descending: true).snapshots(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final userStream = snapshot.data[0];
          final playerStream = snapshot.data[1];

          DocumentSnapshot userDoc;
          List<DocumentSnapshot> players = playerStream.documents;
          for (int i = 0; i < userStream.documents.length; i++) {
            if (userStream.documents[i].documentID ==
                globals.loggedInUser.uid) {
              userDoc = userStream.documents[i];
            }
          }

          return ListView.builder(
            itemCount: playerStream.documents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.indigoAccent,
                            ),
                          ),
                        ),
                        Text(
                          playerStream.documents[index]['PlayerName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            playerStream.documents[index]
                                [userDoc['StatTableSort']],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
