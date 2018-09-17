import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:my_softball_team/globals.dart' as globals;

class SetLineupScreen extends StatefulWidget {
  @override
  _SetLineupScreenState createState() => _SetLineupScreenState();
}

class _SetLineupScreenState extends State<SetLineupScreen> {
  
  List<DropdownMenuItem> players = [];
  List<String> lineup = [];
  var selectedPlayer;

  /*void _chooseBatter(value) {
    setState(() {
      selectedPlayer = value;
      print(selectedPlayer);
    });
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
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
                //Key dropdownKey;
                //Key(index.toString());
                players.add(
                  DropdownMenuItem(
                    child: Text("${player['PlayerName']}"),
                    value: "${player['PlayerName']}",
                  ),
                );
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text("Batter #" + (index+1).toString()),
                      title: (!players.any((item) => item.value == "${player['PlayerName']}")) ? DropdownButton(
                        items: players,
                        onChanged: (player) {
                          /*if(lineup.isEmpty){
                            setState(() {
                              lineup.add(player);
                              selectedPlayer = player;
                            });
                          } else if(lineup.contains(player) == false){
                            setState(() {
                              lineup.insert(index, player);
                              selectedPlayer = player;
                            });
                          } else {
                            setState(() {
                              lineup.removeAt(index);
                              lineup.insert(index, player);
                              selectedPlayer = player;
                            });
                          }*/
                          //print("Batter #" + index.toString() + " is " + "${player['PlayerName']}");
                        },
                        value: selectedPlayer,
                        hint: Text("Choose a Player"),
                      ) : DropdownButton(
                          items: players,
                          onChanged: (player){
                            setState(() {
                              selectedPlayer = player;;
                              print(selectedPlayer);
                            });
                          },
                          value: selectedPlayer,
                          hint: Text("Choose a Player"),
                        ),
                      trailing: SizedBox(
                        width: 100.0,
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
