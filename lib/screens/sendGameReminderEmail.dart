import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:my_softball_team/globals.dart' as globals;

class SendGameReminderEmailScreen extends StatefulWidget {
  @override
  _SendGameReminderEmailScreenState createState() => _SendGameReminderEmailScreenState();
}

class _SendGameReminderEmailScreenState extends State<SendGameReminderEmailScreen> {
  TextEditingController subjectController = TextEditingController(text: "Game Today!");
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text(
          "Send Game Reminder",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(GroovinMaterialIcons.send_outline),
            onPressed: (){

            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "To:",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "CC:",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "Subject:",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 100,
                      decoration: InputDecoration.collapsed(hintText: "Message"),
                      //inputFormatters: TextI,
                    ),
                  ),
                ),
              ],
            );
          } else {
            List<String> emailAddresses = [];
            for(int i = 0; i < snapshot.data.documents.length; i++){
              DocumentSnapshot ds = snapshot.data.documents[i];
              emailAddresses.add(ds.documentID);
            }
            String s = "";
            emailAddresses.forEach((value) {
              s += value + "; ";
            });
            TextEditingController to = TextEditingController(text: s);
            return Column(
              children: <Widget>[
                TextField(
                  controller: to,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "To:",
                    labelStyle: TextStyle(color: Colors.indigo),
                  ),
                ),
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: "Subject:",
                    labelStyle: TextStyle(color: Colors.indigo),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 100,
                      decoration: InputDecoration.collapsed(
                        hintText: "Message",
                        hintStyle: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      )
    );
  }
}
