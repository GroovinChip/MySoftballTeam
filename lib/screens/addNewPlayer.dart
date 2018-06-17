import 'package:flutter/material.dart';

class AddNewPlayer extends StatefulWidget{
  @override
  _AddNewPlayerState createState() => new _AddNewPlayerState();
}

class _AddNewPlayerState extends State<AddNewPlayer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Player"),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                            icon: new Icon(Icons.person),
                            labelText: "Player Name",
                          ),
                        ),
                        new SizedBox(
                          height: 25.0,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                            icon: new Icon(Icons.location_on),
                            labelText: "Field Position",
                          ),
                        ),
                        new SizedBox(
                          height: 15.0,
                        ),
                        new ExpansionTile(
                          title: new Text("Initial Stats (Optional)"),
                          children: <Widget>[
                            new ListTile(
                              title: new Text("Games Played"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                            new ListTile(
                              title: new Text("At Bats"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                            new ListTile(
                              title: new Text("Base Hits"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                            new ListTile(
                              title: new Text("Outs Received"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                            new ListTile(
                              title: new Text("Assists"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                            new ListTile(
                              title: new Text("Outs Fielded"),
                              subtitle: new SizedBox(
                                  width: 75.0,
                                  child: new TextField()),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new RaisedButton(
                              onPressed: (){

                              },
                              color: Colors.blue,
                              child: new Text(
                                "Save",
                                style: new TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              splashColor: Colors.lightBlueAccent,
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
    );
  }
}
