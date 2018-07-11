import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controllers
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  // Variables
  var email;
  var password;
  String teamName;
  bool isChecked = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _rememberLogin() async {
    if(isChecked == true){
      print(globals.loggedInUser);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Email", email);
      prefs.setString("Password", password);
      prefs.setString("TeamName", globals.teamName);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: new StreamBuilder<QuerySnapshot>(
            stream: globals.usersDB.snapshots(),
            builder: (context, snapshot) {
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "MySoftballTeam",
                      style: new TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    new SizedBox(
                      height: 25.0,
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Card(
                        elevation: 4.0,
                        child: new Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new SizedBox(
                                height: 25.0,
                              ),
                              new TextField(
                                decoration: new InputDecoration(
                                  icon: new Icon(Icons.email),
                                  labelText: "Email Address",
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                              ),
                              new SizedBox(
                                height: 25.0,
                              ),
                              new TextField(
                                decoration: new InputDecoration(
                                  icon: new Icon(Icons.lock),
                                  labelText: "Password",
                                ),
                                obscureText: true,
                                controller: _passwordController,
                              ),
                              new SizedBox(
                                height: 25.0,
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new Text("Remember Me"),
                                  new Checkbox(
                                    value: isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              new SizedBox(
                                height: 25.0,
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/Signup');
                                    },
                                    color: Colors.lightBlueAccent,
                                    child: new Text(
                                      "Create Account",
                                      style: new TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: new Builder(
                                        builder: (BuildContext loginButtonContext) {
                                          return new RaisedButton(
                                            onPressed: () async {
                                              email = _emailController.text;
                                              password = _passwordController.text;

                                              // try to sign in using the user's credentials
                                              try {
                                                final firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                                                if (firebaseUser.isEmailVerified == true) {
                                                  _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(
                                                        duration: new Duration(seconds: 2),
                                                        content:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("    Signing-In...")
                                                          ],
                                                        ),
                                                      )
                                                  );
                                                  globals.loggedInUser = firebaseUser; // add user to globals

                                                  List<DocumentSnapshot> users = snapshot.data.documents;
                                                  for(int index = 0; index < users.length; index++) {
                                                    if (users[index].documentID == globals.loggedInUser.uid) {
                                                      DocumentSnapshot team = users[index];
                                                      globals.teamName = "${team['Team']}";
                                                    }
                                                  }

                                                  _rememberLogin();

                                                  await new Future.delayed(const Duration(seconds : 2));
                                                  Navigator.of(context).pushNamedAndRemoveUntil('/HomeScreen',(Route<dynamic> route) => false);
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => SimpleDialog(
                                                        title: new Text(
                                                            "Your email address is not verified"),
                                                        children: <Widget>[
                                                          new Row(
                                                            children: <Widget>[
                                                              new Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
                                                                child: new Text(
                                                                    "Would you like another verificaion email sent?"),
                                                              )
                                                            ],
                                                          ),
                                                          new Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child:
                                                                  new Text("No")),
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                    firebaseUser.sendEmailVerification();
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child:
                                                                  new Text("Yes")
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ));
                                                }
                                              } catch (e) {
                                                final snackBar = new SnackBar(
                                                  content: new Text(
                                                      "Email or Password not found, please try again."),
                                                  action: SnackBarAction(
                                                    label: 'Dismiss',
                                                    onPressed: () {},
                                                  ),
                                                  duration: new Duration(seconds: 3),
                                                );
                                                Scaffold
                                                    .of(loginButtonContext)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            color: Colors.lightBlueAccent,
                                            child: new Text(
                                              "Login",
                                              style: new TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
