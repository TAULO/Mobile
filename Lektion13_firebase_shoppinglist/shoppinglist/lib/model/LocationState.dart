import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/service/LocationService.dart';

class LocationState extends ChangeNotifier {
  final LocationService _location = LocationService();

  Future<GeoPoint> get getGeo => _geo();

  LocationState() {
    _geo();
  }

  Future<GeoPoint> _geo() async {
    return _location.getGeo();
    // return Future.delayed(const Duration(seconds: 2))
    //     .then((value) => _location.getGeo());
  }
}
