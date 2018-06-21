import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    new BottomNavigationBarItem(
        icon: new Icon(Icons.gamepad), title: new Text("Games")),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.group), title: new Text("Team")),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.poll), title: new Text("Stats")),
  ];

  int _page = 0;
  PageController _pageController;

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _fabs = [
      new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/AddNewGame');
        },
        child: new Icon(Icons.add),
      ),
      new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/AddNewPlayer');
        },
        child: new Icon(Icons.add),
      ),
      new Container()
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Team"),
      ),
      body: new PageView(
        children: <Widget>[
          new Center(
            child: new Text("Softball Games will go here"),
          ),
          new StreamBuilder(
            stream: Firestore.instance.collection('Team').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  /*padding: const EdgeInsets.only(top: 10.0),
                  itemExtent: 25.0,*/
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    //return new Text(" ${ds['PlayerName']} ${ds['FieldPosition']}");
                    return new ListTile(
                      leading: new CircleAvatar(
                        child: new Text("${ds['PlayerName']}"[0]),
                      ),
                      title: new Text("${ds['PlayerName']}"),
                      subtitle: new Text("${ds['FieldPosition']}"),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                                  title: new Text(
                                      "Options for ${ds['PlayerName']} - ${ds['FieldPosition']}"),
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              left: 24.0,
                                              top: 16.0,
                                              bottom: 16.0),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new FlatButton(
                                                child: new Text("Update Stats"),
                                                onPressed: () {},
                                              ),
                                              new FlatButton(
                                                child:
                                                    new Text("Change Position"),
                                                onPressed: () {},
                                              ),
                                              new FlatButton(
                                                child: new Text(
                                                    "Remove Player From Team"),
                                                onPressed: () => Firestore.instance.runTransaction((transaction) async {
                                                  CollectionReference team = Firestore.instance.collection('Team');
                                                  await transaction.delete(ds.reference);
                                                  Navigator.pop(context);
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*new Row(
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

                                          Navigator.pop(context);
                                        },
                                        child:
                                        new Text("Yes")
                                    ),
                                  ],
                                )*/
                                  ],
                                ));
                      },
                    );
                  });
            },
          ),
          new Center(
            child: new Text("Stats will go here"),
          )
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      floatingActionButton: _fabs[_page], // T
      bottomNavigationBar: new BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _page,
        onTap: navigationTapped,
      ),
    );
  }
}
