import 'package:flutter/material.dart';
import 'package:my_softball_team/checkLogin.dart';
import 'package:my_softball_team/screens/addNewGame.dart';
import 'package:my_softball_team/screens/addNewPlayer.dart';
import 'package:my_softball_team/screens/emailList.dart';
import 'package:my_softball_team/screens/sendGameReminderEmail.dart';
import 'package:my_softball_team/screens/setLineup.dart';
import 'package:my_softball_team/screens/signup.dart';
import 'package:my_softball_team/widgets/previousGamesTable.dart';
import 'package:my_softball_team/widgets/seasonSchedule.dart';
import 'package:my_softball_team/screens/homeScreen.dart';
import 'package:my_softball_team/screens/login.dart';

void main() => runApp(LoadApplication());

class LoadApplication extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Softball Team',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'sourcesanspro'
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
        '/PreviousGamesTable': (BuildContext context) => PreviousGamesTable(),
        '/SendGameReminderEmailScreen': (BuildContext context) => SendGameReminderEmailScreen(),
        '/EmailList': (BuildContext context) => EmailList(),
        '/SetLineup': (BuildContext context) => SetLineupScreen()
      },
    );
  }
}