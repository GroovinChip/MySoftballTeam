import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/GroovinDropdownButton.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                "Player",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
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