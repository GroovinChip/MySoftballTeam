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
  bool sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: LeaderboardHeader(),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: players.snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final player = snapshot;
              return Expanded(
                child: ListView.builder(
                  itemCount: player.data.documents.length,
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
                              Text((index + 1).toString()),
                              Text(player.data.documents[index]['PlayerName']),
                              //Text(statSelection != null ? player.data.documents[index][statSelection] : ""),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

              //return Container();
            }
          },
        ),
      ],
    );
  }
}

class LeaderboardHeader extends StatefulWidget {
  @override
  _LeaderboardHeaderState createState() => _LeaderboardHeaderState();
}

class _LeaderboardHeaderState extends State<LeaderboardHeader> {
  CollectionReference stats = Firestore.instance
      .collection("Teams")
      .document(globals.teamName)
      .collection("Stats");
  String statSelection = null;

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
              ),
            ),
            Text(
              "Player",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: DropdownButtonHideUnderline(
                child: StreamBuilder(
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
                        statList.add(
                          DropdownMenuItem(
                            child: Text(
                              statSnap.documentID,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            value: statSnap.documentID,
                          ),
                        );
                      }

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
                            setState(() {
                              statSelection = value;
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
