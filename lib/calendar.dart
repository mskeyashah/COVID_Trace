import 'package:covidtrace/survey.dart';
import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';



class Calendar extends StatefulWidget {
  @override
  CalendarPage createState() => CalendarPage();
}

class CalendarPage extends State<Calendar> with TickerProviderStateMixin{
  Map<String, double> dataMap = new Map();
  DateTime endDate;
  List<Color> _colors = [
    Colors.deepPurple,
    Colors.grey[300],
  ];
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    var difference;
    _events = {};

    if(finalselectedDate != null && selection != "No")
    {
      difference = _selectedDay.difference(finalselectedDate).inDays;
      endDate = finalselectedDate.add(Duration(days: 15));
      if(difference>14)
      {
        for (int x = 0; x <=14; x++) {
          _events[finalselectedDate.add(Duration(days: x))] = ['$x'];
        }

      }
      else {
        for (int x = difference; x >= 0; x--) {
          int dayssince = difference - x;
          _events[_selectedDay.subtract(Duration(days: x))] = ['$dayssince'];
        }
        int dif = endDate.difference(_selectedDay).inDays;
        for (int x = 1; x <=dif; x++) {
          if(x==dif)
            _events[_selectedDay.add(Duration(days: x))] = ['non14'];
          else
            _events[_selectedDay.add(Duration(days: x))] = ['non'];
        }
      }
    }

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          //const SizedBox(height: 5),
          Divider(
            color: Colors.grey,
            height: 10,
            thickness: 1,
          ),
          Expanded(child: _buildEventList()),

        ],
      ),

    );
  }
  Widget _buildTableCalendar() {
    return TableCalendar(
        calendarController: _calendarController,
        events: _events,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarStyle: CalendarStyle(
          selectedColor: Colors.transparent,
          todayStyle: TextStyle(
            color: Colors.black,
          ),
          markersPositionBottom: 0,
          selectedStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          todayColor: Colors.grey[300],
          markersColor: Colors.deepPurple[700],
          outsideDaysVisible: true,
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          centerHeaderTitle: true,
          formatButtonVisible: false,

        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: Colors.grey),
          weekdayStyle: TextStyle().copyWith(color: Colors.grey),
        ),
        onDaySelected: _onDaySelected,
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }
            return children;
          },
          todayDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                  color: Colors.transparent,
                  width: 120,
                  height: 600,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 60,
                        child:Icon(Icons.lens,color: Colors.grey[300], size: 40),
                      ),
                      Positioned(
                        width: 50,
                        top: 17,
                        child:Text(
                          '${date.day}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ).copyWith(fontSize: 16.0),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 70,
                        child:Icon(Icons.panorama_fish_eye,color: Colors.orange,size: 40,),
                      ),
                    ],
                  )
              ),
            );
          },
        )
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    if(!events[0].contains("non") && date.difference(DateTime.now()).inDays!=0) {

      if(events[0].contains("0") && date.difference(finalselectedDate).inDays==0){
        return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.only(top: 0, left: 0.0),
            color: Colors.transparent,
            width: 52,
            height: 40,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 7, left: 19.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.zero,
                    ),
                  ),
                  width: 52.0,
                  height: 26.0,
                  child:
                  Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white).copyWith(
                        fontSize: 14.0),
                  ),

                ),

                SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  width: 8.0,
                  height: 8.0,

                )
              ],
            )
        );
      }
      else if(events[0].contains("14")){
        return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.only(top: 0, left: 0.0),
            color: Colors.transparent,
            width: 52,
            height: 40,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 7, left: 19.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(20.0)
                    ),
                  ),
                  width: 52.0,
                  height: 26.0,
                  child:
                  Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white).copyWith(
                        fontSize: 14.0),
                  ),

                ),

                SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  width: 8.0,
                  height: 8.0,

                )
              ],
            )
        );
      }
      else{
        return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.only(top: 0, left: 0.0),
            color: Colors.transparent,
            width: 52,
            height: 40,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 7, left: 19.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurple,
                  ),
                  width: 52.0,
                  height: 26.0,
                  child:
                  Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white).copyWith(
                        fontSize: 14.0),
                  ),

                ),

                SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  width: 8.0,
                  height: 8.0,

                )
              ],
            )
        );
      }
    }
    else if(events[0].contains("non")){
      if(events[0].contains("14")) {
        return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.only(top: 0, left: 0.0),
            color: Colors.transparent,
            width: 52,
            height: 40,
            child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 7, left: 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    width: 52.0,
                    height: 26.0,
                    child:
                    Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.black).copyWith(
                          fontSize: 14.0),
                    ),

                  ),
                ]));
      }
      else
      {
        return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.only(top: 0, left: 0.0),
            color: Colors.transparent,
            width: 52,
            height: 40,
            child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 7, left: 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey[300],
                    ),
                    width: 52.0,
                    height: 26.0,
                    child:
                    Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.black).copyWith(
                          fontSize: 14.0),
                    ),

                  ),
                ]));
      }
    }
    else if(date.difference(DateTime.now()).inDays ==0)
    {
      return Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: const EdgeInsets.only(top: 0, left: 0.0),
          color: Colors.transparent,
          width: 52,
          height: 40,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 7, left: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.transparent,
                ),
                width: 52.0,
                height: 26.0,

              ),
              SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                width: 8.0,
                height: 8.0,

              )

            ],
          ));
    }


  }

  Widget _buildEventList() {
    if(_selectedEvents.length != 0 && !_selectedEvents[0].contains("non")) {
      dataMap["Flutter"] = double.parse(_selectedEvents.elementAt(0));
      dataMap["React"] = 14 - double.parse(_selectedEvents.elementAt(0));
      return ListView(
        children: _selectedEvents
            .map((event) =>
            Container(
                height: 320,
                width: 100,
                margin: const EdgeInsets.symmetric(
                    horizontal: 0.0, vertical: 4.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(child: Image.asset("images/home.png", height: 70,
                      width: 60,), left: 72, top: 40,),
                    Positioned(
                      left: 30,
                      top: 10,
                      child:
                      PieChart(
                        dataMap: dataMap,
                        chartRadius: MediaQuery
                            .of(context)
                            .size
                            .width / 3,
                        colorList: _colors,
                        showLegends: false,
                        showChartValueLabel: false,
                        showChartValues: true,
                        initialAngle: -89,
                        chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.transparent,
                        ),
                        chartType: ChartType.ring,
                      ),
                    ),
                    Positioned(
                      left: 180,
                      top: 10,
                      child: Text(
                          _selectedEvents.elementAt(0),
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 70,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    Positioned(
                      left: 265,
                      top: 30,
                      child: Text(
                          "DAYS SINCE\nCONTACT",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 17,
                          )
                      ),
                    ),
                    Positioned(
                      left: 200,
                      top: 90,
                      child: Text(
                          "PLEASE CONTINUE\nTO SELF-ISOLATE",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 17,
                          )
                      ),
                    ),
                    SizedBox(height: 325,
                      child:
                      Divider(
                        color: Colors.grey,
                        height: 10,
                        thickness: 1,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 175,),
                        FlatButton(
                            onPressed: () {

                            },
                            child: Image.asset(
                              "images/covidsymptom.png", height: 70,
                              width: 350,)
                        )
                      ],
                    )
                  ],
                )
            )).toList(),
      );
    }
    else
    {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              FlatButton(
                  onPressed: () {

                  },
                  child: Image.asset(
                    "images/covidsymptom.png", height: 70,
                    width: 350,)
              )
            ],
          )
        ],
      );
    }
  }
}