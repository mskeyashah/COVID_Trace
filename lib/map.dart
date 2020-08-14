import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covidtrace/homepage.dart';
import 'package:covidtrace/survey.dart';
import 'package:covidtrace/calendar.dart';
import 'package:covidtrace/entersurvey.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:covidtrace/main.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  LatLng _initialPosition = LatLng(37.42796133580664, -122.0857496555962);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntrl) {
    _controller = _cntrl;
    _location.onLocationChanged().listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude, l.longitude),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\n Watch out for hot spots!"),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              color: Colors.deepPurple,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  Text(" Hot spots are based on how crowded the area is.",
                      style: TextStyle(color: Colors.white))
                ],
              )),
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 10),
            mapType: MapType.terrain,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
          ),
        ],
      ),
    );
  }
}
