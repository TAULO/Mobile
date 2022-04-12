import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class LocationService {
  Location get getLocation => _location;
  final Location _location = Location();

  late GeoPoint _geo;
  get getGeo => _geo;
  get getInitLocation => initLocation();

  LocationService() {
    initLocation();
  }

  initLocation() async {
    bool _serviceEnable;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnable = await _location.serviceEnabled();
    if (!_serviceEnable) {
      _serviceEnable = await _location.requestService();
      if (!_serviceEnable) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    _locationData = await _location.getLocation();
    _geo = GeoPoint(_locationData.latitude ?? 0, _locationData.longitude ?? 0);

    _location.onLocationChanged.listen((LocationData currentLocation) {
      _geo = GeoPoint(
          currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });
    return _geo;
  }

  // Future<GeoPoint> getGeo() async {
  //   LocationData _locationData = await _location.getLocation();
  //   _location.onLocationChanged.listen((_locationData) {
  //     _geo =
  //         GeoPoint(_locationData.latitude ?? 0, _locationData.longitude ?? 0);
  //   });
  //   return _geo;
  // }
}
