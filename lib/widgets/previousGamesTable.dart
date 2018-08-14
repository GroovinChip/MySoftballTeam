import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/editGameModal.dart';

class PreviousGamesTable extends StatefulWidget {
  @override
  _PreviousGamesTableState createState() => _PreviousGamesTableState();
}

class _PreviousGamesTableState extends State<PreviousGamesTable> {

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Games"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: globals.gamesDB.snapshots(),
        builder: (context, snapshot){
          List<Widget> gameCards = [];
          if(snapshot.hasData == false) {
            return Center(child: Text("No Games Found"));
          } else {
            List<DocumentSnapshot> games = snapshot.data.documents;

            games.sort((a, b){
              DateTime game1 = globals.convertStringDateToDateTime(a['GameDate'], a['GameTime']);
              DateTime game2 = globals.convertStringDateToDateTime(b['GameDate'], b['GameTime']);
              return game1.compareTo(game2);
            });

            for(int index = 0; index < games.length; index++){
              // Check each game date - if the date is before today, create a row
              DateTime gameDate = globals.convertStringDateToDateTime("${games[index]['GameDate']}", "${games[index]['GameTime']}");
              if(gameDate.isBefore(today) == false){
                // do not create a Game row
              } else {
                switch("${games[index]['HomeOrAway']}"){
                  case "Home":
                    gameCards.add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0, top: 8.0, right: 8.0),
                                child: Text(
                                  globals.teamName + " VS " + "${games[index]['OpposingTeam']}",
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
                                child: Text(
                                    "${games[index]['GameTime']}" + " on " + "${games[index]['GameDate']}"
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                    "${games[index]['GameLocation']}"
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.delete_forever),
                                    tooltip: "Delete game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      showDialog(
                                          context: context,
                                          builder: (_) => SimpleDialog(
                                            title: Text("Delete Game"),
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: ListTile(
                                                  title: Text("Are you sure you want to remove this game from the schedule?"),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Text("No"),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      onPressed: (){
                                                        globals.gamesDB.document(globals.selectedGameDocument).delete();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    tooltip: "Edit game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).push(MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return EditGameModal();
                                          },
                                          fullscreenDialog: true
                                      ));
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.email_variant),
                                    tooltip: "Send game reminder",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).pushNamed('/SendGameReminderEmailScreen');
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.gamepad),
                                    tooltip: "Play game",
                                    onPressed: (){

                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    break;
                  case "Away":
                    gameCards.add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0, top: 8.0, right: 8.0),
                                child: Text(
                                  "${games[index]['OpposingTeam']}" + " VS " + globals.teamName,
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
                                child: Text(
                                    "${games[index]['GameTime']}" + " on " + "${games[index]['GameDate']}"
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                    "${games[index]['GameLocation']}"
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.delete_forever),
                                    tooltip: "Delete game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      showDialog(
                                          context: context,
                                          builder: (_) => SimpleDialog(
                                            title: Text("Delete Game"),
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: ListTile(
                                                  title: Text("Are you sure you want to remove this game from the schedule?"),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Text("No"),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      onPressed: (){
                                                        globals.gamesDB.document(globals.selectedGameDocument).delete();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    tooltip: "Edit game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).push(MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return EditGameModal();
                                          },
                                          fullscreenDialog: true
                                      ));
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.email_variant),
                                    tooltip: "Send game reminder",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).pushNamed('/SendGameReminderEmailScreen');
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.gamepad),
                                    tooltip: "Play game",
                                    onPressed: (){

                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    break;
                  case "Bye":
                    gameCards.add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0, top: 8.0, right: 8.0),
                                child: Text(
                                  "${games[index]['OpposingTeam']}",
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
                                child: Text(
                                    "${games[index]['GameTime']}" + " on " + "${games[index]['GameDate']}"
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                    "${games[index]['GameLocation']}"
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.delete_forever),
                                    tooltip: "Delete game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      showDialog(
                                          context: context,
                                          builder: (_) => SimpleDialog(
                                            title: Text("Delete Game"),
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: ListTile(
                                                  title: Text("Are you sure you want to remove this game from the schedule?"),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Text("No"),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      onPressed: (){
                                                        globals.gamesDB.document(globals.selectedGameDocument).delete();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    tooltip: "Edit game",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).push(MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return EditGameModal();
                                          },
                                          fullscreenDialog: true
                                      ));
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.email_variant),
                                    tooltip: "Send game reminder",
                                    onPressed: (){
                                      globals.selectedGameDocument = games[index].documentID;
                                      Navigator.of(context).pushNamed('/SendGameReminderEmailScreen');
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(CommunityMaterialIcons.gamepad),
                                    tooltip: "Play game",
                                    onPressed: (){

                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    break;
                }
              }
            }

            return ListView.builder(
              itemCount: gameCards.length,
              itemBuilder: (context, index){
                return gameCards[index];
              },
            );
          }
        },
      ),
    );
  }
}
