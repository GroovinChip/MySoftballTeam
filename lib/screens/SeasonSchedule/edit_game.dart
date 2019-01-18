import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TextField(
                                  controller: _editOpposingTeamController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(OMIcons.group),
                                    labelText: "Opposing Team: " + "${gameToUpdate['OpposingTeam']}",
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
                                      prefixIcon: Icon(OMIcons.locationOn),
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
                                child: OutlineDropdownButton(
                                  items: _homeOrAwayOptions,
                                  onChanged: _chooseHomeOrAway,
                                  hint: Row(
                                    children: <Widget>[
                                      Icon(OMIcons.notListedLocation, color: Colors.grey[600],),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text("${gameToUpdate['HomeOrAway']}"),
                                      ),
                                    ],
                                  ),
                                  value: _homeOrAway,
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
