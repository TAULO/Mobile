import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/LocationState.dart';
import 'package:shoppinglist/service/Location_Service.dart';
import 'package:shoppinglist/view/googleMap_widget.dart';

class LocationView extends StatefulWidget {
  LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LocationState state = LocationState();

  Future<GeoPoint> geoFuture() async {
    return state.getGeo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
      ),
      body: FutureBuilder<GeoPoint>(
        future: geoFuture(),
        builder: (BuildContext context, AsyncSnapshot<GeoPoint> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = [
              GoogleMapWidget(snapshot: snapshot),
            ];
          } else if (snapshot.hasError) {
            children = [
              IconButton(
                onPressed: () => null,
                // geoFuture(), //GoogleMapWidget(snapshot: snapshot),
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 17),
                child: Text(
                  "Something went wrong!",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ];
          } else {
            children = const [
              SizedBox(
                width: 60,
                height: 80,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17),
                child: Text(
                  "Loading Google Maps...",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
