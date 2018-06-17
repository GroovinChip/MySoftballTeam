import 'package:flutter/material.dart';

class AddNewGame extends StatefulWidget{
  @override
  _AddNewGameState createState() => new _AddNewGameState();
}

class _AddNewGameState extends State<AddNewGame> {

  List<DropdownMenuItem> _homeOrAwayOptions = [
    new DropdownMenuItem(child: new Text("Home"), value: "Home",),
    new DropdownMenuItem(child: new Text("Away"), value: "Away",),
  ];

  void _chooseHomeOrAway(value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Game"),
      ),
      body: new SingleChildScrollView(
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
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("MyTeam"),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new Text("VS"),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new SizedBox(
                            width: 175.0,
                            child: new TextField(
                              decoration: new InputDecoration(
                                labelText: "Opposing Team",
                                icon: new Icon(Icons.group)
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new DropdownButton(
                            items: _homeOrAwayOptions,
                            onChanged: _chooseHomeOrAway,
                            hint: new Text("Choose Home or Away"),
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new SizedBox(
                            width: 150.0,
                            child: new TextField(
                              decoration: new InputDecoration(
                                labelText: "Game Number",
                                icon: new Icon(Icons.format_list_numbered)
                              ),
                            ),
                          ),
                          new SizedBox(
                            height: 25.0,
                          ),
                          new Divider(
                            color: Colors.grey,
                            height: 1.0,
                          ),
                        ],
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: new ExpansionTile(
                          title: new Text("Post Game Options"),
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: new Text("Score:"),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: new Text("MyTeam:"),
                                ),
                                new SizedBox(
                                  width: 100.0,
                                  child: new Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: new TextField(

                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: new Text("Opposing Team:"),
                                  ),
                                  new SizedBox(
                                    width: 100.0,
                                    child: new Padding(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: new TextField(

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
