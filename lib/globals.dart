library my_softball_team.globals;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;
String teamTame;
String selectedPlayerName;

// List of field positions
List<DropdownMenuItem> fieldPositions = [
  new DropdownMenuItem(
    child: new Text("Pitcher"),
    value: "Pitcher",
  ),
  new DropdownMenuItem(
    child: new Text("First Base"),
    value: "First Base",
  ),
  new DropdownMenuItem(
    child: new Text("Second Base"),
    value: "Second Base",
  ),
  new DropdownMenuItem(
    child: new Text("Shortstop"),
    value: "Shortstop",
  ),
  new DropdownMenuItem(
    child: new Text("Third Base"),
    value: "Third Base",
  ),
  new DropdownMenuItem(
    child: new Text("Right Field"),
    value: "Right Field",
  ),
  new DropdownMenuItem(
    child: new Text("Right Center Field"),
    value: "Right Center Field",
  ),
  new DropdownMenuItem(
    child: new Text("Center Field"),
    value: "Center Field",
  ),
  new DropdownMenuItem(
    child: new Text("Left Center Field"),
    value: "Left Center Field",
  ),
  new DropdownMenuItem(
    child: new Text("Left Field"),
    value: "Left Field",
  ),
  new DropdownMenuItem(
    child: new Text("Catcher"),
    value: "Catcher",
  ),
];