import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;

class SendGameReminderEmailScreen extends StatefulWidget {
  @override
  _SendGameReminderEmailScreenState createState() => _SendGameReminderEmailScreenState();
}

class _SendGameReminderEmailScreenState extends State<SendGameReminderEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Game Reminder"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: (){

            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(

            ),
          ),
        ],
      ),
    );
  }
}
