import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:my_softball_team/globals.dart' as globals;
import 'package:my_softball_team/widgets/editStatsModal.dart';

class SeasonSchedule extends StatefulWidget {
  @override
  _SeasonScheduleState createState() => _SeasonScheduleState();
}

class _SeasonScheduleState extends State<SeasonSchedule> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Schedule"),
    );
  }
}
