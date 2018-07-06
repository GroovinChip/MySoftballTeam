import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EditGameModal extends StatefulWidget {
  @override
  _EditGameModalState createState() => _EditGameModalState();
}

class _EditGameModalState extends State<EditGameModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Game"),
      ),
      body: Center(
        child: Text("Content"),
      ),
    );
  }
}
