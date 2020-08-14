import 'package:covidtrace/survey.dart';
import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


var happyimage = 'images/HappyFace.png';
var sadimage = 'images/SadFace.png';

class EnterSurvey extends StatefulWidget {
  final TabController tabController;
  EnterSurvey({Key key, this.tabController}) : super(key: key);

  @override
  EnterSurveyState createState() => EnterSurveyState();
}

class EnterSurveyState extends State<EnterSurvey> {
  void goToSecondScreen() async {
      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
      if(result == true)
        widget.tabController.index = 1;
  }
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
                    goToSecondScreen();
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
                          EasyDialog(
                            contentPadding:	EdgeInsets.all(0.0),
                            topImage: 	AssetImage("images/goodpic.png",),
                            contentList: [
                              DialogButton(
                                height: 61.18,
                                  onPressed: () {
                                    //widget.tabController.index = 1;
                                    //Navigator.pop(context);
                                  },
                                  child: Text("GO TO CALENDAR", style: TextStyle(color: Colors.deepPurple,decoration: TextDecoration.underline, fontSize: 18, fontWeight: FontWeight.bold)),
                                  color: Colors.white,
                              ),
                            ],
                            height: 360,
                            width: 310,
                          ).show(context);
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
                          EasyDialog(
                            contentPadding:	EdgeInsets.all(0.0),
                            topImage: 	AssetImage("images/bad.png",),
                            contentList: [
                              DialogButton(
                                  onPressed: () {},
                                  height: 65.5,
                                  child: Text("SEE TESTING LOCATIONS", style: TextStyle(color: Colors.deepPurple,decoration: TextDecoration.underline, fontSize: 18, fontWeight: FontWeight.bold)),
                                  color: Colors.white
                              ),
                            ],
                            height: 360,
                            width: 310,
                          ).show(context);
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
                      onPressed: () {
                        launch("https://www.cdc.gov/coronavirus/2019-ncov/index.html");
                      },
                      padding: EdgeInsets.fromLTRB(20.0, 0, 5.0, 5),
                      child: Image.asset('images/CDC.png'),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        launch("https://www.cdc.gov/coronavirus/2019-ncov/php/contact-tracing/contact-tracing-plan/contact-tracing.html");
                      },
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  '\t\t\tSocial',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                SizedBox(width: 22),
                Text(
                  'Wear A',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                SizedBox(width: 6),
                Text(
                  'Wash Your',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  'Distance       ',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                //SizedBox(width: 0.5),
                Text(
                  'Facecover     ',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
                //SizedBox(width: 1),
                Text(
                  '    Hands   ',
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
