import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/edit_game.dart';
import 'package:my_softball_team/widgets/game_card.dart';

class PreviousGamesList extends StatefulWidget {
  @override
  _PreviousGamesListState createState() => _PreviousGamesListState();
}

class _PreviousGamesListState extends State<PreviousGamesList> {

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text("Previous Games",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Teams").document(globals.teamName).collection("Seasons").document(DateTime.now().year.toString()).collection("Games").snapshots(),
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
                      gameLocation: "${games[index]['GameLocation']}",
                      isPreviousGame: true,
                    ),
                  ),
                );
              }
            }

            return gameCards.length > 0 ? ListView.builder(
              itemCount: gameCards.length,
              itemBuilder: (context, index){
                return gameCards[index];
              },
            ) :
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: Text("No previous games"),
              ),
            );
          }
        },
      ),
    );
  }
}
