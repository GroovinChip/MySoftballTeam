import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    new BottomNavigationBarItem(icon: new Icon(Icons.gamepad), title: new Text("Games")),
    new BottomNavigationBarItem(icon: new Icon(Icons.group), title: new Text("Team")),
    new BottomNavigationBarItem(icon: new Icon(Icons.info), title: new Text("Stats")),
  ];



  int _page = 0;
  PageController _pageController;

  void navigationTapped(int page){
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  void _onPageChanged(int page) {
    setState((){
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
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
          new Center(child: new Text("Softball Games will go here"),),
          new Center(child: new Text("Team members will go here"),),
          new Center(child: new Text("Stats will go here"),)
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
