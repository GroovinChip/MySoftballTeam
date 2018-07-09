import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_softball_team/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/screens/login.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {

  void _checkLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.get("Email");
    String password = prefs.get("Password");
    String teamName = prefs.get("TeamName");
    if(email.isEmpty || email == ""){
      if(password.isEmpty || password == ""){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
      }
    } else {
      try {
        final firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        globals.loggedInUser = firebaseUser;
        if(globals.loggedInUser.isEmailVerified == true) {
          globals.teamName = teamName;
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new HomeScreen()));
        } else {
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
        }
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
    return Center(child: CircularProgressIndicator());
  }
}