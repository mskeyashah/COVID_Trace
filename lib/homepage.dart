import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:covidtrace/location_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covidtrace/survey.dart';

Future<CoronavirusData> f1;

void main() {}

class MyHomePageState extends StatelessWidget {
  final TabController tabController;

  MyHomePageState({Key key, this.tabController}) : super(key: key);

  void goToSecondScreen(BuildContext context) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
    if(result == true)
      tabController.index = 1;
  }

  @override
  Widget build(BuildContext context) {
    Future<CoronavirusData> futureCoronavirusData = getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID Trace"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(children: <Widget>[
              SizedBox(width: 10),
              Image.asset(
                "images/homepic.png",
                height: 150,
                width: 190,
                alignment: Alignment.topLeft,
              ),
              FutureBuilder<CoronavirusData>(
                future: futureCoronavirusData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return SpinKitPulse(size: 50, color: Colors.deepPurple);
                    case ConnectionState.waiting:
                      return SpinKitPulse(size: 50, color: Colors.deepPurple);
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Text(snapshot.data.totalNumber.toString(),
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                            Text("Confirmed Cases",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(snapshot.data.locationLabel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline)),
                          ],
                        );
                      }
                  }
                  return Container();
                },
              ),
            ]),
            SizedBox(
              height: 13,
            ),
            Row(children: <Widget>[
              //SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "COVID-19 Safety Tools",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      tabController.index = 2;
                    },
                    padding: EdgeInsets.fromLTRB(10.0, 5, 5.0, 20),
                    child: Image.asset('images/hotspots.png'),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      goToSecondScreen(context);
                    },
                    padding: EdgeInsets.fromLTRB(5.0, 5, 10.0, 20),
                    child: Image.asset('images/testresult.png'),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Resources",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 0),
              child: Image.asset('images/gettested.png'),
            ),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 0),
              child: Image.asset('images/bestpractices.png'),
            ),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 0),
              child: Image.asset('images/who.png'),
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }

  Future<CoronavirusData> getData({String countryCode}) async {
    try {
      f1 = CoronavirusService().getLatestData();
    } on Exception catch (e) {
      print(e.toString());
    }
    return f1;
  }
}
