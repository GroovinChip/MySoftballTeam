import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:intl/intl.dart';
import 'package:my_softball_team/globals.dart' as globals;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

class AddNewGame extends StatefulWidget{
  @override
  _AddNewGameState createState() => _AddNewGameState();
}

class _AddNewGameState extends State<AddNewGame> {

  List<DropdownMenuItem> _homeOrAwayOptions = [
    DropdownMenuItem(child: Text("Home"), value: "Home",),
    DropdownMenuItem(child: Text("Away"), value: "Away",),
    DropdownMenuItem(child: Text("Bye"), value: "Bye",)
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  final timeFormat = DateFormat("h:mm a");

  TextEditingController _opposingTeamController = TextEditingController();
  TextEditingController _gameLocationController = TextEditingController();
  TextEditingController _gameDateController = TextEditingController();
  TextEditingController _gameTimeController = TextEditingController();
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
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "Add New Game",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DateTimePickerFormField(
                            dateOnly: true,
                            format: dateFormat,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Game Date",
                              prefixIcon: Icon(OMIcons.today),
                            ),
                            controller: _gameDateController,
                            editable: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TimePickerFormField(
                            format: timeFormat,
                            editable: false,
                            controller: _gameTimeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Game Time",
                              prefixIcon: Icon(OMIcons.accessTime),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextField(
                            controller: _opposingTeamController,
                            decoration: InputDecoration(
                              labelText: "Opposing Team*",
                              prefixIcon: Icon(OMIcons.group),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  _opposingTeamController.text = "";
                                }
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _gameLocationController,
                          decoration: InputDecoration(
                            labelText: "Game Location*",
                            prefixIcon: Icon(OMIcons.locationOn),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: (){
                                _gameLocationController.text = "";
                              })
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    OutlineDropdownButton(
                      items: _homeOrAwayOptions,
                      onChanged: _chooseHomeOrAway,
                      hint: Row(
                        children: <Widget>[
                          Icon(OMIcons.notListedLocation, color: Colors.grey[600],),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("Home or Away"),
                          ),
                        ],
                      ),
                      value: _homeOrAway,
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Save"),
        onPressed: () {
          if(_gameDateController.text != "" && _gameTimeController.text != "") {
            if(_opposingTeamController.text != "" && _gameLocationController.text != "") {
              globals.gamesDB.add({
                "GameDate":_gameDateController.text,
                "GameTime":_gameTimeController.text,
                "OpposingTeam":_opposingTeamController.text,
                "GameLocation":_gameLocationController.text,
                "HomeOrAway":_homeOrAway
              });
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
