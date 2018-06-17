import 'package:flutter/material.dart';
import 'package:my_softball_team/screens/addNewGame.dart';
import 'package:my_softball_team/screens/addNewPlayer.dart';
import 'package:my_softball_team/screens/homeScreen.dart';
import 'package:my_softball_team/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Softball Team',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/HomeScreen':(BuildContext context) => new HomeScreen(),
        '/Signup':(BuildContext context) => new Signup(),
        '/AddNewGame':(BuildContext context) => new AddNewGame(),
        '/AddNewPlayer':(BuildContext context) => new AddNewPlayer(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "MySoftballTeam",
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
                      /*new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("Login"),
                        ],
                      ),*/
                      new SizedBox(
                        height: 25.0,
                      ),
                      new TextField(
                        decoration: new InputDecoration(
                          icon: new Icon(Icons.account_circle),
                          labelText: "Username",
                        ),
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
                      ),
                      new SizedBox(
                        height: 50.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed: (){
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
                            child: new RaisedButton(
                                onPressed: (){
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/HomeScreen', (Route<dynamic> route) => false);
                                },
                                color: Colors.lightBlueAccent,
                                child: new Text(
                                  "Login",
                                  style: new TextStyle(
                                      color: Colors.white,
                                  ),
                                ),
                            ),
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
      ),
    );
  }
}
