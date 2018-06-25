import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  // Controllers
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _teamNameController = new TextEditingController();

  // Variables
  var name;
  var email;
  var password;
  var _team;
  var list;

  // Set team on DropdownButton tap
  void _chooseTeam(value) {
    setState(() {
      _team = value;
    });
  }

  void _saveValuesToStorage(String teamName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("TeamName", teamName);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue,
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Create Account",
                  style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.white
                  ),
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
                            height: 10.0,
                          ),
                          new TextField(
                            decoration: new InputDecoration(
                              icon: new Icon(Icons.person),
                              labelText: "*Name",
                            ),
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new TextField(
                            decoration: new InputDecoration(
                              icon: new Icon(Icons.email),
                              labelText: "*Email Address",
                            ),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new TextField(
                            decoration: new InputDecoration(
                              icon: new Icon(Icons.lock),
                              labelText: "*Password",
                            ),

                            obscureText: true,
                            controller: _passwordController,
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new Row(
                            children: <Widget>[
                              new Icon(Icons.group, color: Colors.black45,),
                              new SizedBox(
                                width: 1.0,
                              ),
                              new SizedBox(
                                width: 15.0,
                              ),
                              new StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance.collection("Teams").snapshots(),
                                builder: (context, snapshot){

                                  // Check if the snapshot is null
                                  if (snapshot.data == null) {
                                    return new CircularProgressIndicator();
                                  }

                                  // Return a dropdownbutton with all the teams from the database
                                  return new DropdownButton(
                                    items: snapshot.data.documents.map((DocumentSnapshot document) {
                                      return DropdownMenuItem(child: new Text(document.documentID), value: document.documentID);
                                    }).toList(),
                                    onChanged: _chooseTeam,
                                    hint: new Text("Join a Team"),
                                    value: _team
                                  );
                                }
                              ),
                              new SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new RaisedButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) => SimpleDialog(
                                      title: new Text("Add Your Team"),
                                      children: <Widget>[
                                        new Column(
                                          children: <Widget>[
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Icon(Icons.group, color: Colors.black45,),
                                                new Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: new SizedBox(
                                                    width: 200.0,
                                                    child: new TextField(
                                                      decoration: new InputDecoration(
                                                        hintText: "Team Name"
                                                      ),
                                                      controller: _teamNameController,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            new SizedBox(
                                              height: 25.0,
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Padding(
                                                  padding: const EdgeInsets.only(right: 22.0),
                                                  child: new StreamBuilder<QuerySnapshot>(
                                                    stream: Firestore.instance.collection("Teams").snapshots(),
                                                    builder: (context, snapshot) {
                                                      // Check if the snapshot is null
                                                      if (snapshot.data == null) {
                                                        return new CircularProgressIndicator();
                                                      }

                                                      return new RaisedButton(
                                                        onPressed: () async {
                                                          globals.teamTame = _teamNameController.text; // add team name to globals
                                                          //_saveValuesToStorage(globals.teamTame);
                                                          // Add team name to database
                                                          if (globals.teamTame != "") {
                                                            CollectionReference team = Firestore.instance.collection("Teams");
                                                            team.document(globals.teamTame).setData({"TeamName":globals.teamTame});
                                                            Navigator.pop(context);
                                                          } else {

                                                          }
                                                        },
                                                        color: Colors.blue,
                                                        child: new Text("Add Team",
                                                          style: new TextStyle(
                                                              color: Colors
                                                                  .white),),
                                                      );
                                                    }
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  );
                                },
                                child: new Text("I don't see my team", style: new TextStyle(color: Colors.white),),
                                color: Colors.deepOrangeAccent,
                              ),
                              new RaisedButton( // Create Account button
                                onPressed: () async {
                                  email = _emailController.text;
                                  password = _passwordController.text;

                                  if(email == '' || password == ''){
                                    _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          duration: new Duration(seconds: 2),
                                          content:
                                          new Row(
                                            children: <Widget>[
                                              new Icon(Icons.error),
                                              new Text("  Please enter required fields")
                                            ],
                                          ),
                                        )
                                    );
                                  }
                                  
                                  name = _nameController.text;

                                  // create the user
                                  final firebaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                                  
                                  // add the user to the database
                                  CollectionReference usersDB = Firestore.instance.collection("Users");
                                  usersDB.document(firebaseUser.uid).setData({"Name":name, "Email":firebaseUser.email, "Team":_team});

                                  // Add user to globals
                                  globals.loggedInUser = firebaseUser;

                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                        duration: new Duration(seconds: 2),
                                        content:
                                        new Row(
                                          children: <Widget>[
                                            new CircularProgressIndicator(),
                                            new Text("    Creating Account...")
                                          ],
                                        ),
                                      )
                                  );

                                  firebaseUser.sendEmailVerification();

                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                        duration: new Duration(seconds: 2),
                                        content:
                                        new Row(
                                          children: <Widget>[
                                            new CircularProgressIndicator(),
                                            new Text("    Sending Verification Email...")
                                          ],
                                        ),
                                      )
                                  );

                                  await new Future.delayed(const Duration(seconds : 3));

                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                        duration: new Duration(seconds: 3),
                                        content:
                                        new Row(
                                          children: <Widget>[
                                            new CircularProgressIndicator(),
                                            new Text("    Logging In...")
                                          ],
                                        ),
                                      )
                                  );

                                  await new Future.delayed(const Duration(seconds : 3));
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/HomeScreen', (Route<dynamic> route) => false);
                                },
                                color: Colors.lightBlueAccent,
                                child: new Text(
                                  "Create Account",
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
