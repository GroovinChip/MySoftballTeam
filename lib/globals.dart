library my_softball_team.globals;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggedInUser;
String teamName;
String selectedPlayerName;
String selectedGameDocument;
CollectionReference usersDB = Firestore.instance.collection("Users");
CollectionReference gamesDB = Firestore.instance.collection("Teams").document(teamName).collection("Seasons").document(DateTime.now().year.toString()).collection("Games");
IconData baseball_bat = IconData(0xF852, fontFamily: 'materialdesignicons');
IconData baseball = IconData(0xf851, fontFamily: 'materialdesignicons');

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

// This function converts String dates and times into
// formatted DateTime and TimeOfDay objects
convertStringDateToDateTime(String date, String time) {
  List<String> splittedDateString = date.split(' ');
  List<String> splittedTimeString = time.split('');
  DateTime resultDate;
  String toParseAsDate;
  String year = splittedDateString[2];
  String month;
  String day;
  String timeDenotion = "T";
  String hour;
  String minute;

  switch(splittedDateString[0]){
    case "January":
      month = "01";
      break;
    case "February":
      month = "02";
      break;
    case "March":
      month = "03";
      break;
    case "April":
      month = "04";
      break;
    case "May":
      month = "05";
      break;
    case "June":
      month = "06";
      break;
    case "July":
      month = "07";
      break;
    case "August":
      month = "08";
      break;
    case "September":
      month = "09";
      break;
    case "October":
      month = "10";
      break;
    case "November":
      month = "11";
      break;
    case "December":
      month = "12";
      break;
  }

  switch(splittedDateString[1]){
    case "1,":
      day = "01";
      break;
    case "2,":
      day = "02";
      break;
    case "3,":
      day = "03";
      break;
    case "4,":
      day = "04";
      break;
    case "5,":
      day = "05";
      break;
    case "6,":
      day = "06";
      break;
    case "7,":
      day = "07";
      break;
    case "8,":
      day = "08";
      break;
    case "9,":
      day = "09";
      break;
    case "10,":
      day = "10";
      break;
    case "11,":
      day = "11";
      break;
    case "12,":
      day = "12";
      break;
    case "13,":
      day = "13";
      break;
    case "14,":
      day = "14";
      break;
    case "15,":
      day = "15";
      break;
    case "16,":
      day = "16";
      break;
    case "17,":
      day = "17";
      break;
    case "18,":
      day = "18";
      break;
    case "19,":
      day = "19";
      break;
    case "20,":
      day = "20";
      break;
    case "21,":
      day = "21";
      break;
    case "22,":
      day = "22";
      break;
    case "23,":
      day = "23";
      break;
    case "24,":
      day = "24";
      break;
    case "25,":
      day = "25";
      break;
    case "26,":
      day = "26";
      break;
    case "27,":
      day = "27";
      break;
    case "28,":
      day = "28";
      break;
    case "29,":
      day = "29";
      break;
    case "30,":
      day = "30";
      break;
    case "31,":
      day = "31";
      break;
  }
  if(splittedTimeString[4] == "AM") {
    switch(splittedTimeString[0]){
      case '1':
        hour = "01";
        break;
      case '2':
        hour = "02";
        break;
      case '3':
        hour = "03";
        break;
      case '4':
        hour = "04";
        break;
      case '5':
        hour = "05";
        break;
      case '6':
        hour = "06";
        break;
      case '7':
        hour = "07";
        break;
      case '8':
        hour = "08";
        break;
      case '9':
        hour = "09";
        break;
      case '10':
        hour = "10";
        break;
      case '11':
        hour = "11";
        break;
      case '12':
        hour = "12";
        break;
    }
  } else {
    switch(splittedTimeString[0]){
      case '1':
        hour = "13";
        break;
      case '2':
        hour = "14";
        break;
      case '3':
        hour = "15";
        break;
      case '4':
        hour = "16";
        break;
      case '5':
        hour = "17";
        break;
      case '6':
        hour = "18";
        break;
      case '7':
        hour = "19";
        break;
      case '8':
        hour = "20";
        break;
      case '9':
        hour = "21";
        break;
      case '10':
        hour = "22";
        break;
      case '11':
        hour = "23";
        break;
      case '12':
        hour = "24";
        break;
    }
  }

  if(splittedTimeString[2].length < 2) {
    switch(splittedTimeString[2]){
      case "0":
        minute = "00";
        break;
      case "1":
        minute = "01";
        break;
      case "2":
        minute = "02";
        break;
      case "03":
        minute = "03";
        break;
      case "4":
        minute = "04";
        break;
      case "5":
        minute = "05";
        break;
      case "6":
        minute = "06";
        break;
      case "7":
        minute = "08";
        break;
      case "8":
        minute = "08";
        break;
      case "9":
        minute = "09";
        break;
    }
  } else {
    minute = splittedTimeString[2];
  }

  toParseAsDate = year + month + day + "T" + hour + minute;
  //toParseAsDate = "$year$month$day$timeDenotion$hour$minute";
  resultDate = DateTime.parse(toParseAsDate);
  return resultDate;
}