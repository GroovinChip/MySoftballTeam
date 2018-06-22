import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

CollectionReference teamCollection = Firestore.instance.collection("Teams").document(globals.teamTame).collection("Players");

class _TeamListState extends State<TeamList> {
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
              return new ListTile(
                leading: new CircleAvatar(
                  child: new Text("${ds['PlayerName']}"[0]),
                ),
                title: new Text("${ds['PlayerName']}"),
                subtitle: new Text("${ds['FieldPosition']}"),
                onTap: () {
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
                              onTap: (){},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: new ListTile(
                              leading: new Icon(Icons.delete),
                              title: new Text("Remove Player From Team"),
                              onTap: (){},
                            ),
                          ),
                        ],
                      ));
                },
              );
            });
      },
    );
  }
}

