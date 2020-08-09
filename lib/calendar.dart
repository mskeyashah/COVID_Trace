import 'package:covidtrace/survey.dart';
import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:covidtrace/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';



class Calendar extends StatefulWidget {
  @override
  CalendarPage createState() => CalendarPage();
}

class CalendarPage extends State<Calendar> with TickerProviderStateMixin{
  Map<String, double> dataMap = new Map();

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


    _events = {
//      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
//      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
//      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
//      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
//      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
//      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
//      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
//      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//      _selectedDay.add(Duration(days: 0)): ['Event A14'],
    };

    if(finalselectedDate != null && selection != "No")
    {
      difference = _selectedDay.difference(finalselectedDate).inDays;
      print(difference);
      if(difference>14)
        difference = 14;
      for(int x = 0; x<=difference; x++)
      {
        //int dayssince = difference-x;
        _events[finalselectedDate.add(Duration(days: x))] = ['$x'];

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
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
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
        selectedColor: Colors.deepPurple[400],
        selectedStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        todayColor: Colors.deepPurple[200],
        markersColor: Colors.deepPurple[700],
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepPurple[400],
        todayColor: Colors.deepPurple[200],
        markersColor: Colors.deepPurple[700],
        outsideDaysVisible: true,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.black),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  Colors.deepPurple,
      ),
      width: 16.0,
      height: 16.0,

    );
  }

  Widget _buildEventList() {
    if(_selectedEvents.length != 0) {
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
                child: /*ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),*/
                Stack(
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
                          color: Colors.white,
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
                            onPressed: () {},
                            child: Image.asset(
                              "images/covidsymptom.png", height: 70,
                              width: 350,)
                        )

                      ],
                    )


                  ],
                )

            ))
            .toList(),
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
                    onPressed: () {},
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