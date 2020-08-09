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
                onPressed: () {
                  print("exiting");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Survey()),
                  );
                },
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Image.asset('images/Report.png'),
              ),
              SizedBox(height: 5.0),
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Image.asset('images/TestingCenter.png'),
              ),
              //Mood
              SizedBox(height: 25.0),
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
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        if(happyimage.contains('pressed')){
                            setState(() {
                                happyimage = 'images/HappyFace.png';
                             });
                          }
                          else{
                          setState(() {
                            happyimage = 'images/pressedhappyface.png';

                          });

                         }
                      },
                      padding: EdgeInsets.fromLTRB(10.0, 0, 5.0, 0),
                      child: Image.asset(happyimage),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        if(sadimage.contains('pressed')){
                          setState(() {
                            sadimage = 'images/SadFace.png';
                          });
                        }
                        else{
                          setState(() {
                            sadimage = 'images/pressedsadface.png';

                          });

                        }
                      },
                      padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 5),
                      child: Image.asset(sadimage),
                    ),
                  ),
                ],
              ),
              //Covid Resources
              SizedBox(height: 25.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "COVID-19 Resources",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(20.0, 0, 5.0, 5),
                      child: Image.asset('images/CDC.png'),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(5.0, 0, 20.0, 5),
                      child: Image.asset('images/Notifying.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(20.0, 0, 5.0, 0),
                      child: Image.asset('images/LocalUpdates.png'),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(5.0, 0, 20.0, 0),
                      child: Image.asset('images/SafetyGuidelines.png'),
                    ),
                  ),
                ],
              ),
              //Prevention Tips
              SizedBox(height: 25.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Quick Prevention Tips",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Image.asset('images/sixfeetdistance.png',
                        height: 75, width: 75),
                  ),
                  Expanded(
                    child: Image.asset('images/facecover.png',
                        height: 75, width: 75),
                  ),
                  Expanded(
                    child: Image.asset('images/washhands.png',
                        height: 75, width: 75),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  'Social',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                Text(
                  'Wear A',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                Text(
                  'Wash Your',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  'Distance',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                Text(
                  'Mask',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                Text(
                  'Hands',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ]),
              SizedBox(height: 30.0),
            ],
          ),
        ));
  }
}
