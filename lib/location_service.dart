import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LocationService {
  Future<Position> getPosition() async {
    try {
      return Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    } catch (e) {
      throw Exception('Failed to get position: $e');
    }
  }

  Future<Placemark> getPlacemark() async {
    Position position = await getPosition();
    try {
      List<Placemark> placemarks =
      await Geolocator().placemarkFromPosition(position);
      return placemarks[0];
    } catch (e) {
      throw Exception('Failed to get placemark: $e');
    }
  }
}


class CoronavirusService {
  final baseUrl = 'https://coronavirus-tracker-api.herokuapp.com/v2/';

  Future<CoronavirusData> getLatestData() async {
    final response = await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      return CoronavirusData.formatted(
        json: jsonDecode(response.body),
        country: 'Globally',
      );
    } else {
      throw Exception('Failed to load latest coronavirus data.');
    }
  }

  Future<CoronavirusData> getLocationDataFromPlacemark(
      Placemark placemark) async {
    final response = await http
        .get(baseUrl + 'locations?country_code=${placemark.isoCountryCode}');

    if (response.statusCode == 200) {
      return CoronavirusData.formatted(
        json: jsonDecode(response.body),
        country: placemark.country,
      );
    } else {
      throw Exception('Failed to load local coronavirus data.');
    }
  }
}

class CoronavirusData {
  final String date;
  final String locationLabel;
  final int totalNumber;


  CoronavirusData({@required this.date,
    @required this.locationLabel,
    @required this.totalNumber,});

  factory CoronavirusData.formatted({
    Map<String, dynamic> json,
    String country,
  }) {
    int totalNumber;
    if(country.contains("Globally"))
      totalNumber = json['Global']['TotalConfirmed'];
    else
      totalNumber = json['latest']['confirmed'];


    return CoronavirusData(
      date: DateFormat('EEEE d MMMM y').format(DateTime.now()),
      locationLabel: country,
      totalNumber: totalNumber,
    );
  }
}