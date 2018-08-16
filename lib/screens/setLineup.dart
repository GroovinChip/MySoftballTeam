import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:my_softball_team/globals.dart' as globals;

class SetLineupScreen extends StatefulWidget {
  @override
  _SetLineupScreenState createState() => _SetLineupScreenState();
}

class _SetLineupScreenState extends State<SetLineupScreen> {
  
  List<DropdownMenuItem> players = [
    /*DropdownMenuItem(
      child: Text("Choose a Player"),
    ),*/
  ];
  var selectedPlayer;

  void _chooseBatter(value) {
    setState(() {
      selectedPlayer = value;
      print(selectedPlayer);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Set Lineup",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: globals.teamPlayersDB.snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData == false) {
            return Center();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (builder, index){
                DocumentSnapshot player = snapshot.data.documents[index];
                players.add(
                  DropdownMenuItem(
                    child: Text("${player['PlayerName']}"),
                    value: "${player['PlayerName']}",
                  ),
                );
                index += 1;
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text("Batter # " + index.toString()),
                      title: DropdownButton(
                        items: players,
                        onChanged: _chooseBatter,
                        value: selectedPlayer,
                        hint: Text("Choose a Player"),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(GroovinMaterialIcons.baseball),
        label: Text("Play Ball!"),
        onPressed: (){

        },
      ),
    );
  }
}
