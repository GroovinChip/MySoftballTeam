import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:outline_material_icons/outline_material_icons.dart';

class EditGame extends StatefulWidget {
  @override
  _EditGameState createState() => _EditGameState();
}

class _EditGameState extends State<EditGame> {

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
  DocumentSnapshot gameToUpdate;

  final dateFormat = DateFormat("MMMM d, yyyy");
  final timeFormat = DateFormat("h:mm a");

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
            fontWeight: FontWeight.bold,
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
                gameToUpdate = games[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: DateTimePickerFormField(
                                  dateOnly: true,
                                  format: dateFormat,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "${gameToUpdate['GameDate']}",
                                    prefixIcon: Icon(OMIcons.today),
                                  ),
                                  controller: _editGameDateController,
                                  editable: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TimePickerFormField(
                                  format: timeFormat,
                                  editable: false,
                                  controller: _editGameTimeController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "${gameToUpdate['GameTime']}",
                                    prefixIcon: Icon(OMIcons.accessTime),
                                  ),
                                ),
                              ),
                              /*Padding(
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
                              ),*/
                              /*Padding(
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
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TextField(
                                  controller: _editOpposingTeamController,
                                  decoration: InputDecoration(
                                    labelText: "Opposing Team: " + "${gameToUpdate['OpposingTeam']}",
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
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TextField(
                                  controller: _editGameLocationController,
                                  decoration: InputDecoration(
                                      labelText: "Game Location: " + "${gameToUpdate['GameLocation']}",
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
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child:  DropdownButton(
                                  items: _homeOrAwayOptions,
                                  onChanged: _chooseHomeOrAway,
                                  hint: Text("${gameToUpdate['HomeOrAway']}"),
                                  value: _homeOrAway,
                                  isExpanded: true,
                                ),
                              ),
                            ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Update"),
        icon: Icon(OMIcons.update),
        onPressed: () {
          if(_editGameDateController.text == "" || _editGameDateController.text == null){
            _editGameDateController.text = "${gameToUpdate['GameDate']}";
          }
          if(_editGameTimeController.text == "" || _editGameTimeController.text == null){
            _editGameTimeController.text = "${gameToUpdate['GameTime']}";
          }
          if(_editOpposingTeamController.text == "" || _editOpposingTeamController.text == null){
            _editOpposingTeamController.text = "${gameToUpdate['OpposingTeam']}";
          }
          if(_editGameLocationController.text == "" || _editGameLocationController.text == null){
            _editGameLocationController.text = "${gameToUpdate['GameLocation']}";
          }
          if(_homeOrAway == "" || _homeOrAway == null){
            _homeOrAway = "${gameToUpdate['HomeOrAway']}";
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
      ),
    );
  }
}
