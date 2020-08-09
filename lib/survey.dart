import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


DateTime finalselectedDate;

String selection = '';
String text1;
DateTime _selectedDate;
List<List<String>> _options = [['Fever', 'Dry Cough', 'Loss of Appetite', 'Fatigue','Muscle and Joint Pain','Diarrhea'],
  ['Sore Throat', 'Runny Nose', 'Nasal Congestion', 'Shortness of Breath','Confusion','Loss of Smell']];
List<List<bool>> _selected = [[false, false, false,false,false,false],[false, false, false,false,false,false]];


List<String> choices = ["Yes", "No", "I have been in contact with someone\nwho has tested positive for COVID-19."];

class Survey extends StatefulWidget {
  @override
  SurveyPage createState() => SurveyPage();
}

class SurveyPage extends State<Survey> {

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
      for(int y = 0; y< _options[i].length; y++) {
        FilterChip filterChip = FilterChip(
          selected: _selected[i][y],
          label: Text(_options[i][y],style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          selectedColor: Colors.deepPurple,
          labelStyle: TextStyle(
              color: _selected[i][y] ? Colors.white : Colors.deepPurple),
          showCheckmark: false,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey,
            ),),
          onSelected: (bool selected) {
            setState(() {
              _selected[i][y] = selected;
            });
          },

        );

        chips.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: filterChip
        ));
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
  bool isNull()
  {
    if(_selectedDate != null && text1 != null && selection != null)
      return false;
    return true;
  }
  showAlertDialog(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
          image: Image.asset('images/dialog.png'),
          title: Text(
            "Report Recorded!",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: Text(
            'Thank you for reporting\nyour results! Your information will\nremain anonymous and stored\non '
                'your device. Remember to keep track of your symptoms and health.',
            textAlign: TextAlign.center,
          ),
          onOkButtonPressed: (){
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
          },
          onCancelButtonPressed: (){},
          buttonOkText: Text("Close",style: TextStyle(color: Colors.white)),
          buttonOkColor: Colors.deepPurple,
          buttonCancelColor: Colors.deepPurple,
          buttonCancelText: Text("Calendar",style: TextStyle(color: Colors.white)),
          buttonRadius: 20,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\nReport Your Test Results"),
          automaticallyImplyLeading: true,
          leading: IconButton (
              icon:Icon(Icons.arrow_back),
              onPressed:() {
                Navigator.pop(context);}
          ),

        ),
        body: SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        color: Colors.deepPurple,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 50),
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
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Text('Have you tested positive for COVID-19?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold))],
                    ),

                    Column(
                      children: choices.map((item) => RadioListTile(
                        groupValue: selection,
                        title: Text(item),
                        value: item,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          setState(() {
                            selection = val;
                          });
                        },
                      )).toList(),
                    ),
                    SizedBox(height: 20),

                    Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          Text('What date did you test or come in\ncontact with someone who tested positive?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          ActionChip(
                            avatar: Icon(
                              Icons.calendar_today,
                              color: Colors.deepPurple[200],
                            ),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                              color: Colors.grey,
                            ),),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,),
                            label: Text(_selectedDate == null //ternary expression to check if date is null
                                ? 'MM/DD/YY'
                                : '${DateFormat('MM/dd/yy').format(_selectedDate)}'),
                            onPressed: () {
                              _pickDateDialog();
                            },
                          ),
                        ]),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          Text('Experiencing any symptoms?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          Text('Select those that apply', style: TextStyle(
                            fontSize: 15,)),
                          SizedBox(width: 150,),
                          Icon(Icons.arrow_forward,color: Colors.grey,)
                        ],
                      ),

                      Container(
                        height: 70,
                        child: _buildChips(),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                        Text('Prevent the spread of COVID-19 by sharing\nsome information. Your information will\nremain anonymous.',
                            style: TextStyle(
                              fontSize: 15,)),
                      ]),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                            Text('Enter you zip code',style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          Container(width: 100, height: 45,
                          child: TextField(
                            decoration: new InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0),borderRadius: BorderRadius.circular(10))
                            ),
                            onChanged: (String text){  //  on Changed ie while entering value real time.
                              setState(() {
                                text1 = text;
                              });
                            },)),
                      ]),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                          width: 300,

                        child: RaisedButton(
                          onPressed: () {
                            if(!isNull()) {
                              finalselectedDate = _selectedDate;
                              showAlertDialog(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey,
                            ),),
                          child: const Text('Complete Check-In Report',
                              style: TextStyle(fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          color:  _selectedDate == null ? Colors.grey : text1 == null? Colors.grey : selection == null? Colors.grey: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 30),

                    ],),

                  ],
                ),

              ]

          )
          ,
        )

    );
  }

}