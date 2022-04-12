import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/service/Location_Service.dart';

class LocationState {
  final LocationService _location = LocationService();

  Future<GeoPoint> get getGeo => _geo();

  LocationState();

  Future<GeoPoint> _geo() async {
    return Future.delayed(const Duration(seconds: 2))
        .then((value) => _location.getGeo);
  }
}
