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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _teamNameController = TextEditingController();

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white
                  ),
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
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "*Name",
                              border: OutlineInputBorder(),
                            ),
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "*Email Address",
                              border: OutlineInputBorder(),
                            ),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              labelText: "*Password",
                            ),

                            obscureText: true,
                            controller: _passwordController,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.group, color: Colors.black45,),
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance.collection("Teams").snapshots(),
                                  builder: (context, snapshot){

                                    // Check if the snapshot is null
                                    if (snapshot.data == null) {
                                      return CircularProgressIndicator();
                                    }

                                    // Return a dropdownbutton with all the teams from the database
                                    return DropdownButton(
                                      items: snapshot.data.documents.map((DocumentSnapshot document) {
                                        return DropdownMenuItem(child: Text(document.documentID), value: document.documentID);
                                      }).toList(),
                                      onChanged: _chooseTeam,
                                      hint: Text("Join a Team"),
                                      value: _team,
                                      isExpanded: true,
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) => SimpleDialog(
                                      title: Text("Add Your Team"),
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.group, color: Colors.black45,),
                                                  labelText: "Team Name",
                                                  border: OutlineInputBorder(),
                                                ),
                                                controller: _teamNameController,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 22.0),
                                                  child: StreamBuilder<QuerySnapshot>(
                                                    stream: Firestore.instance.collection("Teams").snapshots(),
                                                    builder: (context, snapshot) {
                                                      // Check if the snapshot is null
                                                      if (snapshot.data == null) {
                                                        return CircularProgressIndicator();
                                                      }

                                                      return RaisedButton(
                                                        onPressed: () async {
                                                          globals.teamName = _teamNameController.text; // add team name to globals
                                                          //_saveValuesToStorage(globals.teamTame);
                                                          // Add team name to database
                                                          if (globals.teamName != "") {
                                                            CollectionReference team = Firestore.instance.collection("Teams");
                                                            team.document(globals.teamName).setData({"TeamName":globals.teamName});
                                                            Navigator.pop(context);
                                                          } else {

                                                          }
                                                        },
                                                        color: Colors.indigoAccent,
                                                        child: Text("Add Team",
                                                          style: TextStyle(
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
                                child: Text("I don't see my team",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.purpleAccent,
                              ),
                              RaisedButton( // Create Account button
                                onPressed: () async {
                                  email = _emailController.text;
                                  password = _passwordController.text;

                                  if(email == '' || password == ''){
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content:
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.error),
                                            Text("  Please enter required fields")
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
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content:
                                      Row(
                                        children: <Widget>[
                                          CircularProgressIndicator(),
                                          Text("    Creating Account...")
                                        ],
                                      ),
                                    )
                                  );

                                  firebaseUser.sendEmailVerification();

                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content:
                                        Row(
                                          children: <Widget>[
                                            CircularProgressIndicator(),
                                            Text("    Sending Verification Email...")
                                          ],
                                        ),
                                      )
                                  );

                                  await Future.delayed(const Duration(seconds : 3));

                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 3),
                                      content:
                                      Row(
                                        children: <Widget>[
                                          CircularProgressIndicator(),
                                          Text("    Logging In...")
                                        ],
                                      ),
                                    )
                                  );

                                  await Future.delayed(const Duration(seconds : 3));
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/HomeScreen', (Route<dynamic> route) => false);
                                },
                                color: Colors.indigoAccent,
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
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
