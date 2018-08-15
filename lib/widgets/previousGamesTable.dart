import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/editGameModal.dart';
import 'package:my_softball_team/widgets/gameCard.dart';

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
              // Check each game date - if the date is before today, create a GameCard
              DateTime gameDate = globals.convertStringDateToDateTime("${games[index]['GameDate']}", "${games[index]['GameTime']}");
              if(gameDate.isBefore(today) == false){
                // do not create a GameCard
              } else {
                gameCards.add(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GameCard(
                        gameID: games[index].documentID,
                        homeOrAway: "${games[index]['HomeOrAway']}",
                        teamName: globals.teamName,
                        opposingTeam: "${games[index]['OpposingTeam']}",
                        gameTime: "${games[index]['GameTime']}",
                        gameDate: "${games[index]['GameDate']}",
                        gameLocation: "${games[index]['GameLocation']}"
                    ),
                  ),
                );
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
