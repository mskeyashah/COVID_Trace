import 'package:covidtrace/survey.dart';
import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EnterSurvey extends StatefulWidget {
  @override
  _EnterSurveyState createState() => _EnterSurveyState();
}

class _EnterSurveyState extends State<EnterSurvey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\n How are you feeling today?"),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.deepPurple,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      Text(
                          " Check in daily to track the status of your health!",
                          style: TextStyle(color: Colors.white))
                    ],
                  )),
              Container(
                  color: Colors.deepPurple,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "",
                      )
                    ],
                  )),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Help Stop the Spread of COVID-19",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Image.asset('images/Report.png'),
              ),
              SizedBox(height: 5.0),
              //This button doesn't need to be working
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Image.asset('images/TestingCenter.png'),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "How're You Feeling Today?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Image.asset('images/Happy.png')),
                  Expanded(child: Image.asset('images/SadFace.png')),
                ],
              ),
            ],
          ),
        ));
  }
}
