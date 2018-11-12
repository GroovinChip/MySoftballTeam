import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Variables
  var email;
  var password;
  String teamName;
  bool isChecked = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: globals.usersDB.snapshots(),
            builder: (context, snapshot) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "MySoftballTeam",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 25.0,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: "Email Address",
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: "Password",
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                                controller: _passwordController,
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/Signup');
                                    },
                                    color: Colors.indigoAccent,
                                    child: Text(
                                      "Create Account",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Builder(
                                      builder: (BuildContext loginButtonContext) {
                                        return RaisedButton(
                                          onPressed: () async {
                                            email = _emailController.text;
                                            password = _passwordController.text;

                                            // try to sign in using the user's credentials
                                            try {
                                              final firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                                              if (firebaseUser.isEmailVerified == true) {
                                                _scaffoldKey.currentState.showSnackBar(
                                                  SnackBar(
                                                    duration: Duration(seconds: 2),
                                                    content:
                                                    Row(
                                                      children: <Widget>[
                                                        CircularProgressIndicator(),
                                                        Text("    Signing-In...")
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

                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString("Team", globals.teamName);

                                                await Future.delayed(const Duration(seconds : 2));
                                                Navigator.of(context).pushNamedAndRemoveUntil('/HomeScreen',(Route<dynamic> route) => false);
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => SimpleDialog(
                                                      title: Text(
                                                          "Your email address is not verified"),
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
                                                              child: Text(
                                                                  "Would you like another verificaion email sent?"),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child:
                                                                Text("No")),
                                                            FlatButton(
                                                                onPressed: () {
                                                                  firebaseUser.sendEmailVerification();
                                                                  Navigator.pop(context);
                                                                },
                                                                child:
                                                                Text("Yes")
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              }
                                            } catch (e) {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    "Email or Password not found, please try again."),
                                                action: SnackBarAction(
                                                  label: 'Dismiss',
                                                  onPressed: () {},
                                                ),
                                                duration: Duration(seconds: 3),
                                              );
                                              Scaffold
                                                  .of(loginButtonContext)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          color: Colors.indigoAccent,
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
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
