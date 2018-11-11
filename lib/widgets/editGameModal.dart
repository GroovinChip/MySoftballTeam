import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EditGameModal extends StatefulWidget {
  @override
  _EditGameModalState createState() => _EditGameModalState();
}

class _EditGameModalState extends State<EditGameModal> {

  List<DropdownMenuItem> _homeOrAwayOptions = [
    DropdownMenuItem(child: Text("Home"), value: "Home"),
    DropdownMenuItem(child: Text("Away"), value: "Away"),
    DropdownMenuItem(child: Text("Bye"), value: "Bye")
  ];

  TextEditingController _editGameDateController = TextEditingController();
  TextEditingController _editGameTimeController = TextEditingController();
  TextEditingController _editGameLocationController = TextEditingController();
  TextEditingController _editOpposingTeamController = TextEditingController();
  String year;
  String month;
  DateTime gameDate;
  TimeOfDay gameTime;
  String _homeOrAway;

  void _chooseHomeOrAway(value) {
    setState(() {
      _homeOrAway = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          "Edit Game",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: globals.gamesDB.snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData == true){
            List<DocumentSnapshot> games = snapshot.data.documents;
            for(int index = 0; index < games.length; index++) {
              if(games[index].documentID == globals.selectedGameDocument){
                DocumentSnapshot game = games[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Edit Game Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 185.0,
                                        child: TextField(
                                          controller: _editGameDateController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            labelText: "${game['GameDate']}",
                                            filled: true,
                                            fillColor: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        child: Text("Pick Game Date"),
                                        onPressed: () async {
                                          gameDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate:
                                              DateTime(DateTime.now().year,
                                                  DateTime.now().month, DateTime.now().day),
                                              lastDate: DateTime(DateTime.now().year, 12, 31)
                                          );
                                          year = gameDate.year.toString();
                                          switch(gameDate.month){
                                            case 1:
                                              month = "January";
                                              break;
                                            case 2:
                                              month = "February";
                                              break;
                                            case 3:
                                              month = "March";
                                              break;
                                            case 4:
                                              month = "April";
                                              break;
                                            case 5:
                                              month = "May";
                                              break;
                                            case 6:
                                              month = "June";
                                              break;
                                            case 7:
                                              month = "July";
                                              break;
                                            case 8:
                                              month = "August";
                                              break;
                                            case 9:
                                              month = "September";
                                              break;
                                            case 10:
                                              month = "October";
                                              break;
                                            case 11:
                                              month = "November";
                                              break;
                                            case 12:
                                              month = "December";
                                              break;
                                            default:
                                              break;
                                          }
                                          _editGameDateController.text = month + " " + gameDate.day.toString() + ", " + gameDate.year.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 185.0,
                                        child: TextField(
                                          controller: _editGameTimeController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            labelText: "${game['GameTime']}",
                                            filled: true,
                                            fillColor: Colors.black12,
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                          child: Text("Pick Game Time"),
                                          onPressed: () async {
                                            gameTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            _editGameTimeController.text = gameTime.format(context);
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _editOpposingTeamController,
                                    decoration: InputDecoration(
                                      labelText: "${game['OpposingTeam']}",
                                      /*fillColor: Colors.black12,
                                      filled: true,*/
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: (){
                                            _editOpposingTeamController.text = "";
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _editGameLocationController,
                                    decoration: InputDecoration(
                                        labelText: "${game['GameLocation']}",
                                        /*fillColor: Colors.black12,
                                        filled: true,*/
                                        border: OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: (){
                                              _editGameLocationController.text = "";
                                            })
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  DropdownButton(
                                    items: _homeOrAwayOptions,
                                    onChanged: _chooseHomeOrAway,
                                    hint: Text("${game['HomeOrAway']}"),
                                    value: _homeOrAway,
                                    isExpanded: true,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton.icon(
                                      onPressed: (){
                                        if(_editGameDateController.text == "" || _editGameDateController.text == null){
                                          _editGameDateController.text = "${game['GameDate']}";
                                        }
                                        if(_editGameTimeController.text == "" || _editGameTimeController.text == null){
                                          _editGameTimeController.text = "${game['GameTime']}";
                                        }
                                        if(_editOpposingTeamController.text == "" || _editOpposingTeamController.text == null){
                                          _editOpposingTeamController.text = "${game['OpposingTeam']}";
                                        }
                                        if(_editGameLocationController.text == "" || _editGameLocationController.text == null){
                                          _editGameLocationController.text = "${game['GameLocation']}";
                                        }
                                        if(_homeOrAway == "" || _homeOrAway == null){
                                          _homeOrAway = "${game['HomeOrAway']}";
                                        }

                                        // TODO: Record win/loss in a Record document

                                        globals.gamesDB.document(globals.selectedGameDocument).updateData(
                                          {
                                            "GameDate":_editGameDateController.text,
                                            "GameTime":_editGameTimeController.text,
                                            "OpposingTeam":_editOpposingTeamController.text,
                                            "GameLocation":_editGameLocationController.text,
                                            "HomeOrAway":_homeOrAway,
                                          }
                                        );

                                        Navigator.pop(context);
                                      },
                                      color: Colors.indigo,
                                      label: Text(
                                        "Update",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      splashColor: Colors.indigoAccent,
                                      icon: Icon(Icons.update, color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
