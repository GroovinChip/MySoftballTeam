import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  // Controllers
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  // Variables
  var email;
  var password;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue,
      body: new Center(
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: ()async {
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

                              final firebaseUser = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(email: email, password: password);

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
      )
    );
  }
}
