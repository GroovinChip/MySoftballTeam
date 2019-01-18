import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/GroovinDropdownButton.dart';

CollectionReference root = Firestore.instance.collection("Teams");
CollectionReference players = Firestore.instance
    .collection("Teams")
    .document(globals.teamName)
    .collection("Players");
CollectionReference stats = Firestore.instance
    .collection("Teams")
    .document(globals.teamName)
    .collection("Stats");

class StatsTable extends StatefulWidget {
  @override
  _StatsTableState createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
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
        StreamBuilder<List<QuerySnapshot>>(
          stream: StreamZip([
            globals.usersDB.snapshots(),
            players.orderBy(statSort, descending: true).snapshots(),
          ]),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              final userStream = snapshot.data[0];
              final playerStream = snapshot.data[1];

              DocumentSnapshot userDoc;
              List<DocumentSnapshot> players = playerStream.documents;
              for(int i = 0; i < userStream.documents.length; i++) {
                if(userStream.documents[i].documentID == globals.loggedInUser.uid) {
                  userDoc = userStream.documents[i];
                }
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: playerStream.documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                  playerStream.documents[index][userDoc['StatTableSort']],
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
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

typedef LeaderboardHeaderChangeCallback = void Function(String);

class LeaderboardHeader extends StatefulWidget {
  final String defaultSelection;
  final LeaderboardHeaderChangeCallback onSelectionChange;

  LeaderboardHeader({
    @required this.defaultSelection,
    @required this.onSelectionChange,
  });

  @override
  _LeaderboardHeaderState createState() => _LeaderboardHeaderState();
}

class _LeaderboardHeaderState extends State<LeaderboardHeader> {
  CollectionReference stats = Firestore.instance
      .collection("Teams")
      .document(globals.teamName)
      .collection("Stats");
  String statSelection;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Rank",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Text(
              "Player",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: DropdownButtonHideUnderline(
                child: StreamBuilder<QuerySnapshot>(
                  stream: stats.snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      print(snapshot.error);
                    }
                    if(!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final statListFromSnaps = snapshot;
                      final List<DropdownMenuItem> statList = [];

                      for(int i = 0; i < statListFromSnaps.data.documents.length; i++) {
                        DocumentSnapshot statSnap = statListFromSnaps.data.documents[i];
                        String value = statSnap.documentID.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                        statList.add(
                          DropdownMenuItem(
                            child: Text(
                              statSnap.documentID,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                              ),
                            ),
                            value: value,
                          ),
                        );
                      }

                      statSelection = widget.defaultSelection;

                      return Theme(
                        data: ThemeData(
                          canvasColor: Colors.indigoAccent,
                        ),
                        child: GroovinDropdownButton(
                          items: statList,
                          isExpanded: true,
                          iconColor: Colors.white,
                          hint: Text(
                            "Stat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() async{
                              statSelection = value;
                              await globals.usersDB.document(globals.loggedInUser.uid).updateData({
                                "StatTableSort":statSelection,
                              });
                              widget.onSelectionChange(statSelection);
                            });
                          },
                          value: statSelection,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
