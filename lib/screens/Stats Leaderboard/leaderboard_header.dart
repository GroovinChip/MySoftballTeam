import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/GroovinDropdownButton.dart';

class LeaderboardHeader extends StatefulWidget {
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
                              globals.usersDB.document(globals.loggedInUser.uid).updateData({
                                "StatTableSort":statSelection,
                              });
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
