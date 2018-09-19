import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class EmailList extends StatefulWidget {
  @override
  _EmailListState createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2.0,
        title: Text("Email List", style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
