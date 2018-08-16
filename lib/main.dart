import 'package:flutter/material.dart';
import 'package:my_softball_team/checkLogin.dart';
import 'package:my_softball_team/screens/addNewGame.dart';
import 'package:my_softball_team/screens/addNewPlayer.dart';
import 'package:my_softball_team/screens/sendGameReminderEmail.dart';
import 'package:my_softball_team/screens/setLineup.dart';
import 'package:my_softball_team/screens/signup.dart';
import 'package:my_softball_team/widgets/previousGamesTable.dart';
import 'package:my_softball_team/widgets/seasonSchedule.dart';
import 'package:my_softball_team/screens/homeScreen.dart';
import 'package:my_softball_team/screens/login.dart';

void main() => runApp(new LoadApplication());

class LoadApplication extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Softball Team',
      theme: new ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'sourcesanspro'
      ),
      home: new CheckLogin(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new HomeScreen(),
        '/Signup': (BuildContext context) => new Signup(),
        '/AddNewGame': (BuildContext context) => new AddNewGame(),
        '/AddNewPlayer': (BuildContext context) => new AddNewPlayer(),
        '/SeasonSchedule': (BuildContext context) => new SeasonSchedule(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/PreviousGamesTable': (BuildContext context) => new PreviousGamesTable(),
        '/SendGameReminderEmailScreen': (BuildContext context) => new SendGameReminderEmailScreen(),
        '/SetLineup': (BuildContext context) => new SetLineupScreen()
      },
    );
  }
}