import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/edit_stats.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class PlayerCard extends StatefulWidget {
  final DocumentSnapshot playerSnap;

  const PlayerCard({
    this.playerSnap,
  });

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  CollectionReference teamCollection = Firestore.instance
    .collection("Teams")
    .document(globals.teamName)
    .collection("Players");

  var position;

  // Set field position on DropdownButton tap
  void _changeFieldPosition(value) {
    setState(() {
      position = value;
      teamCollection
        .document(globals.selectedPlayerName)
        .updateData({"FieldPosition": position});
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            "${widget.playerSnap['PlayerName']}"[0],
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        title: Text(
          "${widget.playerSnap['PlayerName']}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${widget.playerSnap['FieldPosition']}"),
        trailing: SizedBox(
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  OMIcons.assessment,
                  color: Colors.black,
                ),
                onPressed: () {
                  globals.selectedPlayerName = "${widget.playerSnap['PlayerName']}";
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return EditStats();
                    },
                    fullscreenDialog: true),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  OMIcons.locationOn,
                  color: Colors.black,
                ),
                onPressed: () {
                  globals.selectedPlayerName = "${widget.playerSnap['PlayerName']}";
                  showDialog(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: Text("Change Field Position"),
                      titlePadding: EdgeInsets.all(16.0),
                      contentPadding: EdgeInsets.all(16.0),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            OutlineDropdownButton(
                              items: globals.fieldPositions,
                              onChanged: _changeFieldPosition,
                              hint: Text(
                                  "${widget.playerSnap['FieldPosition']}"),
                              value: position,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.black,
                ),
                onPressed: () => Firestore.instance.runTransaction(
                  (transaction) async {
                    globals.selectedPlayerName = "${widget.playerSnap['PlayerName']}";
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                            "Remove ${widget.playerSnap['PlayerName']} from your team?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                          FlatButton(
                            onPressed: () {
                              // Delete player from database
                              teamCollection
                                  .document(globals.selectedPlayerName)
                                  .delete();
                              Navigator.pop(context);
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
