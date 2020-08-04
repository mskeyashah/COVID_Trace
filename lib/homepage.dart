import 'package:flutter/material.dart';
import 'package:covidtrace/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:covidtrace/location_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<CoronavirusData> f1;

void main() {}

class MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<CoronavirusData> futureCoronavirusData = getData();
    print("data");

    return Scaffold(
      appBar: AppBar(
        title: Text("COVID Trace"),
        centerTitle: true,
      ),
      body: Column(
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
            SizedBox(width: 20),
            Text('COVID-19 Safety Tools',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
          ]),
        ],
      ),
    );
  }

  Future<CoronavirusData> getData({String countryCode}) async {
    try {
      Placemark placemark = await LocationService().getPlacemark();
      f1 = CoronavirusService().getLocationDataFromPlacemark(placemark);
      //f1 = CoronavirusService().getLatestData();
    } on Exception catch (e) {
      print(e.toString());
      f1 = CoronavirusService().getLatestData();
    }
    return f1;
  }
}
