import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';



class Calendar extends StatefulWidget {
  @override
  CalendarPage createState() => CalendarPage();
}

class CalendarPage extends State<Calendar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\nReport Your Test Results"),
        ),
        body: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[


                  ],
                ),

              ]

          )
          ,
        )

    );
  }

}