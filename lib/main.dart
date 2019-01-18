import 'package:flutter/material.dart';
import 'package:my_softball_team/check_login.dart';
import 'package:my_softball_team/screens/SeasonSchedule/add_new_game.dart';
import 'package:my_softball_team/screens/add_new_player.dart';
import 'package:my_softball_team/screens/emailList.dart';
import 'package:my_softball_team/screens/setLineup.dart';
import 'package:my_softball_team/screens/signup.dart';
import 'package:my_softball_team/widgets/previous_games_list.dart';
import 'package:my_softball_team/screens/SeasonSchedule/season_schedule.dart';
import 'package:my_softball_team/screens/home_screen.dart';
import 'package:my_softball_team/screens/login.dart';

void main() => runApp(MySoftballTeam());

class MySoftballTeam extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Softball Team',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: 'sourcesanspro',
      ),
      home: CheckLogin(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => HomeScreen(),
        '/Signup': (BuildContext context) => Signup(),
        '/AddNewGame': (BuildContext context) => AddNewGame(),
        '/AddNewPlayer': (BuildContext context) => AddNewPlayer(),
        '/SeasonSchedule': (BuildContext context) => SeasonSchedule(),
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/PreviousGamesTable': (BuildContext context) => PreviousGamesList(),
        '/EmailList': (BuildContext context) => EmailList(),
        '/SetLineup': (BuildContext context) => SetLineupScreen(),
      },
    );
  }
}