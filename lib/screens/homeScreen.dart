import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_softball_team/widgets/seasonSchedule.dart';
import 'package:my_softball_team/widgets/teamList.dart';
import 'package:my_softball_team/widgets/statsTable.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Set initial package info
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  // Get and set the package details
  Future getPackageDetails() async{
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  // List of bottom navigation bar items
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(GroovinMaterialIcons.calendar_text),
      title: Text("Schedule"),
    ),
    BottomNavigationBarItem(
      icon: Icon(GroovinMaterialIcons.account_multiple_outline),
      title: Text("Team"),
    ),
    BottomNavigationBarItem(
      icon: Icon(OMIcons.assessment),
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
    getPackageDetails();
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

    return Scaffold (
      appBar: AppBar(
        //centerTitle: true,
        elevation: 2.0,
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
                    } else if(winOrLoss == "Tie") {

                    }
                  }

                  return Text(
                    globals.teamName + " (" + DateTime.now().year.toString() + ") " + wins.toString() + " - " + losses.toString(),
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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              showModalBottomSheet(
                context: context,
                builder: (builder){
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(OMIcons.accountCircle),
                          title: Text(globals.loggedInUser.email),
                        ),
                        Divider(
                          height: 0.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: Icon(Icons.history),
                          title: Text("View Previous Games"),
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/PreviousGamesTable');
                          },
                        ),
                        ListTile(
                          leading: Icon(OMIcons.email),
                          title: Text("Email List"),
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/EmailList');
                          },
                        ),
                        ListTile(
                          leading: Icon(GroovinMaterialIcons.logout),
                          title: Text("Log Out"),
                          onTap: () async {
                            FirebaseAuth.instance.signOut();
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("Email", "");
                            prefs.setString("Password", "");
                            Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage',(Route<dynamic> route) => false);
                          },
                        ),
                        Divider(
                          height: 0.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: Icon(OMIcons.info),
                          title: Text("MySoftballTeam by GroovinChip"),
                          subtitle: Text("Version " + _packageInfo.version),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.twitter, color: Colors.blue),
                              onPressed: (){
                                launch("https:twitter.com/GroovinChipDev");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.github_circle),
                              onPressed: (){
                                launch("https:github.com/GroovinChip");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.gmail),
                              color: Colors.red,
                              onPressed: (){
                                launch("mailto:groovinchip@gmail.com");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.discord, color: Colors.deepPurpleAccent),
                              onPressed: (){
                                launch("https://discord.gg/CFnBRue");
                              },
                            ),
                            /*IconButton(
                              icon: Icon(GroovinMaterialIcons.flutter),
                              color: Colors.blue,
                              onPressed: (){

                              },
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomNavigationBar(
            items: _bottomNavigationBarItems,
            currentIndex: _page,
            onTap: navigationTapped,
          ),
        ],
      ),
    );
  }
}
