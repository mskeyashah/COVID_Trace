import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covidtrace/homepage.dart';
import 'package:covidtrace/survey.dart';


void main(){
  runApp(Home());
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("App started");
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
        child: new Scaffold(
          body: TabBarView(

            children: [
              MyHomePageState(),
              Survey(),
              Survey(),
              Survey()
            ],
          ),

          bottomNavigationBar: new TabBar(

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
