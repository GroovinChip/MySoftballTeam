import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_softball_team/widgets/seasonSchedule.dart';
import 'package:my_softball_team/widgets/teamList.dart';
import 'package:my_softball_team/widgets/statsTable.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:community_material_icon/community_material_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // List of bottom navigation bar items
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(CommunityMaterialIcons.calendar_text),
      title: Text("Schedule"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      title: Text("Team"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.insert_chart),
      title: Text("Stats"),
    ),
  ];

  int _page = 0; // tracks what page is currently in view
  PageController _pageController;

  // Navigate pages based on bottom navigation bar item tap
  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  // Track which page is in view
  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // List of FloatingActionButtons to show only on 'Games' and 'Team' pages
    List<Widget> _fabs = [
      FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/AddNewGame');
        },
        icon: Icon(Icons.add),
        label: Text("Add a Game"),
      ),
      FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/AddNewPlayer');
        },
        icon: Icon(Icons.add),
        label: Text("Add a Player"),
      ),
      Container()
    ];

    CollectionReference usersDB = Firestore.instance.collection("Users");

    List<PopupMenuItem> oveflowMenuItems = [
      PopupMenuItem(
        child: Text("View Previous Games"),
        value: "VPG",
      ),
      PopupMenuItem(
        child: Text("Log Out"),
        value: "LO",
      ),
    ];

    void onSelectOverflowMenuItem(item) async {
      switch(item){
        case "VPG":
          Navigator.of(context).pushNamed('/PreviousGamesTable');
          break;
        case "LO":
          FirebaseAuth.instance.signOut();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("Email", "");
          prefs.setString("Password", "");
          Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage',(Route<dynamic> route) => false);
          break;
      }
    }

    return Scaffold (
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.white,
        title: StreamBuilder<List<QuerySnapshot>>(
          stream: StreamZip([usersDB.snapshots(), globals.gamesDB.snapshots()]),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final usersStream = snapshot.data[0];
              final gamesStream = snapshot.data[1];
              List<DocumentSnapshot> users = usersStream.documents;
              List<DocumentSnapshot> games = gamesStream.documents;
              int wins = 0;
              int losses = 0;

              for(int index = 0; index < users.length; index++) {
                if (users[index].documentID == globals.loggedInUser.uid) {
                  DocumentSnapshot team = users[index];
                  globals.teamName = "${team['Team']}";

                  for(int index2 = 0; index2 < games.length; index2++) {
                    DocumentSnapshot game = games[index2];
                    String winOrLoss = "${game['WinOrLoss']}";
                    if(winOrLoss  == null){

                    } else if(winOrLoss == "Unknown") {

                    } else if(winOrLoss == "Win") {
                      wins += 1;
                    } else if(winOrLoss == "Loss") {
                      losses += 1;
                    }
                  }

                  return Text(
                    globals.teamName + " " + wins.toString() + " - " + losses.toString(),
                    style: TextStyle(
                      color: Colors.black
                    ),
                  );
                }
              }
            } else {
              return Text(
                "MySoftballTeam",
                style: TextStyle(
                  color: Colors.black
                ),
              );
            }

          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (builder){
              return oveflowMenuItems;
            },
            onSelected: onSelectOverflowMenuItem,
          )
        ],
      ),
      body: PageView(
        children: <Widget>[
          SeasonSchedule(),
          TeamList(),
          StatsTable()
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: _fabs[_page],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _page,
        onTap: navigationTapped,
      ),
    );
  }
}
