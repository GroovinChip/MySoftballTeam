import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/editGameModal.dart';

class GameCard extends StatelessWidget{
  String gameID;
  String homeOrAway;
  String teamName;
  String opposingTeam;
  String gameDate;
  String gameTime;
  String gameLocation;
  String fullText;

  GameCard({
    this.gameID,
    this.homeOrAway,
    this.teamName,
    this.opposingTeam,
    this.gameDate,
    this.gameTime,
    this.gameLocation
  });

  @override
  Widget build(BuildContext context) {
    switch (homeOrAway) {
      case "Home":
        fullText = teamName + " VS " + opposingTeam;
        break;
      case "Away":
        fullText = opposingTeam + " VS " + teamName;
        break;
      case "Bye":
        fullText = homeOrAway;
        break;
    }
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 6.0, top: 8.0),
            child: Text(
              fullText,
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
            child: Text(
                gameTime + " on " + gameDate
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
                gameLocation
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_forever),
                tooltip: "Delete game",
                onPressed: () {
                  globals.selectedGameDocument = gameID;
                  showDialog(
                      context: context,
                      builder: (_) =>
                          SimpleDialog(
                            title: Text("Delete Game"),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ListTile(
                                  title: Text(
                                      "Are you sure you want to remove this game from the schedule?"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        globals.gamesDB.document(
                                            globals.selectedGameDocument)
                                            .delete();
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
                onPressed: () {
                  globals.selectedGameDocument = gameID;
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new EditGameModal();
                      },
                      fullscreenDialog: true
                  ));
                },
              ),
              IconButton(
                icon: Icon(GroovinMaterialIcons.email_variant),
                tooltip: "Send game reminder",
                onPressed: () {
                  globals.selectedGameDocument = gameID;
                  Navigator.of(context).pushNamed(
                      '/SendGameReminderEmailScreen');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(GroovinMaterialIcons.baseball_bat),
                  tooltip: "Play game",
                  onPressed: () {

                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
