import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:covidtrace/entersurvey.dart';

String _selection = '';

List<String> choices = [
  "Yes",
  "No",
  "I have been in contact with someone\nwho has tested positive for COVID-19."
];

class Survey extends StatefulWidget {
  @override
  SurveyPage createState() => SurveyPage();
}

class SurveyPage extends State<Survey> {
  String _text = '';
  DateTime _selectedDate;
  List<List<String>> _options = [
    [
      'Fever',
      'Dry Cough',
      'Loss of Appetite',
      'Fatigue',
      'Muscle and Joint Pain',
      'Diarrhea'
    ],
    [
      'Sore Throat',
      'Runny Nose',
      'Nasal Congestion',
      'Shortness of Breath',
      'Confusion',
      'Loss of Smell'
    ]
  ];
  List<List<bool>> _selected = [
    [false, false, false, false, false, false],
    [false, false, false, false, false, false]
  ];

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      for (int y = 0; y < _options[i].length; y++) {
        FilterChip filterChip = FilterChip(
          selected: _selected[i][y],
          label: Text(
            _options[i][y],
          ),
          backgroundColor: Colors.transparent,
          selectedColor: Colors.deepPurple,
          labelStyle: TextStyle(
              color: _selected[i][y] ? Colors.white : Colors.deepPurple),
          showCheckmark: false,
          shape: StadiumBorder(side: BorderSide()),
          onSelected: (bool selected) {
            setState(() {
              _selected[i][y] = selected;
            });
          },
        );

        chips.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 10), child: filterChip));
      }
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\nReport Your Test Results"),
          elevation: 0.0,
        ),
        body: Container(
          child: Column(children: <Widget>[
            Container(
                color: Colors.deepPurple,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Text("Help others by reporting your health results!",
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
            Text('Have you tested positive for COVID-19?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
            Column(
              children: choices
                  .map((item) => RadioListTile(
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
                      ))
                  .toList(),
            ),
            SizedBox(height: 20.0),
            SingleChildScrollView(
                child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'What date did you test or come in\ncontact with someone who tested positive?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  ActionChip(
                    avatar: Icon(
                      Icons.calendar_today,
                      color: Colors.deepPurple,
                    ),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(side: BorderSide()),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    label: Text(_selectedDate ==
                            null //ternary expression to check if date is null
                        ? 'MM/DD/YY'
                        : '${DateFormat('MM/dd/yy').format(_selectedDate)}'),
                    onPressed: () {
                      _pickDateDialog();
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Experiencing any symptoms?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  Text('Select those that apply'),
                  Container(
                    height: 70,
                    child: _buildChips(),
                  ),
                  Text(
                      'Prevent the spread of COVID-19 by sharing\nsome information. Your information will\nremain anonymous.'),
                  Text('Enter you zip code'),
                  Container(
                      width: 100,
                      height: 50,
                      child: TextField(
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        )),
                        onChanged: (String text) {
                          //  on Changed ie while entering value real time.
                          setState(() {
                            _text = text;
                          });
                        },
                      )),
                ],
              ),
            ]))
          ]),
        ));
  }
}
