import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('Team').snapshots(),
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
                          new Row(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0,
                                    top: 16.0,
                                    bottom: 16.0),
                                child: new Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new FlatButton(
                                      child: new Text("Update Stats"),
                                      onPressed: () {},
                                    ),
                                    new FlatButton(
                                      child:
                                      new Text("Change Position"),
                                      onPressed: () {},
                                    ),
                                    new FlatButton(
                                      child: new Text(
                                          "Remove Player From Team"),
                                      onPressed: () => Firestore.instance.runTransaction((transaction) async {
                                        // Delete player from database
                                        CollectionReference team = Firestore.instance.collection('Team');
                                        await transaction.delete(ds.reference);
                                        Navigator.pop(context);
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

