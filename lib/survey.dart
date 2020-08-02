import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';

String _selection = '';

List<String> choices = ["Yes", "No", "I have been in contact with someone\nwho has tested positive for COVID-19."];

class Survey extends StatefulWidget {
  @override
  SurveyPage createState() => SurveyPage();
}

class SurveyPage extends State<Survey> {

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
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.deepPurple,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Text("Help others by reporting your health results!",
                      style: TextStyle(
                        color: Colors.white
                      ))],
                )),
              Container(
                  color: Colors.deepPurple,
                  child: Row(
                    children: <Widget>[
                      Text("",)],
                  )),

              Expanded(
                child: Stack(children: <Widget>[
              Text('Have you tested positive for COVID-19?'),
              Column(
                children: choices.map((item) => RadioListTile(
                    groupValue: _selection,
                    title: Text(item),
                    value: item,
                    activeColor: Colors.black,
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _selection = val;
                      });
                    },
                  )).toList(),
              ),
                  Text('What date did you test or come in\ncontact with someone who tested positive?'),

                ]))
            ]
          )
              ,
          )

    );
  }

}