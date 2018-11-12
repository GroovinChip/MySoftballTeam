import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_softball_team/screens/home_screen.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {

  void _checkLoginState() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      globals.loggedInUser = user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String teamName = prefs.getString("Team");
      if(teamName != null || teamName != "")
        globals.teamName = teamName;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } else {
      try {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()));
  }
}