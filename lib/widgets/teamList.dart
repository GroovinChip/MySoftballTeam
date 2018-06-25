import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

CollectionReference teamCollection = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Players");


class _TeamListState extends State<TeamList> {

  var position;

// Set field position on DropdownButton tap
  void _changeFieldPosition(value) {
    setState(() {
      position = value;
      print(position);
      print(globals.selectedPlayerName);
      teamCollection.document(globals.selectedPlayerName).updateData({"FieldPosition":position});
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: teamCollection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            /*padding: const EdgeInsets.only(top: 10.0),
                  itemExtent: 25.0,*/
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              //return new Text(" ${ds['PlayerName']} ${ds['FieldPosition']}");
              return Column(
                children: <Widget>[
                  new ListTile(
                    leading: new CircleAvatar(
                      child: new Text("${ds['PlayerName']}"[0]),
                    ),
                    title: new Text("${ds['PlayerName']}"),
                    subtitle: new Text("${ds['FieldPosition']}"),
                    onTap: () {
                      globals.selectedPlayerName = "${ds['PlayerName']}";
                      showDialog(
                          context: context,
                          builder: (_) => SimpleDialog(
                            title: new Text(
                                "Options for ${ds['PlayerName']} - ${ds['FieldPosition']}"),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: new ListTile(
                                  leading: new Icon(Icons.poll),
                                  title: new Text("Update Stats"),
                                  onTap: (){},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: new ListTile(
                                  leading: new Icon(Icons.location_on),
                                  title: new Text("Change Field Position"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder){
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new ListTile(
                                                leading: new Icon(Icons.location_on),
                                                title: new DropdownButton(
                                                  items: globals.fieldPositions,
                                                  onChanged: _changeFieldPosition,
                                                  hint: new Text("${ds['FieldPosition']}"),
                                                  value: position),
                                                trailing: new SizedBox(width: 150.0),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: new ListTile(
                                  leading: new Icon(Icons.delete),
                                  title: new Text("Remove Player From Team"),
                                  onTap: () => Firestore.instance.runTransaction((transaction) async {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder){
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: new ListTile(
                                                  title: new Text("Are you sure you want to remove ${ds['PlayerName']} from your team?"),
                                                  subtitle: Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: new Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        new RaisedButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          child: new Text("No", style: new TextStyle(color: Colors.white)),
                                                          color: Colors.deepOrangeAccent,
                                                        ),
                                                        new RaisedButton(
                                                          onPressed: () {
                                                            // Delete player from database
                                                            teamCollection.document(globals.selectedPlayerName).delete();
                                                            Navigator.pop(context);
                                                          },
                                                          child: new Text("Yes", style: new TextStyle(color: Colors.white)),
                                                          color: Colors.blue,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                  new Divider(height: 1.0, color: Colors.black26,)
                ],
              );
            });
      },
    );
  }
}

