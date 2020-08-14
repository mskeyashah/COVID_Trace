import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covidtrace/homepage.dart';
import 'package:covidtrace/survey.dart';
import 'package:covidtrace/calendar.dart';
import 'package:covidtrace/entersurvey.dart';
import 'package:flutter/cupertino.dart';
import 'package:covidtrace/map.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePage(),
    );
  }

}
class HomePage extends StatefulWidget {

  @override
  Home createState() => new Home();
}

class Home extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new MaterialApp(
      title: 'COVID TRACE',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      color: Colors.yellow,
      home: DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: new Scaffold(
          body: TabBarView(
            controller: tabController,
            children: [MyHomePageState(tabController: tabController,), Calendar(tabController: tabController,), MyMap(), EnterSurvey(tabController: tabController,)],
          ),
          bottomNavigationBar: new TabBar(
            controller: tabController,
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.calendar_today),
              ),
              Tab(
                icon: new Icon(Icons.location_on),
              ),
              Tab(
                icon: new Icon(Icons.border_color),
              ),
            ],
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
